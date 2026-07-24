#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_cTab_ATAK_taskViewer_fnc_AddTask
Description:
		Registers a new task viewer entry
		including:
			- title
			- description
			- media
			- position
		into public variables.

Parameters:
		_taskId      - Unique identifier for the task. <STRING>
		_title       - Display title of the task. <STRING>
		_description - Detailed description of the task. <STRING>
		_media       - Array of media items associated with the task. <ARRAY>
		_position    - Position parameters for the task viewer. <ARRAY>

Returns:
		<NONE>

Examples
		(begin example)
				[
					player,
					"task1",
					"title",
					"desc",
					[
						["IMAGE", "a3\ui_f_curator\data\cfgdiaryimages\altis\poliakko_ca.paa"],
						["WEB_LINK", "https://www.youtube.com/watch?v=xvFZjo5PgG0&autoplay=1&loop=1"]
					]
				] call BCE_cTab_ATAK_taskViewer_fnc_AddTask
		(end)

Author:
		Aaren
---------------------------------------------------------------------------- */

params [
	["_owner", nil, [true,sideUnknown,grpNull,objNull,[],""]],
	["_taskId", "", [""]],
	["_title", "", [""]],
	["_description", "", [""]],
	["_media", [], [ [] ]],
	["_position", [], [ [] ]],
	["_skipOnOwner", false, [true]]
];
TRACE_1("fnc_AddTask",_this);

//- Check "_owner"
if (isNil "_owner" || _owner isEqualTo []) exitWith {
	ERROR_MSG("""_owner"" parameter is missing or invalid.");
	nil
};

private _global = isMultiplayer;
private _params = [_title, _description, _media, _position];

//- Board cast variable (Supports JIP)
private _taskVarName = _taskId call FUNC(getTaskVar);
missionNamespace setVariable[_taskVarName, _params];
publicVariable _taskVarName;

//- Check if owner should skip registration
if (_skipOnOwner) exitWith {};

//- remoteExecCall if it's global environment
if (_global) exitWith {
	[_taskId] remoteExecCall [QFUNC(AddTaskLocal), 0, _owner];
	nil
};

_taskId call FUNC(AddTaskLocal);
nil