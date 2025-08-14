/*
  NAME : BCE_fnc_CFF_Mission_RAT
  
  On CFF "Record as Target" pressed
*/
params ["_taskID",["_removeRAT",false]];

//- Unit
private _taskUnit = [nil,"GND" call BCE_fnc_get_TaskCateIndex] call BCE_fnc_get_TaskCurUnit;

//- Set RAT value TaskID
private _RAT_val = [_taskID, _removeRAT] call BCE_fnc_CFF_Mission_Set_RAT_Values;
private _RAT_saved = _RAT_val findIf {true} > -1;

//- Send Msg
[
  FormationLeader _taskUnit,
  localize (["STR_BCE_CFF_MSG_RAT_FAIL","STR_BCE_CFF_MSG_RAT"] select _RAT_saved),
  ["CFF_RAT_FAIL","CFF_RAT"] select _RAT_saved
] call BCE_fnc_Send_Task_RadioMsg;

//- Record the data on owner side
	if (_RAT_saved) then {
		[
			"Record",
			_taskUnit,
			[_taskID, _removeRAT]
		] call BCE_fnc_Send_MSN_CFF;
	};