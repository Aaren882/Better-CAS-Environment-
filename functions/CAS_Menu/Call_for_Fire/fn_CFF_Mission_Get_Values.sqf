/*
  NAME : BCE_fnc_CFF_Mission_Get_Values

*/
params [
  "_taskID"
  // ["_taskUnit", [nil,"CFF" call BCE_fnc_get_TaskIndex] call BCE_fnc_get_TaskCurUnit]
];

private _pool = localNamespace getVariable ["#BCE_CFF_Task_Pool", createHashMap];
private _group = _pool getOrDefault [_taskID, grpNull];

//- Check _taskUnit exist
  if (isnull _group) exitWith {[]};

//- Get TaskUnit group infos (Current Unit's Tasks)
  private _CFF_Map = _group getVariable ["BCE_CFF_Task_Pool", createHashMap];

_CFF_Map getOrDefault [_taskID, []]