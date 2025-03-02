//- call BCE_fnc_ATAK_mission_SUB_TaskResult;
params ["_group",["_interfaceInit",false],"_isDialog","_settings"];

private _ctrl = _group controlsGroupCtrl 11;
private _curType = uiNameSpace getVariable ["BCE_Current_TaskType",0];
private _taskVar = uiNameSpace getVariable (["BCE_CAS_9Line_Var","BCE_CAS_5Line_Var"] # _curType);
[_ctrl,[9,5] # _curType,_taskVar,player getVariable ["TGP_View_Selected_Vehicle",objNull]] call BCE_fnc_SetTaskReceiver;