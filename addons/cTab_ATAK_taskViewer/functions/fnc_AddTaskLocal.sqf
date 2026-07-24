#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_cTab_ATAK_taskViewer_fnc_AddTaskLocal
Description:
		Registers a task locally by retrieving task variables based on the provided Task ID (_taskId) 
		then saving them into GVAR(List).

Parameters:
		_taskId      - Unique identifier for the task. <STRING>

Returns:
		<BOOL>

Examples
		(begin example)
				["task1"] call BCE_cTab_ATAK_taskViewer_fnc_AddTaskLocal
		(end)

Author:
		Aaren
---------------------------------------------------------------------------- */

params [["_taskId", "", [""]]];
TRACE_1("fnc_AddTaskLocal",_this);

//- Get variable (Supports JIP)
private _taskVarName = _taskId call FUNC(getTaskVar);
private _taskVar = missionNamespace getVariable[_taskVarName, []];

//- Check _taskVar exist
if (count _taskVar isEqualTo 0) exitWith {
	ERROR_MSG_1("Task registration failed: Task ID ""%1"" is not exist.",_taskId);
	false
};

/** PROCESS THE TASK VARIABLES ON LOCAL **/

_taskVar params [
	["_title", "", [""]],
	["_description", "", [""]],
	["_media", [], [ [] ]],
	["_position", [], [ [] ]]
];

private _metaData = [
	_title,
	_description,
	createHashMap
];

//- Setup Media
if (count _media isNotEqualTo 0) then {
	private _m = _metaData # 2;
	_m set ["Media", _media];
	_m set ["Index", 0];
};

//- Setup destination position
if (count _position isNotEqualTo 0) then {
	if (count _position < 2 || count _position > 3) then {
		ERROR_MSG_1("Invalid task position parameters. Expected at least 2, got ""%1""",count _position);
	} else {
		_metaData set [3, _position];
	};
};

//- Save into <HASHMAP> on local end
GVAR(List) set [_taskId, _metaData];
