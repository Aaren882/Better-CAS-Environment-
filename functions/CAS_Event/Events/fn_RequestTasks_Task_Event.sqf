/*
	NAME : BCE_fnc_RequestTasks_Task_Event
	
	Use for CBA "targetEvent" => "BCE_RequestTasks_Task_Event"
	which can save more Network loads in this way
	
	Params : 
		[
			<STRING> "_type"
			<ARRAY> "_value"
			<BOOL> "_isLocal" : for checking it's triggered by localEvent
		]
	
	Return : nil
*/

params ["_type","_values","_isLocal"];

diag_log format ["BCE TASK REQUESTED : LOCAL - %1",_isLocal];
//- #NOTE - From remote side
if (_isLocal) exitWith {};

_values params ["_group","_requester"];

private _res = switch (_type) do {
	case "CFF": {
		_group getVariable ["BCE_CFF_Task_Pool", createHashMap]
	};
	default {createHashMap};
};

diag_log format ["BCE TASK REQUEST : %1", _res];
[
	"RespondTasks",	//- Type
	[_group,_res],	//- Value
	_requester,			//- To person
	true						//- _force
] call BCE_fnc_Send_MSN_CFF;

//- Return
nil