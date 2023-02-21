#define aceAction ace_interact_menu_fnc_createAction
#define aceActionClass ace_interact_menu_fnc_addActionToClass
#define getOpticVars ((vehicle _unit) getVariable ["TGP_View_Available_Optics",[]])
#define Available_Optics ["","RscWeaponZeroing","RscOptics_Offroad_01","RscOptics_crows","RHS_RscWeaponZeroing_TurretAdjust"]
#define SpotLight_Condition (_condition && ((getText ([(vehicle _unit), ((vehicle _unit) unitTurret _unit)] call BIS_fnc_turretConfig >> "turretInfoType")) in Available_Optics) && (((vehicle _unit) unitTurret _unit) in (getOpticVars apply {_x select 1})))
#define Laser_Condition (_condition && ((getText ([(vehicle _unit), ((vehicle _unit) unitTurret _unit)] call BIS_fnc_turretConfig >> "turretInfoType")) in Available_Optics) && (((vehicle _unit) unitTurret _unit) in (getOpticVars apply {_x select 1})))

private ["_action"];

//-Clear
_action = ["BCE_Task_Clear","Clear","\a3\ui_f\data\Map\Diary\Icons\diaryUnassignTask_ca.paa",{
	params ["_unit"];
	557 cutRsc ["default","PLAIN"];
	(vehicle _unit) setVariable ["BCE_Task_Receiver",[],true];
	},{
	params ["_unit"];
	!(isnull (uiNamespace getVariable ['BCE_Task_Receiver', displayNull])) or (((vehicle _unit) getVariable ['BCE_Task_Receiver',[]]) isNotEqualto [])
}] call aceAction;

["CAManBase", 1, ["ACE_SelfActions","BCE_Task_Receiver"], _action, true] call aceActionClass;

//-Slew to TG
_action = ["BCE_Task_Slew","Slew TG","",{
	params ["_unit"];
	private _vehicle = vehicle _unit;
	private _turret = _unit call CBA_fnc_turretPath;
	private _var = _vehicle getVariable ['BCE_Task_Receiver',[]];
	private _type = _var # 2;
	private _task = _var # 3;
	private _POS = switch _type do {
	  case 5: {
	    _task # 2 # 2
	  };
		default {
		  _task # 6 # 2
		};
	};

	_vehicle setPilotCameraTarget (AGLToASL _POS);
	_vehicle lockCameraTo [AGLToASL _POS, _turret, true];

	},{
	params ["_unit"];
	(((vehicle _unit) getVariable ['BCE_Task_Receiver',[]]) isNotEqualto [])
}] call aceAction;

["CAManBase", 1, ["ACE_SelfActions","BCE_Task_Receiver"], _action, true] call aceActionClass;

//-Show
_action = ["BCE_Task_Show","Show","\a3\ui_f\data\Map\Diary\Icons\diaryLocateTask_ca.paa",{
	params ["_unit"];
	557 cutRsc ["BCE_Task_Receiver","PLAIN",0.3,false];
	call BCE_fnc_UpdateTaskInfo;
	},{
	params ["_unit"];
	(isnull (uiNamespace getVariable ['BCE_Task_Receiver', displayNull])) && (((vehicle _unit) getVariable ['BCE_Task_Receiver',[]]) isNotEqualto [])
}] call aceAction;

["CAManBase", 1, ["ACE_SelfActions","BCE_Task_Receiver"], _action, true] call aceActionClass;

//-Hide
_action = ["BCE_Task_Hide","Hide","",{
	params ["_unit"];
	557 cutRsc ["default","PLAIN"];

	},{
	params ["_unit"];
	!(isnull (uiNamespace getVariable ['BCE_Task_Receiver', displayNull])) && (((vehicle _unit) getVariable ['BCE_Task_Receiver',[]]) isNotEqualto [])
}] call aceAction;

["CAManBase", 1, ["ACE_SelfActions","BCE_Task_Receiver"], _action, true] call aceActionClass;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

_action = ["BCE_Select_TGP","Select Vehicle TGP","",{
	createDialog "RscDisplay_TGP_Control_UI";
	},{
	params ["_unit"];
	(true in ((assignedItems _unit) apply {_x iskindof ["UavTerminal_base",configFile >> "CfgWeapons"]})) && (_unit getVariable ["TGP_View_EHs",-1] == -1)
}] call aceAction;

["CAManBase", 1, ["ACE_SelfActions", "ACE_Equipment"], _action, true] call aceActionClass;

_action = ["BCE_Use_Selected_TGP","TGP View","",{
  	params ["_unit"];
		((_unit getVariable "TGP_View_Selected_Optic") # 1) call BCE_fnc_TGP_Select_Confirm;
	},{
  params ["_unit"];
	private _selected = _unit getVariable ["TGP_View_Selected_Optic",[]];
	private _condition = if (_selected isEqualTo []) then {
	  false
	} else {
		(alive (_selected # 1)) && (isEngineOn (_selected # 1))
	};

	(_condition) && (_unit getVariable ["TGP_View_EHs",-1] == -1)
}] call aceAction;

["CAManBase", 1, ["ACE_SelfActions"], _action, true] call aceActionClass;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//-Door Gunners
// - Light
_action = ["BCE_Use_Heli_SpotLight","Toggle Spot Light","",{
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
		_condition = [true,BCE_LandVeh_Light_fn] select ((vehicle _unit) isKindOf "LandVehicle");
    SpotLight_Condition
}] call aceAction;
["CAManBase", 1, ["ACE_SelfActions"], _action, true] call aceActionClass;

_action = ["BCE_Use_Heli_SpotLight_IR","Toggle Light (IR)","",{
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
		_condition = [true,BCE_LandVeh_Light_fn] select ((vehicle _unit) isKindOf "LandVehicle");
    SpotLight_Condition
}] call aceAction;
["CAManBase", 1, ["ACE_SelfActions"], _action, true] call aceActionClass;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// -Laser Red
_action = ["BCE_Use_Heli_LaserR","Toggle Laser (Red)","",{
  params ["_unit"];
  private _sources = _unit getVariable ["BCE_turret_Gunner_Laser",[]];
	private _mode = "LaserR";
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
		_condition = [true,BCE_LandVeh_Laser_fn] select ((vehicle _unit) isKindOf "LandVehicle");
	  Laser_Condition
}] call aceAction;
["CAManBase", 1, ["ACE_SelfActions"], _action, true] call aceActionClass;

// -Laser Red
_action = ["BCE_Use_Heli_LaserG","Toggle Laser (Green)","",{
  params ["_unit"];
  private _sources = _unit getVariable ["BCE_turret_Gunner_Laser",[]];
	private _mode = "LaserG";
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
		_condition = [true,BCE_LandVeh_Laser_fn] select ((vehicle _unit) isKindOf "LandVehicle");
	  Laser_Condition
}] call aceAction;
["CAManBase", 1, ["ACE_SelfActions"], _action, true] call aceActionClass;

// -Laser IR
_action = ["BCE_Use_Heli_LaserIR","Toggle Laser (IR)","",{
  params ["_unit"];
  private _sources = _unit getVariable ["BCE_turret_Gunner_Laser",[]];
	private _mode = "LaserIR";
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
		_condition = [true,BCE_LandVeh_Laser_fn] select ((vehicle _unit) isKindOf "LandVehicle");
	  Laser_Condition
}] call aceAction;
["CAManBase", 1, ["ACE_SelfActions"], _action, true] call aceActionClass;
