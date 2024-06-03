#include "\MG8\AVFEVFX\macro.hpp"
/*
	Name: cTab_fnc_createUavCam

	Author(s):
		Gundy

	Edit:
		Aaren

	Description:
		Set up UAV camera and display on supplied render target
		Modified to include lessons learned from KK's excellent tutorial: http://killzonekid.com/arma-scripting-tutorials-uav-r2t-and-pip/

	Parameters:
		0: STRING - Name of UAV (format used from `str uavObject`)
		1: ARRAY	- List of arrays with seats with render targets
			0: INTEGER - Seat
				0 = DRIVER
				1 = GUNNER
			1: STRING	- Name of render target

	Returns:
		BOOLEAN - If UAV cam could be set up or not

	Example:
		[str _uavVehicle,[[0,"rendertarget8"],[1,"rendertarget9"]]] call cTab_fnc_createUavCam;
*/
params ["_veh","_uavCams","_UAV_Interface"];
private ["_veh","_displayName","_display","_squad_list","_seat_info","_PIP_IDC","_PIP_Ctrl","_Optic_LODs","_Selected_Optic","_turrets","_isEmpty","_renderTarget","_data","_seat","_veh","_uavCams","_seatName","_camPosMemPt","_cam","_turrets"];

_displayName = cTabIfOpen # 1;
_display = uiNamespace getVariable _displayName;
_squad_list = _display displayCtrl ([17000 + 1785,20116] select _UAV_Interface);
_seat_info = _display displayCtrl (17000 + 46320);

_PIP_IDC = if (_UAV_Interface) then {
	[1773, 17000 + 4632] select ("Android" in _displayName)
} else {
	17000 + 1786
};
_PIP_Ctrl = _display displayCtrl _PIP_IDC;

// remove exisitng UAV cameras
call cTab_fnc_deleteUAVcam;

// exit if requested UAV is not alive/is null
if !(alive _veh) exitWith {false};

_Optic_LODs = [_veh,0] call BCE_fnc_Check_Optics;
_Selected_Optic = cTab_player getVariable ["TGP_View_Selected_Optic",[[],objNull]];
_turrets = _Optic_LODs apply {((_x # 1) # 0) + 1};

_isEmpty = ((cTab_player getVariable ["TGP_View_Selected_Optic",[]]) isEqualTo []) || (_veh isNotEqualTo (_Selected_Optic # 1));

if (_isEmpty) then {
	cTab_player setVariable ["TGP_View_Selected_Optic",[(_Optic_LODs # 0),_veh],true];
};

_Selected_Optic = cTab_player getVariable "TGP_View_Selected_Optic";

//- Exit if AV have no turret
if (isNil {_Selected_Optic # 0}) exitWith {
	_PIP_Ctrl ctrlShow false;
	_seat_info ctrlSetText "--";
	false
};

_uavCams apply {
	private ["_cam","_camPosMemPt","_is_Detached","_turret","_vision","_FOVs","_FOV"];
	_x params ["_seat","_renderTarget"];

	(_Selected_Optic # 0) params ["_camPosMemPt","_turret","_is_Detached"];
	
	//-Set Turret Name
	if (_displayName in ["cTab_Android_dlg","cTab_Android_dsp"]) then {
		private ["_turret_txt"];
		_turret_txt = getText ([_veh, _turret] call BIS_fnc_turretConfig >> "gunnerName");
		_turret_txt = if (alive _veh) then {
			[_turret_txt,localize "STR_DRIVER"] select (_turret_txt == "")
		} else {
			"--"
		};
		_seat_info ctrlSetText _turret_txt;
	};

	//- Set Camera
	if (
		!isNil {_seat} &&
		(_camPosMemPt != "") && // If memory points could be retrieved, create camera
		(
			!((getText ([_veh, _turret] call BIS_fnc_turretConfig >> "turretInfoType")) in GUNNER_OPTICS) ||
			((_turret # 0) < 0)
		)
	) then {
		_PIP_Ctrl ctrlShow true;

		_cam = "camera" camCreate [0,0,0];
		_cam attachTo [_veh,[0,0,0],_camPosMemPt,!_is_Detached];

		// set up cam on render target
		_cam cameraEffect ["INTERNAL","BACK",_renderTarget];

		_vision = cTab_player getVariable ["TGP_View_Optic_Mode", 2];
		#if __has_include("\A3TI\config.bin")
			private _A3TI = A3TI_FLIR_VisionMode;
		#endif

		//-Set Vision Mode
		_vision = switch (true) do {
			#if __has_include("\A3TI\config.bin")
				case (_vision == 5 || _A3TI == 0): {2};
				case (_vision == 4 || _A3TI == 1): {7};
			#else
				case (_vision == 5): {2};
				case (_vision == 4): {7};
			#endif

			case 3: {1};
			default {0};
		};

		_renderTarget setPiPEffect [_vision];

		//- Setup camera FOV
		_config = if ((_turret # 0) < 0) then {
			configOf _veh >> "PilotCamera" >> "OpticsIn"
		} else {
			[_veh, _turret] call BIS_fnc_turretConfig >> "OpticsIn"
		};
		_FOVs = ("true" configClasses _config) apply {
			if (isText (_x >> "initFov")) then {
				call compile getText (_x >> "initFov")
			} else {
				getNumber(_x >> "initFov")
			};
		};
		_FOVs sort false;

		_FOV = _FOVs find (localNamespace getVariable ["TGP_View_Camera_FOV",_FOVs # 0]);
		_FOV = _FOVs # ([_FOV,0] select (_FOV < 0));

		_cam camSetFov _FOV;
		
		// -Store Cameras
		cTabUAVcams pushBack [_renderTarget,_cam,_camPosMemPt,_turret,_is_Detached];
	} else {
		_PIP_Ctrl ctrlShow false;
	};

	nil
};

//-Crew List
if !(isNull _squad_list) then {
	lbClear _squad_list;

	{
		private ["_unit_x","_seat","_turret_c","_turret_Index","_name","_freq","_radioInfo","_add","_turret_info","_unit_info","_title"];
		_unit_x = _x;
		_turret_c = _veh unitTurret _unit_x;
		_turret_Index = _Optic_LODs findIf {_turret_c in _x};
		_seat = getText ([_veh, _turret_c] call BIS_fnc_turretConfig >> "gunnerName");
		_name = ((name _unit_x) splitString " ") # 0;
		_add = _squad_list lbAdd format ["%1 - %2",[_seat,localize "STR_DRIVER"] select (_seat == ""),_name];

		_turret_info = if (((_turret_Index > -1) && (count _turrets > 0))) then {
			_Optic_LODs # _turret_Index
		} else {
			nil
		};

		//-if it's a pilot -> "yellow Color"
		if (_seat == "") then {
			_squad_list lbSetSelectColor [_add,[1, 1, 0, 1]];
			_squad_list lbSetSelectColorRight [_add,[1, 1, 0, 1]];
		};

		//-get UNIT info
		_unit_info = [_unit_x,_turret_info] call BCE_fnc_getUnitParams;

		#if __has_include("\z\tfar\addons\core\script_component.hpp")
			_freq = _unit_x call BCE_fnc_getFreq_TFAR;
			_squad_list lbSetTextRight [_add, "LR-" + ([_freq,"“NA”"] select (isnil {_freq}))];
		#else
			_squad_list lbSetTextRight [_add, _unit_info # 1];
		#endif
		_squad_list lbSetData [_add, str _unit_info];

	} forEach flatten ((crew _veh) select {(_veh unitTurret _x) in ([[-1]] + allTurrets _veh)});

	//-set selected Turret Unit
	if (_isEmpty or ((lbCurSel _squad_list) < 0)) then {
		if (lbsize _squad_list > 0) then {
			_squad_list lbSetCurSel ([0,(_Optic_LODs find (_Selected_Optic # 0))] select (count _turrets > 0));
		} else {
			(_display displayctrl 20114) ctrlSetStructuredText parseText "NA";
		};
	} else {
		(call compile (_squad_list lbData (lbCurSel _squad_list))) params ["","_unit"];
		(_display displayctrl 20114) ctrlSetStructuredText parseText format ["[%1]",_unit];
	};
};

// set up event handler
if (count cTabUAVcams > 0) exitWith {
	//-Only Detach ones need this
	if ((cTab_player getVariable ["cTab_TGP_View_EH",-1]) == -1) then {

		private _EH = if ((cTabUAVcams findIf {_x # 4}) > -1) then {
			addMissionEventHandler ["Draw3D",{
				_veh = _thisArgs # 0;

				if (alive _veh) then {
					(cTabUAVcams select {_x # 4}) apply {
						_x params ["","_cam","","_turret","_is_Detached"];

						if (_is_Detached) then {
							private _dir = [
							 [_veh,_turret] call BCE_fnc_getTurretDir,
							 call compile ((_veh getVariable ["BCE_Camera_Info_Air",["[]","[0,0,0]"]]) # 1)
							] select ((_turret # 0) < 0);
							[_cam, _dir, false] call BCE_fnc_VecRot;
						};
					};
				} else {
					call cTab_fnc_deleteUAVcam;
				};
			},[_veh]];
		} else {
			-2
		};

		cTab_player setVariable ["cTab_TGP_View_EH",_EH,true];
	};

	cTabActUav = _veh;
	true
};

false
