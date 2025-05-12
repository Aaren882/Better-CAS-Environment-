/*
  NAME : BCE_fnc_CFF_Mission_Set_Value

  Return : 
    <ARRAY> UPDATED "_curValues"
*/

params [
  "_taskID",
  "_values",
  ["_taskUnit", [nil,"CFF" call BCE_fnc_get_TaskIndex] call BCE_fnc_get_TaskCurUnit]
];

//- Update HashMap
  private _group = group _taskUnit;
  private _map = _group getVariable ["BCE_CFF_Task_Pool", createHashMap];
  _map set [_taskID, _values];

_group setVariable ["BCE_CFF_Task_Pool", _map];

_values