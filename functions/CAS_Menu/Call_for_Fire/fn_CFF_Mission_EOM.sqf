/*
  NAME : BCE_fnc_CFF_Mission_EOM
  
  On CFF "End of Mission" pressed
*/
params ["_taskID"];

private _taskUnit = [nil,"GND" call BCE_fnc_get_TaskCateIndex] call BCE_fnc_get_TaskCurUnit;

//- Remove Task From Unit (FULL DELETE)
	[_taskID,true] call BCE_fnc_CFF_Mission_STOP;

//- #NOTE - Remove mission (MUST be after Task is removed from the units)
	[
		"Delete",
		[_taskID, nil, _taskUnit],
		_taskUnit
	] call BCE_fnc_Send_MSN_CFF;
	
//- Refresh CFF Mission list
	[nil,"Task_CFF_List",-1] call BCE_fnc_ATAK_ChangeTool;

//- Send Msg
	[
		_taskUnit,
		format [localize "STR_BCE_CFF_MSG_EOM",_taskID],
		"CFF_EOM"
	] call BCE_fnc_Send_Task_RadioMsg;
