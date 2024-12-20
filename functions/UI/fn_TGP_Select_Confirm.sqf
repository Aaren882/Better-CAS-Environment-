#include "\MG8\AVFEVFX\cTab\has_cTab.hpp"
params ["_vehicle"];

private _player = player;
if ((_player getVariable ["TGP_View_EHs", -1]) != -1) exitWith {};

#define Equal isEqualTo
#if __has_include("\z\ace\addons\hearing\config.bin")
	#define have_ACE 1
#endif

_cam = "camera" camCreate [0,0,0];
_cam cameraEffect ["Internal", "Back"];
cameraEffectEnableHUD true;
showCinemaBorder false;

#ifdef have_ACE
	if (ace_hearing_enableCombatDeafness) then {
		BCE_have_ACE_earPlugs = _player getVariable ["ACE_hasEarPlugsin", false];
		_player setVariable ["ACE_hasEarPlugsIn", true, true];

		[true] call ace_hearing_fnc_updateVolume;
		[] call ace_hearing_fnc_updateHearingProtection;
	} else {
		0 fadeSound 0.1;
	};
#else
	0 fadeSound 0.1;
#endif
TGP_View_Unit_List = [];

//PP Effect
_pphandle = ppEffectCreate ["FilmGrain", 1501];
_pphandle ppEffectEnable true;
_pphandle ppEffectAdjust [BCE_CamNoise_sdr, 1, 0, [1.0, 0.1, 1.0, 0.75], [0.0, 1.0, 1.0, 1.0], [0.199, 0.587, 0.114, 0.0]];
_pphandle ppEffectCommit 0;

_config_path = configOf _vehicle;

_Optic_LODs = [_vehicle,0] call BCE_fnc_Check_Optics;

if (((_player getVariable ["TGP_View_Selected_Optic",[]]) findIf {true} > -1) || !(_vehicle Equal ((_player getVariable "TGP_View_Selected_Optic") # 1))) then {
	_player setVariable ["TGP_View_Selected_Optic",[(_Optic_LODs # 0),_vehicle],true];
};

_Selected_Optic = (_player getVariable "TGP_View_Selected_Optic") # 0;
_Selected_Optic params ["","_turret","_is_Detached"];

//- Setup Camera
_cam attachTo [_vehicle, [0,0,0],_Selected_Optic # 0,!_is_Detached];
TGP_View_Camera = [_cam,_pphandle];

//UI setup
556 cutRsc ["BCE_TGP_View_GUI","PLAIN",0.3,false];
cutText ["", "BLACK IN",0.5];

localNamespace setVariable ["TGP_View_laser_update", [time,""]];

//Crews
_turret_Unit = _vehicle turretUnit _turret;

_gunner = [name _turret_Unit,"--"] select (((_turret_Unit Equal objNull) || (_turret_Unit Equal (driver _vehicle))));
_pilot = [name (driver _vehicle),"--"] select ((driver _vehicle) Equal objNull);

//-Controls
_display = uiNameSpace getVariable "BCE_TGP";
_time_ctrl = _display displayCtrl 1001;
_Altitude_ctrl = _display displayCtrl 1002;
_Grid_ctrl = _display displayCtrl 1003;
_vision_ctrl = _display displayCtrl 1005;
_Laser_ctrl = _display displayCtrl 1023;
_camDir_ctrl = _display displayCtrl 1024;
_Fuel_ctrl = _display displayCtrl 1026;
_Weapon_ctrl = _display displayCtrl 1027;
_Ammo_ctrl = _display displayCtrl 1031;
_Mode_ctrl = _display displayCtrl 1032;

//- Widgets
_widgets_ctrl = _display displayCtrl 2000;
_Exit_ctrl = _display displayCtrl 2025;
_widget_01_ctrl = _Widgets_ctrl controlsGroupCtrl 100;
_env_ctrl = _display displayCtrl 101;

//- Weapon
_WeaponDelay_ctrl = _display displayCtrl 1033;
_WeaponDelay_ctrl ctrlShow false;

//- ENG
_ENG_W_ctrl = _display displayCtrl 1025;

_pilot_ctrl = _display displayCtrl 1028;
_Gunner_ctrl = _display displayCtrl 1029;
_Vehicle_ctrl = _display displayCtrl 1030;

//- UI
_pilot_ctrl ctrlSetText (format ["%1: %2", localize "str_position_pilot", _pilot]);
_Gunner_ctrl ctrlSetText (format ["%1: %2",localize "STR_GUNNER", _gunner]);
_Vehicle_ctrl ctrlSetText (getText (_config_path >> "DisplayName"));

//-widgets
_widgets_01 = [
	["Unit_Tracker_Box","TGP_view_Unit_Tracker_Box","STR_BCE_Tracker_Box"],
	["Unit_Tracker","TGP_view_Unit_Tracker","STR_BCE_Unit_Tracker"],
	["Compass","TGP_view_3D_Compass","STR_BCE_3D_Compass"],
	["Unit_MapIcon","TGP_view_Map_Icon","STR_BCE_Map_Icon"],
	["LandMark_Icon","TGP_view_LandMark_Icon","STR_BCE_LandMark_Icon"],
	["ToggleCursor","TGP_view_Mouse_Cursor","STR_BCE_Mouse_Cursor",false]
];

{
	_x params ["_action","_var","_text",["_default",true]];
	private ["_key","_index","_color"];

	_key = (["Better CAS Environment (TGP)", _action] call CBA_fnc_getKeybind) # -1 # 0;
	_index = _widget_01_ctrl lbAdd format ['%1 "%2"', localize _text, _key call CBA_fnc_localizeKey];

	_widget_01_ctrl lbSetPicture [_index,"\a3\ui_f\data\Map\Markers\Military\dot_CA.paa"];

	_color = [
		[1, 0, 0, 1],
		[1, 1, 1, 1]
	] select (player getVariable [_var,_default]);

	_widget_01_ctrl lbSetPictureColor [_forEachIndex, _color];
	_widget_01_ctrl lbSetColor [_forEachIndex, _color];
} foreach _widgets_01;

//-Set Exit Hint
_Exit_ctrl ctrlSetText format [localize "STR_BCE_Press_key" + " " + localize "STR_BCE_Exit_Camera", ((["Better CAS Environment (TGP)", "Exit"] call CBA_fnc_getKeybind) # -1 # 0) call CBA_fnc_localizeKey];

//-Set Environment condition List
[BCE_fnc_Set_EnvironmentList, [_env_ctrl,lbSize _env_ctrl - 1], 0] call CBA_fnc_waitAndExecute;


//- If is on Pilot seat + Has PilotCamera
_getTargetVeh = [{
	private _return = _vehicle lockedCameraTo (_vehicle unitTurret _player);
	[objNull, _return] select (_return isEqualType objNull);
}, {
	(getPilotCameraTarget _vehicle) # 2
}] select ((_turret # 0) < 0);

//Draw Icons And Set DirUp
_idEH = addMissionEventHandler ["Draw3D", {
	_thisArgs params [
		"_cam","_vehicle",
		"_current_vec","_delta",
		"_Optic_LODs","_player","_getTargetVeh",
		"_DrawArgs"
	];
	_DrawArgs params ["_time_ctrl","_Altitude_ctrl","_Grid_ctrl","_vision_ctrl","_Laser_ctrl","_camDir_ctrl","_Fuel_ctrl","_Weapon_ctrl","_Ammo_ctrl","_Mode_ctrl","_ENG_W_ctrl","_widget_01_ctrl","_widgets_01"];

	((_player getVariable "TGP_View_Selected_Optic") # 0) params ["_TGP","_turret","_is_Detached"];

	//-Output TGP Dir || Current Tracking Target (For current controlling vehicle only)
	if (_is_Detached) then {
		private _wRot = [{
			{[_vehicle,_turret] call BCE_fnc_getTurretDir}
		}, {
			private _var = (_vehicle getVariable ["BCE_Camera_Info_Air",["[]","[0,0,0]",objNull]]);

			//-Check if is point track
			[
				_var # 2,
				parseSimpleArray (_var # 1)
			] select isNull (_var # 2);

		}] select ((_turret # 0) < 0);

		//- Rotate the Camera
		[_cam, call _wRot, false] call BCE_fnc_VecRot;
	};

	//-A3TI
	_visionType = _player getVariable ["TGP_View_Optic_Mode", 2];
	#if __has_include("\A3TI\functions.hpp")
		_A3TI = call A3TI_fnc_getA3TIVision;
		if (_visionType == 2) then {
			_vision_ctrl ctrlSetText ([localize "STR_BCE_CMODE",[_A3TI, "NORMAL"] select (isnil {_A3TI})] joinString " ");
		};
	#endif

	//UI Update
	_time_ctrl ctrlSetText (format [localize "STR_BCE_Cam_Time",[daytime] call BIS_fnc_timeToString]);
	_Altitude_ctrl ctrlSetText (format [localize "STR_BCE_Cam_Altitude",Round ((getPosASL _vehicle) # 2)]);
	_Grid_ctrl ctrlSetText (format [localize "STR_BCE_Cam_Grid",mapGridPosition (screenToWorld [0.5,0.5])]);
	_camDir_ctrl ctrlSetText (([getDirVisual _cam,3] call CBA_fnc_formatNumber) + "°");
	_Fuel_ctrl ctrlSetText (format [localize "STR_BCE_Cam_Fuel", round ((fuel _vehicle) * 100),"%"]);
	_Engine_damage = _vehicle getHitPointDamage "hitEngine";

	//Engine
	_color = if (_Engine_damage > 0) then {
		[
			[0.94,0.7,0,1],
			[1,0,0,1]
		] select (_Engine_damage >= 0.5)
	} else {
		[1,1,1,1]
	};
	_ENG_W_ctrl ctrlSetTextColor _color;

	if (isNull findDisplay 1022553) then {
		player setVariable ["TGP_view_Mouse_Cursor",false];
	};

	//-Widgets
	{
		_x params ["","_var","",["_default",true]];
		private _color = [
			[1, 0, 0, 1],
			[1, 1, 1, 1]
		] select (player getVariable [_var,_default]);
		_widget_01_ctrl lbSetPictureColor [_forEachIndex, _color];
		_widget_01_ctrl lbSetColor [_forEachIndex, _color];
	} foreach _widgets_01;

	//currentWeapon
	_weapon_info = weaponState [_vehicle,_turret];
	_weapon_info params ["_infoWeapon", "_infomuzzle", "_infomode", "_infomagazine", "_ammoCount", "_roundReloadPhase", "_magazineReloadPhase"];

	//-Ammo Count
	_count = ({
		_x params ["_m","_c"];
		(_m == _infomagazine) && (_c > 0)
	} count (magazinesAmmo [_vehicle, true])) max 1;

	_ammoCount = _count * _ammoCount;

	_Weapon_ctrl ctrlSetText getText (configFile >> "CfgWeapons" >> _infoWeapon >> "DisplayName");
	if ((getText (configFile >> "CfgWeapons" >> _infoWeapon >> "DisplayName") == "") || ("laserdesignator" in (tolower _infoWeapon))) then {
		_Mode_ctrl ctrlSetText "";
		_Ammo_ctrl ctrlSetText "";
	} else {
		_Mode_ctrl ctrlSetText (format ["%1: %2", localize "str_a3_firemode1", getText (configFile >> "CfgWeapons" >> _infoWeapon >> _infomode >> "DisplayName")]);
		_Ammo_ctrl ctrlSetText (format ["%1: %2	%3",localize "STR_DISP_ARCUNIT_AMMO", getText (configFile >> "CfgMagazines" >> _infomagazine >> "displayNameShort"), _ammoCount]);
	};

	_Weapon_ctrl ctrlSetTextColor ([[1,1,1,1],[0.76,0.71,0.215,1]] select ((_roundReloadPhase > 0) || (_magazineReloadPhase > 0)));

	//Laser
	if (_vehicle isLaserOn _turret) then {
		private _laser_Vars = localNamespace getVariable "TGP_View_laser_update";
		if ((_laser_Vars # 0) <= time) then {
			localNamespace setVariable ["TGP_View_laser_update", [
				time + 0.2,
				["", "L T D / R"] select ((_laser_Vars # 1) Equal "")
			]];
			_Laser_ctrl ctrlSetText (_laser_Vars # 1);
		};
	} else {
		_Laser_ctrl ctrlSetText "";
	};

	//Update UnitList
	if (missionNamespace getVariable ["TGP_View_Unit_List_update",-1] <= time) then {
		call BCE_fnc_TGP_UnitList;
		missionNamespace setVariable ["TGP_View_Unit_List_update", time+1];
	};

	if (_player getVariable ["TGP_view_3D_Compass",true]) then {
		private _objVeh = call _getTargetVeh;
		call BCE_fnc_3DCompass;
	};

	if (count TGP_View_Unit_List > 0) then {
		private _friendlyActive = true;
		private _boxActive = true;
		call BCE_fnc_Unit_Icon;
	};
	if (_player getVariable ["TGP_view_Map_Icon",true]) then {
		private _alpha = 0.4;
		call BCE_fnc_map_Icon;
	};
	if (_player getVariable ["TGP_view_LandMark_Icon",true]) then {
		call BCE_fnc_LandMarks_icon;
	};

	if (BCE_touchMark_fn) then {
		call BCE_fnc_touchMark;
	};

	call BCE_fnc_Cam_Layout;

	//-Only can show Display instead dialog
	#ifdef cTAB_Installed
		#define exitCdt !(isnull curatorcamera) || (isnil{if (isnil {cTabIfOpen}) then {""} else {["",nil] select ([cTabIfOpen select 1] call cTab_fnc_isDialog);};})
	#else
		#define exitCdt !(isnull curatorcamera)
	#endif

	//-Exit
	if (!(alive _vehicle) || exitCdt) then {
		if !(TGP_View_Camera Equal []) then {
			camUseNVG false;

			//-Except for Zeus camera
			if (isnull curatorcamera) then {
				private _cam = TGP_View_Camera # 0;
				_cam cameraeffect ["Terminate", "back"];
				camDestroy _cam;
			};

			ppEffectDestroy (TGP_View_Camera # 1);

			556 cutRsc ["default","PLAIN"];
			cutText ["", "BLACK IN",0.5];

			#ifdef have_ACE
				if !(BCE_have_ACE_earPlugs) then {
					_player setVariable ["ACE_hasEarPlugsIn", false, true];
					[true] call ace_hearing_fnc_updateVolume;
					[] call ace_hearing_fnc_updateHearingProtection;
				};
			#else
				1.5 fadeSound 1;
			#endif

			TGP_View_Camera = [];

			[2] call BCE_fnc_OpticMode;
		};

		private _current_EH = _player getVariable ["TGP_View_EHs",-1];
		if (_current_EH != -1) then {
			removeMissionEventHandler ["Draw3D", _thisEventHandler];
			_player setVariable ["TGP_View_EHs",-1,true];
		};
	};
},[
	_cam,_vehicle,[[0,0,0],[0,0,0]],0.035,_Optic_LODs,_player,_getTargetVeh,
	[_time_ctrl,_Altitude_ctrl,_Grid_ctrl,_vision_ctrl,_Laser_ctrl,_camDir_ctrl,_Fuel_ctrl,_Weapon_ctrl,_Ammo_ctrl,_Mode_ctrl,_ENG_W_ctrl,_widget_01_ctrl,_widgets_01]
]];

_player setVariable ["TGP_View_EHs",_idEH,true];
0 call BCE_fnc_Switch_Zoom;

//-Set Camera Vision Mode
_visionMode = _player getVariable ["TGP_View_Optic_Mode",2];
#if __has_include("\A3TI\functions.hpp")
	_A3TI = A3TI_FLIR_VisionMode;
	_visionMode = [_visionMode,_A3TI] select (_A3TI > -1);
#endif
_visionMode call BCE_fnc_OpticMode;