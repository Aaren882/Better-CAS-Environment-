/*
  NAME : BCE_fnc_RegisterMissionControls

  Register controls from #LINK - Mission_Controls.hpp
  Trigger Event => "onLoad"

  RETURN : nil
*/
disableSerialization;
params ["_registerCtrl","_config"];

if (isnil{_registerCtrl}) exitWith {};

private _map = localNamespace getVariable ["#BCE_TASK_REGISTER",createHashMap];

//- #NOTE - "Control Classes" in "BCE_Mission_Build_Controls"
  while { true } do {
    _config = inheritsFrom _config;
    if (isclass (configFile >> "BCE_Mission_Build_Controls" >> configName _config)) then {
      break;
    };
  };
  private _className = configName _config;

//- Setup Dict for Task/Mission controls
  _map set [_className, _registerCtrl];
  localNamespace setVariable ["#BCE_TASK_REGISTER", _map];