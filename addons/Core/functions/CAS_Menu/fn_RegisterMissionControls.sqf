/*
  NAME : BCE_fnc_RegisterMissionControls

  Register controls from #LINK - Mission_Controls.hpp
  Trigger Event => "onLoad"

  Params : 
    _registerCtrl : CONTROL
    _config       : CONFIG
    _forceRegist  : BOOL

  RETURN : nil
*/
disableSerialization;
params ["_registerCtrl","_config",["_forceRegist",false]];

if (isnil{_registerCtrl}) exitWith {};

private _map = localNamespace getVariable ["#BCE_TASK_REGISTER",createHashMap];

//- "Control Classes" in "BCE_Mission_Build_Controls"
  while { !_forceRegist } do { //- #NOTE - Check it's not "_forceRegist"
    _config = inheritsFrom _config;
    if (
      isclass (configFile >> "BCE_Mission_Build_Controls" >> configName _config)
    ) then {break};
  };
  private _className = configName _config;

//- Set BCE_Data
  private _BCE_Data_Cfg = _config >> "BCE_Data";
  if (isClass _BCE_Data_Cfg) then {
    private _props = (configProperties [_BCE_Data_Cfg]) apply {
      private _entry = configName _x;
      [_entry, [_BCE_Data_Cfg, _entry] call BIS_fnc_returnConfigEntry]
    };

    _registerCtrl setVariable ["BCE_Data", createHashMapFromArray _props];
  };

//- Setup HashMap for Task/Mission controls
  _map set [_className, _registerCtrl];
  localNamespace setVariable ["#BCE_TASK_REGISTER", _map];
