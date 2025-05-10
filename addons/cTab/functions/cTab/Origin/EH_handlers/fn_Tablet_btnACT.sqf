#include "\MG8\AVFEVFX\macro.hpp"

params [["_info",""]];

//-Control Turret
if (_info isNotEqualTo "") exitWith {
	private ["_vehicle","_current_turret","_condition"];
	_vehicle = [] call BCE_fnc_get_TaskCurUnit;

	if (isNull _vehicle) exitWith {
		["UAV",localize "STR_BCE_Error_Vehicle",5] call cTab_fnc_addNotification;
	};

	(cTab_player getVariable ["TGP_View_Selected_Optic",[[],objNull]]) params [["_turret_info",["",[-1]]],"_vehicle"];

	_current_turret = _turret_info # 1;

	_condition = [
		false,
		call {
			private ["_return","_index"];
			_return = UAVControl _vehicle;
			_index = _return find "GUNNER";

			if (_index < 0) exitWith {false};

			(_return # (_index - 1)) isNotEqualTo cTab_player
		}
	] select (unitIsUAV _vehicle);

	if (
		!(isnull _vehicle) &&
		!(_condition) &&
		((_current_turret # 0) > -1) &&
		({!((_x getVariable ["TGP_View_Turret_Control", []]) isEqualTo [])} count (crew _vehicle) == 0) &&
		!((getText ([_vehicle, _current_turret] call BIS_fnc_turretConfig >> "turretInfoType")) in GUNNER_OPTICS)
	) then {
		//-delete PIP Cam && close TAD UI
		call cTab_fnc_deleteUAVcam;
		call cTab_fnc_close;

		[{
			params ["_vehicle"];
			[_vehicle,cameraview] call BCE_fnc_onButtonClick_Gunner;
			_vehicle call BCE_fnc_TGP_Select_Confirm;
		}, [_vehicle], 0.1] call CBA_fnc_WaitAndExecute;
	} else {

		["UAV",localize "STR_BCE_Error_ControlTurret",5] call cTab_fnc_addNotification;
	};
};

////////////////////////////////////////////////////////////////////////////
private _displayName = cTabIfOpen # 1;

//-Live Feed
private _View_Cam = {

	private _Selected_Optic = cTab_player getVariable ["TGP_View_Selected_Optic",[[],objNull]];

	if (isNil {_Selected_Optic # 0} || isNull (_Selected_Optic # 1)) exitWith {
		["UAV",localize "STR_BCE_Error_Vehicle",5] call cTab_fnc_addNotification;
	};

	private _vehicle = _Selected_Optic # 1;
	(_Selected_Optic # 0) params ["_camPosMemPt","_turret"];
	
	if (
		(_camPosMemPt != "") &&
		(
			!((getText ([_vehicle, _turret] call BIS_fnc_turretConfig >> "turretInfoType")) in GUNNER_OPTICS) ||
			((_turret # 0) < 0)
		)
	) then {
		//-delete PIP Cam && close TAD UI
		call cTab_fnc_deleteUAVcam;
		call cTab_fnc_close;
		[{
			params ["_vehicle"];
			_vehicle call BCE_fnc_TGP_Select_Confirm;
		}, [_vehicle], 0.1] call CBA_fnc_WaitAndExecute;
	} else {
		["UAV",localize "STR_BCE_Error_Vehicle",5] call cTab_fnc_addNotification;
	};
};

//-ATAK
if ("Android" in _displayName) exitWith {
	([_displayName,"showMenu"] call cTab_fnc_getSettings) params ["_mode","","",["_PgComponents",createHashMap]];
	private _hcam = [_displayName, "hcam"] call cTab_fnc_getSettings;
	private _c = _PgComponents param [0, [0,1] select (_hcam != "")];
	switch true do {
		//- Helmet CAM
		case (_mode == "VideoFeeds" && _c == 1): {
			558 cutRsc ['BCE_HCAM_View','PLAIN',0.3,false];
		};
		default {
			call _View_Cam;
		};
	};
};

private _mode = [_displayName,"mode"] call cTab_fnc_getSettings;

//- Other Interfaces
switch _mode do {
	case "UAV": {
		call _View_Cam;
	};
	case "TASK_Builder": {
		call _View_Cam;
	};
	case "HCAM": {
		["cTab_Tablet_dlg",[["mode","HCAM_FULL"]]] call cTab_fnc_setSettings;
	};
	case "HCAM_FULL": {
		["cTab_Tablet_dlg",[["mode","HCAM"]]] call cTab_fnc_setSettings;
	};
};

true
