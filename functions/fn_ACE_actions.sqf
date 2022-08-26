#define aceAction ace_interact_menu_fnc_createAction
#define aceActionClass ace_interact_menu_fnc_addActionToClass
#define getOpticVars (vehicle _unit) getVariable ["TGP_View_Available_Optics",[]]

_action = ["BCE_Select_TGP","Select Vehicle TGP","",{
	createDialog "RscDisplay_TGP_Control_UI";
	},{
	params ["_unit"];
	(true in ((assignedItems _unit) apply {_x iskindof ["UavTerminal_base",configFile >> "CfgWeapons"]})) && (_unit getVariable ["TGP_View_EHs",-1] == -1)
}] call aceAction;

["CAManBase", 1, ["ACE_SelfActions", "ACE_Equipment"], _action, true] call aceActionClass;

_action = ["BCE_Use_Selected_TGP","TGP View","",{
  params ["_unit"];
	[(_unit getVariable "TGP_View_Selected_Optic") # 1] call BCE_fnc_TGP_Select_Confirm;
	},{
  params ["_unit"];
	!((_unit getVariable ["TGP_View_Selected_Optic",[]]) isEqualTo []) && (_unit getVariable ["TGP_View_EHs",-1] == -1)
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
    (getNumber (configFile >> "CfgVehicles" >> typeOf (vehicle _unit) >> "BCE_DoorGunners") == 1) && (((vehicle _unit) unitTurret _unit) in (getOpticVars apply {_x # 1}))
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
    (getNumber (configFile >> "CfgVehicles" >> typeOf (vehicle _unit) >> "BCE_DoorGunners") == 1) && (((vehicle _unit) unitTurret _unit) in (getOpticVars apply {_x # 1}))
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
	  (getNumber (configFile >> "CfgVehicles" >> typeOf (vehicle _unit) >> "BCE_DoorGunners") == 1) && (((vehicle _unit) unitTurret _unit) in (getOpticVars apply {_x # 1}))
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
	  (getNumber (configFile >> "CfgVehicles" >> typeOf (vehicle _unit) >> "BCE_DoorGunners") == 1) && (((vehicle _unit) unitTurret _unit) in (getOpticVars apply {_x # 1}))
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
	  (getNumber (configFile >> "CfgVehicles" >> typeOf (vehicle _unit) >> "BCE_DoorGunners") == 1) && (((vehicle _unit) unitTurret _unit) in (getOpticVars apply {_x # 1}))
}] call aceAction;
["CAManBase", 1, ["ACE_SelfActions"], _action, true] call aceActionClass;
