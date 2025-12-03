/*
  NAME : BCE_fnc_get_TaskCurSetup

  Params : 
    ["_key","_default","_replace"]

  Get "BCE_Task_Setup" Values
  [
    "Type"        : [0,1]         - Task Type
    "Cate"        : 0             - Task Category
    "CurDisplay"  : createHashMap - Current Task Display
    "Desc"        : 0             - Description Type for ATAK {localNamespace getVariable ["BCE_ATAK_Desc_Type",0]}
    "CFF_Mission" : ["MSN_ID"]    - CFF Mission Values
  ]
*/
params ["_key",["_default",0],["_replace",false]];

private _map = localNamespace getVariable ["BCE_Task_Setup",createHashMap];

private _result = _map getOrDefault [_key, _default, _replace];

//- Trigger Replace
  if (_replace) then {
    localNamespace setVariable ["BCE_Task_Setup", _map];
  };

_result
