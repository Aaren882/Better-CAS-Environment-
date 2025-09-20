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

//- Record the data on owner side
	if (_RAT_saved) then {
		[
			"Record",
			[_taskID, _removeRAT],
			_taskUnit
		] call BCE_fnc_Send_MSN_CFF;
	};

//- Send Msg
	private _msgData = switch (true) do {
		case (_removeRAT) : {
			[localize "STR_BCE_CFF_MSG_RAT_REMOVE","CFF_RAT_DEL"]
		};
		case (_RAT_saved) : {
			[format [localize "STR_BCE_CFF_MSG_RAT", _taskID],"CFF_RAT"]
		};
		default {
			[localize "STR_BCE_CFF_MSG_RAT_FAIL","CFF_RAT_FAIL"]
		};
	};

	_msgData params ["_msg","_eventName"];

	[
		FormationLeader _taskUnit,
		_msg,
		_eventName
	] call BCE_fnc_Send_Task_RadioMsg;

