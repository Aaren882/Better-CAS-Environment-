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

// diag_log format ["BCE TASK RESPONDED : LOCAL - %1",_isLocal];
//- #NOTE - From remote side
if (_isLocal) exitWith {};
_values params ["_group","_res"];

// diag_log format ["BCE TASK RESPOND : %1", _values];

//- Overwrite Current Values
switch (_type) do {
	case "CFF": {
		//- #TODO - Send directly instead globally
		// : this will need all ends have BCE Loaded (for CBA_event to work)
		_group setVariable ["BCE_CFF_Task_Pool", _res];
		/* {
			[_x,_y,_taskUnit] call BCE_fnc_CFF_Mission_Set_Values;
		} forEach _values; */
	};
};

//- Return
nil