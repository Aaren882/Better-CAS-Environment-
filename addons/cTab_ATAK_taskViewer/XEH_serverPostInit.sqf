#include "script_component.hpp"

//- TaskViewer configurations for mission "description.ext"
//: Set configurations from the mission file.
private _cfgTaskViewer = missionConfigFile >> "CfgTaskViewer";

private _skipOnOwner = true;
private _cfgTaskViewer = "true" configClasses _cfgTaskViewer;
{
	private _taskId = configName _x;
	private _name = getText (_x >> "name");

	//- Check "_name" is exist
	if (_name isEqualTo "") then {
		ERROR_1("Task Viewer config ""%1"" >> ""name"" is missing.",_taskId);
		ERROR_MSG_1("Task Viewer config ""%1"" >> ""name"" is missing.",_taskId);
		continue;
	};

	private _desc = getText (_x >> "description");
	private _media = getArray (_x >> "media");

	//- Add marker position
	private _markerId = getText (_x >> "markerId");
	private _pos = [];
	if (_markerId isNotEqualTo "") then {
		_pos = getMarkerPos _markerId;
		_pos resize 2; 
	};

	//- Add Task to all playable units (ON SERVER side)
	[
		true, //- to global
		_taskId,
		_name,
		_desc,
		_media,
		_pos,
		_skipOnOwner
	] call FUNC(AddTask);
} forEach _cfgTaskViewer;

[QGVAR(PostLoad_TaskViewerFromMission)] call CBA_fnc_globalEvent;