/* 
  NAME : BCE_fnc_set_FireAdjustValues

  ["_key","_value"]
  
  Set "BCE_Task_Setup" Values
  [
    "Type" : 0, //- Task Type
    "Cate" : 0  //- Task Category
  ]
*/
params ["_key","_value"];

private _map = localNamespace getVariable ["BCE_Task_Setup",createHashMap];
_map set [_key,_value];

localNamespace setVariable ["BCE_Task_Setup", _map];