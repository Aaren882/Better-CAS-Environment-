/*
	NAME : BCE_fnc_RespondTasks_Task_Event
	
	Use for CBA "targetEvent" => "BCE_RespondTasks_Task_Event"
	which can save more Network loads in this way
	
	Params : 
		[
			<STRING> "_type"
			<HASHMAP> "_value"
			<BOOL> "_isLocal" : for checking it's triggered by localEvent
		]
	
	Return : nil
*/

params ["_type","_values","_isLocal"];

diag_log "BCE TASK RESPONDED";
//- #NOTE - From remote side
if (_isLocal) exitWith {};

private _taskUnit = [] call BCE_fnc_get_TaskCurUnit;

diag_log format ["BCE TASK RESPOND : %1", _values];

//- Overwrite Current Values
switch (_type) do {
	case "CFF": {
		{
			[_x,_y,_taskUnit] call BCE_fnc_CFF_Mission_Set_Values;
		} forEach _values;
	};
};

//- Return
nil