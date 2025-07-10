/*
  NAME : BCE_fnc_CFF_Mission_RAT
  
  On CFF "Record as Target" pressed
*/
params ["_control",["_removeRAT",false]];

//- Remove the Hash Key
private _tagGrp = ctrlParentControlsGroup _control;
private _taskData = _tagGrp getVariable ["CFF_Task_Mission",""];

private _taskUnit = [nil,"GND" call BCE_fnc_get_TaskCateIndex] call BCE_fnc_get_TaskCurUnit;

private _RAT_val = [_taskData, _removeRAT] call BCE_fnc_CFF_Mission_Set_RAT_Values;
private _RAT_saved = _RAT_val findIf {true} > -1;

//- Send Msg
[
  FormationLeader _taskUnit,
  localize (["STR_BCE_CFF_MSG_RAT_FAIL","STR_BCE_CFF_MSG_RAT"] select _RAT_saved),
  ["CFF_RAT_FAIL","CFF_RAT"] select _RAT_saved
] call BCE_fnc_Send_Task_RadioMsg;