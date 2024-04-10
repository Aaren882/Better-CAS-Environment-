#include "\MG8\AVFEVFX\cTab\has_cTab.hpp"
if (!hasInterface) exitWith {};

//- Init cache holder
private _map = createHashMap;
{
	_map set [_x , createHashMap];
} foreach ["BCE_Camera_Cache","BCE_IRLaser_Cache"];
localNamespace setVariable ["BCE_System_Caches", _map];
_map = nil;

TGP_View_Unit_List = [];
TGP_View_Marker_List = [];
TGP_View_TouchMark_List = [];
TGP_View_Camera = [];
TGP_View_Turret_List = [];

IR_LaserLight_UnitList = [];
IR_LaserLight_UnitList_LastUpdate = 0;
BCE_TGP_LastUpdate = 0;

if (isnil {BCE_SYSTEM_Handler}) then {
	BCE_SYSTEM_Handler = "";
};

private _mapCenter = worldSize / 2;
private _landmarks = ["NameVillage", "NameCity", "NameCityCapital", "NameLocal", "NameMarine", "Hill"];
BCE_LandMarks = (nearestLocations [
	[_mapCenter, _mapCenter],
	_landmarks,
	worldSize
]) apply {
	private ["_config","_tex","_pos","_color"];
	_config = configFile >> "CfgLocationTypes" >> type _x;
	_tex = getText (_config >> "texture");
	_pos = getPos _x;
	_color = (getArray (_config >> "color")) apply {
		[_x,1] select (_x == 0);
	};

	_color set [3,0.85];
	_pos set [2,0.5];

	[
		[_tex,"\a3\ui_f\data\Map\Markers\Military\dot_CA.paa"] select (_tex == ""),
		_color,
		_pos,
		text _x,
		(getNumber (_config >> "textSize")) min 0.04
	]
};

#if __has_include("\z\ace\addons\hearing\config.bin")
	BCE_have_ACE_earPlugs = false;
#endif
//ace_hearing_enableCombatDeafness = false;

["BCE_Init",BCE_fnc_init] call CBA_fnc_addEventHandler;

//PostInit
["BCE_Init",[]] call CBA_fnc_localEvent;

//-Add map eventhandler
addMissionEventHandler ["Map", {
	//- Refesh widgets infos
	if (_this # 0) then {
		[findDisplay 12, -1] call BCE_fnc_Update_MapCtrls;
	};
}];

#define SetTitle(A,B) (localize A) + (localize B)
#define IsPilot_CAM_ON ((player getVariable ["AHUD_Actived",-1]) != -1)
#define getTurret (call BCE_fnc_getTurret)
#define SwitchSound playSound (format ["switch_mod_0%1",(selectRandom [1,2,3,4,5])])
#define isCtrlTurret ({count (_x getVariable ["TGP_View_Turret_Control",[]]) > 0} count (crew _vehicle)) > 0
#define IsTGP_CAM_ON ((player getVariable ["TGP_View_EHs", -1]) != -1)

#ifdef cTAB_Installed
	[BCE_fnc_cTab_postInit, [], 1] call CBA_fnc_WaitAndExecute;
#endif

//- Optic Mode
[
	"Better CAS Environment (TGP)","OpticMode",
	localize "STR_BCE_Optic_Mode",
	{
		if (IsTGP_CAM_ON) then {
			SwitchSound;
			_n_counts = player getVariable ["TGP_View_Optic_Mode", 2];
			if (_n_counts == 5) then {
				_n_counts = 2;
				player setVariable ["TGP_View_Optic_Mode", 2];
			} else {
				_n_counts = _n_counts + 1;
				player setVariable ["TGP_View_Optic_Mode", _n_counts];
			};
			_n_counts call BCE_fnc_OpticMode;
		};
	},
	"",
	[0x31, [false, false, false]]
] call cba_fnc_addKeybind;

//- Exit
[
	"Better CAS Environment (TGP)","Exit",
	localize "STR_BCE_Exit_Camera",
	{
		if (IsTGP_CAM_ON) then {
			camUseNVG false;
			call BCE_fnc_Cam_Delete;
			[2] call BCE_fnc_OpticMode;
			if (isclass(configFile >> "CfgPatches" >> "A3TI")) then {
				if ((call A3TI_fnc_getA3TIVision) != "") then {
					uiNamespace setVariable ["A3TI_FLIR_VisionMode",-1];
					call A3TI_fnc_ppEffects
				};
			};
		};
	},
	"",
	[0x39, [false, false, false]],
	true
] call cba_fnc_addKeybind;

//- Zoom
[
	"Better CAS Environment (TGP)","ZoomIn",
	localize "STR_BCE_Zoom_In",
	{
		1 call BCE_fnc_Switch_Zoom;
	},
	"",
	[0x4E, [false, false, false]],
	true
] call cba_fnc_addKeybind;

[
	"Better CAS Environment (TGP)","ZoomOut",
	localize "STR_BCE_Zoom_Out",
	{
		-1 call BCE_fnc_Switch_Zoom;
	},
	"",
	[0x4A, [false, false, false]],
	true
] call cba_fnc_addKeybind;

//- Swich Turret
[
	"Better CAS Environment (TGP)","SwichView_L",
	localize "STR_BCE_Swich_View_Left",
	{
		if (IsTGP_CAM_ON) then {
			getTurret params ["_cam","_vehicle","_Optic_LODs","_current_turret"];
			if (count _Optic_LODs < 1) exitWith {};
			SwitchSound;
			if (count _Optic_LODs == 1) exitWith {};

			_current_turret = [_current_turret - 1,(count _Optic_LODs) - 1] select (_current_turret < 1);
			_turret_select = _Optic_LODs # _current_turret;
			_turret = _turret_select # 1;
			_turret_Unit = _vehicle turretUnit _turret;

			if ((isCtrlTurret) && ((_turret # 0) < 0)) exitWith {};

			//call BCE_fnc_UpdateCameraUI;
			_cam attachTo [_vehicle, [0,0,0],_turret_select # 0,!(_turret_select # 2)];
			player setVariable ["TGP_View_Selected_Optic",[_turret_select,_vehicle],true];

			//UI
			_gunner = [name _turret_Unit,"--"] select ((_turret_Unit isEqualTo objNull) || (name (driver _vehicle) == name _turret_Unit));
			((uiNameSpace getVariable "BCE_TGP") displayCtrl 1029) ctrlSetText (format ["Gunner: %1", _gunner]);
		};
	},
	"",
	[0xCB, [false, false, false]],
	true
] call cba_fnc_addKeybind;

[
	"Better CAS Environment (TGP)","SwichView_R",
	localize "STR_BCE_Swich_View_Right",
	{
		if (IsTGP_CAM_ON) then {
			getTurret params ["_cam","_vehicle","_Optic_LODs","_current_turret"];
			if (count _Optic_LODs < 1) exitWith {};
			SwitchSound;
			if (count _Optic_LODs == 1) exitWith {};

			_current_turret = [_current_turret + 1,0] select (_current_turret >= ((count _Optic_LODs) - 1));
			_turret_select = _Optic_LODs # _current_turret;
			_turret = _turret_select # 1;
			_turret_Unit = _vehicle turretUnit _turret;

			if ((isCtrlTurret) && ((_turret # 0) < 0)) exitWith {};

			//call BCE_fnc_UpdateCameraUI;
			_cam attachTo [_vehicle, [0,0,0],_turret_select # 0,!(_turret_select # 2)];
			player setVariable ["TGP_View_Selected_Optic",[_turret_select,_vehicle],true];

			//UI
			_gunner = [name _turret_Unit,"--"] select ((_turret_Unit isEqualTo objNull) || (name (driver _vehicle) == name _turret_Unit));
			((uiNameSpace getVariable "BCE_TGP") displayCtrl 1029) ctrlSetText (format ["Gunner: %1", _gunner]);
		};
	},
	"",
	[0xCD, [false, false, false]],
	true
] call cba_fnc_addKeybind;

//Optional
[
	"Better CAS Environment (TGP)","Unit_Tracker_Box",
	SetTitle("STR_BCE_Toggle","STR_BCE_Tracker_Box"),
	{
		if (IsTGP_CAM_ON || IsPilot_CAM_ON) then {
			SwitchSound;
			if (player getVariable ["TGP_view_Unit_Tracker_Box",true]) then {
				player setVariable ["TGP_view_Unit_Tracker_Box",false];
			} else {
				player setVariable ["TGP_view_Unit_Tracker_Box",true];
			};
		};
	},
	"",
	[0x16, [false, false, false]]
] call cba_fnc_addKeybind;

[
	"Better CAS Environment (TGP)","Unit_Tracker",
	SetTitle("STR_BCE_Toggle","STR_BCE_Unit_Tracker"),
	{
		if (IsTGP_CAM_ON || IsPilot_CAM_ON) then {
			SwitchSound;
			if (player getVariable ["TGP_view_Unit_Tracker",true]) then {
				player setVariable ["TGP_view_Unit_Tracker",false];
			} else {
				player setVariable ["TGP_view_Unit_Tracker",true];
			};
		};
	},
	"",
	[0x24, [false, false, false]]
] call cba_fnc_addKeybind;

[
	"Better CAS Environment (TGP)","Compass",
	SetTitle("STR_BCE_Toggle","STR_BCE_3D_Compass"),
	{
		if (IsTGP_CAM_ON || IsPilot_CAM_ON) then {
			SwitchSound;
			if (player getVariable ["TGP_view_3D_Compass",true]) then {
				player setVariable ["TGP_view_3D_Compass",false];
			} else {
				player setVariable ["TGP_view_3D_Compass",true];
			};
		};
	},
	"",
	[0x25, [false, false, false]]
] call cba_fnc_addKeybind;

[
	"Better CAS Environment (TGP)","Unit_MapIcon",
	SetTitle("STR_BCE_Toggle","STR_BCE_Map_Icon"),
	{
		if (IsTGP_CAM_ON) then {
			SwitchSound;
			if (player getVariable ["TGP_view_Map_Icon",true]) then {
				player setVariable ["TGP_view_Map_Icon",false];
			} else {
				player setVariable ["TGP_view_Map_Icon",true];
			};
		};
	},
	"",
	[0x26, [false, false, false]]
] call cba_fnc_addKeybind;

[
	"Better CAS Environment (TGP)","Unit_MapIcon_Aircraft",
	format ["%1 (%2)",SetTitle("STR_BCE_Toggle","STR_BCE_Map_Icon"),localize "str_dn_aircrafts"],
	{
		if (IsPilot_CAM_ON && ((player getVariable ["TGP_View_MapIcons_last",-1]) == -1)) then {
			_end = time + 3;
			[{
				params ["_end","_unit"];
				_last_time = _end - time;
				_unit setVariable ["TGP_View_MapIcons_last",_last_time];
				(time >= _end)
				}, {
					params ["_end","_unit"];
					if (time >= _end) then {
						_unit setVariable ["TGP_View_MapIcons",[]];
						_unit setVariable ["TGP_View_MapIcons_last",-1];
					};
				}, [_end,player]
			] call CBA_fnc_waitUntilAndExecute;
		};
	},
	"",
	[0x26, [false, false, false]]
] call cba_fnc_addKeybind;

[
	"Better CAS Environment (TGP)","LandMark_Icon",
	SetTitle("STR_BCE_Toggle","STR_BCE_LandMark_Icon"),
	{
		if (IsTGP_CAM_ON || IsPilot_CAM_ON) then {
			SwitchSound;
			if (player getVariable ["TGP_view_LandMark_Icon",true]) then {
				player setVariable ["TGP_view_LandMark_Icon",false];
			} else {
				player setVariable ["TGP_view_LandMark_Icon",true];
			};
		};
	},
	"",
	[0x27, [false, false, false]]
] call cba_fnc_addKeybind;

[
	"Better CAS Environment (TGP)","NextWeapon",
	localize "STR_BCE_Next_Weapon_Setup",
	{
		if !(IsTGP_CAM_ON) exitWith {};
		_vehicle = (player getVariable "TGP_View_Selected_Optic") # 1;
		_current_turret = ((player getVariable "TGP_View_Selected_Optic") # 0) # 1;
		_turret_Unit = _vehicle turretUnit _current_turret;
		if !((_turret_Unit getVariable ["TGP_View_Turret_Control",[]]) isEqualTo []) then {
			SwitchSound;

			//Switch Weapon Setup
			_weapon_info = weaponState [_vehicle,_current_turret];
			_selectWeapon = _weapon_info # 0;
			_selectMuzzle = _weapon_info # 1;
			_selectmode = _weapon_info # 2;

			//-Modes
			_modes = (getarray (configFile >> "CfgWeapons" >> _selectWeapon >> "modes")) select {
				(getNumber (configFile >> "CfgWeapons" >> _selectWeapon >> _x >> "showToPlayer")) == 1
			};
			_mode_Index = _modes find (_weapon_info # 2);

			_Muzzles = getarray (configFile >> "CfgWeapons" >> _selectWeapon >> "muzzles");
			_Muzzle_Index = _Muzzles find _selectMuzzle;

			if (_mode_Index >= ((count _modes) - 1)) then {

				//Get Weapons
				_weapons = _vehicle weaponsTurret _current_turret;
				_Weapon_Index = _weapons find _selectWeapon;

				//Dont Have other muzzle
				if ((_selectMuzzle == "this") || (_selectMuzzle == _selectWeapon)) then {

					//-Select Weapon
					if (_Weapon_Index >= ((count _weapons) - 1)) then {
						_selectWeapon = _weapons # 0;
					} else {
						_selectWeapon = _weapons # (_Weapon_Index + 1);
					};

					//-Set Muzzle
					_Muzzles = getarray (configFile >> "CfgWeapons" >> _selectWeapon >> "muzzles");
					if ((count _Muzzles) == 1) then {
						_selectMuzzle = _selectWeapon;
					} else {
						_selectMuzzle = _Muzzles # 0;
					};
				} else {
					if (_Muzzle_Index >= ((count _Muzzles) - 1)) then {

						//-Select Weapon
						if (_Weapon_Index >= ((count _weapons) - 1)) then {
							_selectWeapon = _weapons # 0;
						} else {
							_selectWeapon = _weapons # (_Weapon_Index + 1);
						};
						_Muzzles = getarray (configFile >> "CfgWeapons" >> _selectWeapon >> "muzzles");
						_selectMuzzle = _Muzzles # 0;

					} else {
						_selectMuzzle = _Muzzles # (_Muzzle_Index + 1);
					};
				};
				_modes = (getarray (configFile >> "CfgWeapons" >> _selectWeapon >> "modes")) select {
					(getNumber (configFile >> "CfgWeapons" >> _selectWeapon >> _x >> "showToPlayer")) == 1
				};

				_selectMode = _modes # 0;
			} else {
				_selectMode = _modes # (_mode_Index + 1);
			};

			// - Debug
			_Muzzles = getarray (configFile >> "CfgWeapons" >> _selectWeapon >> "muzzles");
			if ((_selectMuzzle == "this") || (_selectMuzzle == _selectWeapon)) then {
				_selectMuzzle = _selectWeapon;
			};
			if (isnil{_selectMode}) then {
				_selectMode = _selectWeapon;
			};

			_vehicle selectWeaponTurret [_selectWeapon,_current_turret,_selectMuzzle,_selectMode];

		};
	},
	"",
	[0x21, [false, false, false]]
] call cba_fnc_addKeybind;

[
	"Better CAS Environment (TGP)","TouchMark",
	localize "STR_BCE_Set_Touch_Marker",
	{
		if (!(IsTGP_CAM_ON) || (isNull findDisplay 1022553)) exitWith {};
		_list = allUnits select {
			((_x getVariable ["AHUD_Actived",-1]) != -1) || ((_x getVariable ["TGP_View_EHs",-1]) != -1)
		};
		[selectRandom ["TacticalPing2","TacticalPing3","TacticalPing4"]] remoteExecCall ["playSound",_list,true];

		_vehicle = (player getVariable "TGP_View_Selected_Optic") # 1;
		_current_turret = ((player getVariable "TGP_View_Selected_Optic") # 0) # 1;
		if (_current_turret isEqualTo []) then {_current_turret = [-1]};
		_turret_Unit = _vehicle turretUnit _current_turret;

		if ((_turret_Unit getVariable ["TGP_View_Turret_Control",[]]) isEqualTo []) then {
			player setVariable ["TGP_View_Mark", (screenToWorld getMousePosition),true];
			_pos_old = player getVariable ["TGP_View_Mark",[]];
			_end = time + 3;
			[{
				params ["_end","_pos_old","_unit"];
				_last_time = _end - time;
				_unit setVariable ["TGP_View_Marker_last",_last_time,true];
				((time >= _end) || !(_pos_old isEqualTo (_unit getVariable "TGP_View_Mark")))
				}, {
					params ["_end","_pos_old","_unit"];
					/* if (time >= _end) then {
						_unit setVariable ["TGP_View_Marker_last",-1,true];
					}; */
				}, [_end,_pos_old,player]
			] call CBA_fnc_waitUntilAndExecute;
		};
	},
	"",
	[0xF0, [false, false, false]]
] call cba_fnc_addKeybind;

[
	"Better CAS Environment (TGP)","ToggleCursor",
	SetTitle("STR_BCE_Toggle","STR_BCE_Mouse_Cursor"),
	{
		if !(IsTGP_CAM_ON) exitWith {};
		_vehicle = (player getVariable "TGP_View_Selected_Optic") # 1;
		_current_turret = ((player getVariable "TGP_View_Selected_Optic") # 0) # 1;
		_turret_Unit = _vehicle turretUnit _current_turret;
		if (((_turret_Unit getVariable ["TGP_View_Turret_Control",[]]) isEqualTo []) && (isNull findDisplay 1022553)) then {
			createdialog "RscDisplayEmpty_BCE";
			setMousePosition [0.5, 0.5];
			player setVariable ["TGP_view_Mouse_Cursor",true];
			SwitchSound;
		} else {
			if !(isNull findDisplay 1022553) then {
				closedialog 1022553;
				player setVariable ["TGP_view_Mouse_Cursor",false];
				SwitchSound;
			};
		};
	},
	"",
	[0x32, [false, false, false]]
] call cba_fnc_addKeybind;
