/*
  NAME : BCE_fnc_CFF_Mission_Get_Values

*/
params [
  "_taskID",
  ["_taskUnit", [nil,"CFF" call BCE_fnc_get_TaskIndex] call BCE_fnc_get_TaskCurUnit]
];

//- Check _taskUnit exist
  if (isnull _taskUnit) exitWith {[]};

//- Get TaskUnit group infos (Current Unit's Tasks)
  private _CFF_Map = (group _taskUnit) getVariable ["BCE_CFF_Task_Pool", createHashMap];

(_CFF_Map get _taskID)