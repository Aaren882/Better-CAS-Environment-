/*
  NAME : BCE_fnc_get_TaskCurSetup

  ["_key","_default","_replace"]

  Get "BCE_Task_Setup" Values
  [
    "Type" : 0, //- Task Type
    "Cate" : 0, //- Task Category
    "Desc" : 0  //- Description Type for ATAK {localNamespace getVariable ["BCE_ATAK_Desc_Type",0]}
  ]
*/
params ["_key",["_default",-1],["_replace",false]];

private _map = localNamespace getVariable ["BCE_Task_Setup",createHashMap];

_map getOrDefault [_key, _default, _replace];