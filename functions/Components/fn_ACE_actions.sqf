#include "\MG8\AVFEVFX\macro.hpp"
#define aceAction ace_interact_menu_fnc_createAction
#define aceActionClass ace_interact_menu_fnc_addActionToClass
#define getOpticVars ([vehicle _unit,0] call BCE_fnc_Check_Optics)
#define SpotLight_Condition (_condition && ((getText ([(vehicle _unit), ((vehicle _unit) unitTurret _unit)] call BIS_fnc_turretConfig >> "turretInfoType")) in GUNNER_OPTICS) && (((vehicle _unit) unitTurret _unit) in (getOpticVars apply {_x select 1})))
#define Laser_Condition (_condition && ((getText ([(vehicle _unit), ((vehicle _unit) unitTurret _unit)] call BIS_fnc_turretConfig >> "turretInfoType")) in GUNNER_OPTICS) && (((vehicle _unit) unitTurret _unit) in (getOpticVars apply {_x select 1})))
#define SetTitle(A,B) (localize A) + (localize B)

private ["_action"];

//-Clear
_action = ["BCE_Task_Clear",localize "str_disp_arcmap_clear","\MG8\AVFEVFX\data\ClearTask.paa",{
	params ["_unit"];
	557 cutRsc ["default","PLAIN"];
	(vehicle _unit) setVariable ["BCE_Task_Receiver","",true];
},{
	params ["_unit"];
	(((vehicle _unit) getVariable ['BCE_Task_Receiver',""]) != "")
}] call aceAction;

["CAManBase", 1, ["ACE_SelfActions","BCE_Task_Receiver"], _action, true] call aceActionClass;

//-Slew to TG
_action = ["BCE_Task_Slew",localize "STR_BCE_Slew_TG","",{
	params ["_unit"];
	private ["_vehicle","_type","_task","_turret"];
	_vehicle = vehicle _unit;
	_turret = _unit call CBA_fnc_turretPath;
	(call compile (_vehicle getVariable 'BCE_Task_Receiver')) params ["","_type","_task"];

	_POS = switch _type do {
		case 5: {
			_task # 2 # 2
		};
		default {
			_task # 6 # 2
		};
	};

	if (_turret isEqualTo []) then {
		_vehicle setPilotCameraTarget (AGLToASL _POS);
	} else {
		_vehicle lockCameraTo [AGLToASL _POS, _turret, true];
	};

},{
	params ["_unit"];
	(((vehicle _unit) getVariable ['BCE_Task_Receiver',""]) != "")
}] call aceAction;

["CAManBase", 1, ["ACE_SelfActions","BCE_Task_Receiver"], _action, true] call aceActionClass;

//-Show
_action = ["BCE_Task_Show",localize "str_ca_show","\a3\ui_f\data\Map\Diary\Icons\diaryLocateTask_ca.paa",{
	params ["_unit"];
	557 cutRsc ["BCE_Task_Receiver","PLAIN",0.3,false];
	private _mode = [-1, 0] select (((vehicle _unit) getVariable ['BCE_Task_Receiver',""]) == "");
	_mode call BCE_fnc_UpdateTaskInfo;
},{
	params ["_unit"];
	(isnull (uiNamespace getVariable ['BCE_Task_Receiver', displayNull])) && 
	(
		(((vehicle _unit) getVariable ['BCE_Task_Receiver',""]) != "") ||
		alive ([_unit] call BCE_fnc_get_TaskCurUnit)
	)
}] call aceAction;

["CAManBase", 1, ["ACE_SelfActions","BCE_Task_Receiver"], _action, true] call aceActionClass;

//-Hide
_action = ["BCE_Task_Hide",localize "str_ca_hide","",{
	params ["_unit"];
	557 cutRsc ["default","PLAIN"];

},{
	params ["_unit"];
	!(isnull (uiNamespace getVariable ['BCE_Task_Receiver', displayNull]))
}] call aceAction;

["CAManBase", 1, ["ACE_SelfActions","BCE_Task_Receiver"], _action, true] call aceActionClass;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

_action = ["BCE_Select_TGP",localize "STR_BCE_Select_AV_Camera","",{
	createDialog "RscDisplay_TGP_Control_UI";
},{
	params ["_unit"];
	(true in ((assignedItems _unit) apply {_x iskindof ["UavTerminal_base",configFile >> "CfgWeapons"]})) && (_unit getVariable ["TGP_View_EHs",-1] == -1)
}] call aceAction;

["CAManBase", 1, ["ACE_SelfActions", "ACE_Equipment"], _action, true] call aceActionClass;

_action = ["BCE_Use_Selected_TGP",localize "STR_BCE_AV_Camera","\MG8\AVFEVFX\data\AV_Cam.paa",{
		params ["_unit"];
		([_unit] call BCE_fnc_get_TaskCurUnit) call BCE_fnc_TGP_Select_Confirm;
	},{
	params ["_unit"];
	private ["_selected","_condition"];
	_selected = [_unit] call BCE_fnc_get_TaskCurUnit;
	_condition = [
		(alive _selected) && (isEngineOn _selected),
		false
	] select (isnull _selected);

	(_condition) && (_unit getVariable ["TGP_View_EHs",-1] == -1)
}] call aceAction;

["CAManBase", 1, ["ACE_SelfActions"], _action, true] call aceActionClass;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//-Door Gunners
// - Light
_action = ["BCE_Use_Heli_SpotLight",SetTitle("STR_BCE_Toggle","STR_BCE_Spot_Light"),"",{
	params ["_unit"];

	_sources = _unit getVariable ["BCE_turret_Gunner_Lights",[]];
	_mode = "Light";
	if (_sources isEqualTo []) then {
		[vehicle _unit, _mode, _unit] call BCE_fnc_CreateSpotLight;
	} else {
		_unit call BCE_fnc_deleteGunnerLightSources;
		if !((_sources # 1) == _mode) then {
			[vehicle _unit, _mode, _unit] call BCE_fnc_CreateSpotLight;
		};
	};

},{
	params ["_unit"];
	_condition = [_unit isNotEqualTo driver (vehicle _unit),BCE_LandVeh_Light_fn] select ((vehicle _unit) isKindOf "LandVehicle");
		SpotLight_Condition
}] call aceAction;
["CAManBase", 1, ["ACE_SelfActions"], _action, true] call aceActionClass;

_action = ["BCE_Use_Heli_SpotLight_IR",SetTitle("STR_BCE_Toggle","STR_BCE_Spot_Light_IR"),"",{
	params ["_unit"];

	_sources = _unit getVariable ["BCE_turret_Gunner_Lights",[]];
	_mode = "LightIR";
	if (_sources isEqualTo []) then {
		[vehicle _unit, _mode, _unit] call BCE_fnc_CreateSpotLight;
	} else {
		_unit call BCE_fnc_deleteGunnerLightSources;
		if !((_sources # 1) == _mode) then {
		[vehicle _unit, _mode, _unit] call BCE_fnc_CreateSpotLight;
		};
	};

	},{
		params ["_unit"];
	_condition = [_unit isNotEqualTo driver (vehicle _unit),BCE_LandVeh_Light_fn] select ((vehicle _unit) isKindOf "LandVehicle");
		SpotLight_Condition
}] call aceAction;
["CAManBase", 1, ["ACE_SelfActions"], _action, true] call aceActionClass;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// -Laser Red
_action = ["BCE_Use_Heli_LaserR",SetTitle("STR_BCE_Toggle","STR_BCE_Laser_Red"),"",{
	params ["_unit"];
	private ["_sources","_mode"];
	_sources = _unit getVariable ["BCE_turret_Gunner_Laser",[]];
	_mode = "LaserR";
	if (_sources isEqualTo []) then {
		[vehicle _unit, _mode, _unit] call BCE_fnc_CreateLaser;
	} else {
		_unit call BCE_fnc_deleteGunnerLaserSources;
		if !((_sources # 2) isEqualTo [1000,0,0]) then {
			[vehicle _unit, _mode, _unit] call BCE_fnc_CreateLaser;
		};
	};

},{
		params ["_unit"];
		_condition = [_unit isNotEqualTo driver (vehicle _unit),BCE_LandVeh_Laser_fn] select ((vehicle _unit) isKindOf "LandVehicle");
		Laser_Condition
}] call aceAction;
["CAManBase", 1, ["ACE_SelfActions"], _action, true] call aceActionClass;

// -Laser Red
_action = ["BCE_Use_Heli_LaserG",SetTitle("STR_BCE_Toggle","STR_BCE_Laser_Green"),"",{
	params ["_unit"];
	private ["_sources","_mode"];

	_sources = _unit getVariable ["BCE_turret_Gunner_Laser",[]];
	_mode = "LaserG";
	
	if (_sources isEqualTo []) then {
		[vehicle _unit, _mode, _unit] call BCE_fnc_CreateLaser;
	} else {
		_unit call BCE_fnc_deleteGunnerLaserSources;
		if !((_sources # 2) isEqualTo [0,1000,0]) then {
			[vehicle _unit, _mode, _unit] call BCE_fnc_CreateLaser;
		};
	};

},{
		params ["_unit"];
		_condition = [_unit isNotEqualTo driver (vehicle _unit),BCE_LandVeh_Laser_fn] select ((vehicle _unit) isKindOf "LandVehicle");
		Laser_Condition
}] call aceAction;
["CAManBase", 1, ["ACE_SelfActions"], _action, true] call aceActionClass;

// -Laser IR
_action = ["BCE_Use_Heli_LaserIR",SetTitle("STR_BCE_Toggle","STR_BCE_Laser_IR"),"",{
	params ["_unit"];
	private ["_sources","_mode"];
	_sources = _unit getVariable ["BCE_turret_Gunner_Laser",[]];
	_mode = "LaserIR";
	if (_sources isEqualTo []) then {
		[vehicle _unit, "LaserIR",_unit] call BCE_fnc_CreateLaser;
	} else {
		_unit call BCE_fnc_deleteGunnerLaserSources;
		if !((_sources # 2) isEqualTo [1000,1000,1000]) then {
			[vehicle _unit, _mode, _unit] call BCE_fnc_CreateLaser;
		};
	};

},{
		params ["_unit"];
	_condition = [_unit isNotEqualTo driver (vehicle _unit),BCE_LandVeh_Laser_fn] select ((vehicle _unit) isKindOf "LandVehicle");
	Laser_Condition
}] call aceAction;
["CAManBase", 1, ["ACE_SelfActions"], _action, true] call aceActionClass;

_action = nil;
