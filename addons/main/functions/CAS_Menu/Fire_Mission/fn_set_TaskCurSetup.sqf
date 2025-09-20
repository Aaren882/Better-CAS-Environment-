/* 
  NAME : BCE_fnc_set_TaskCurSetup

  Params :
    ["_key","_value"]
  
  Set "BCE_Task_Setup" Values
  [
    "Type"        : [0,1]         - Task Type
    "Cate"        : 0             - Task Category
    "CurDisplay"  : createHashMap - Current Task Display
    "Desc"        : 0             - Description Type for ATAK {localNamespace getVariable ["BCE_ATAK_Desc_Type",0]}
    "CFF_Mission" : ["MSN_ID"]    - CFF Mission Values
  ]
*/
params ["_key","_value"];

private _map = localNamespace getVariable ["BCE_Task_Setup",createHashMap];
_map set [_key,_value];

localNamespace setVariable ["BCE_Task_Setup", _map];
