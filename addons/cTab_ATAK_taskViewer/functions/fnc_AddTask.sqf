#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_cTab_ATAK_taskViewer_fnc_AddTask
Description:
		Registers a new task viewer entry, including title, description, media, and position, into a global list.

Parameters:
		_taskId      - Unique identifier for the task. <STRING>
		_title       - Display title of the task. <STRING>
		_description - Detailed description of the task. <STRING>
		_media       - Array of media items associated with the task. <ARRAY>
		_position    - Position parameters for the task viewer. <ARRAY>

Returns:
		<BOOL>

Examples
		(begin example)
				[
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
	["_taskId", "", [""]],
	["_title", "", [""]],
	["_description", "", [""]],
	["_media", [], [ [] ]],
	["_position", [], [ [] ]]
];
TRACE_1("fnc_AddTask",_this);

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

/* 
	Example
	[
		"task1",
		[
			Title,		<TEXT>
			Desc,			<TEXT>
			Media, 		<HASHMAP>
			position	<ARRAY>
		]
	]
*/
GVAR(List) set [_taskId, _metaData];