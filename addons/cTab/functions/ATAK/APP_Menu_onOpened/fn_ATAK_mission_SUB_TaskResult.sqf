//- call BCE_fnc_ATAK_mission_SUB_TaskResult;
params ["_group",["_interfaceInit",false],"_isDialog","_settings"];

private _ctrl = _group controlsGroupCtrl 11;
private _curType = [] call BCE_fnc_get_TaskCurType;
private _taskVar = ([] call BCE_fnc_getTaskVar) # 0;

[
  _ctrl,
  [9,5] # _curType,
  _taskVar,
  [] call BCE_fnc_get_TaskCurUnit
] call BCE_fnc_SetTaskReceiver;
