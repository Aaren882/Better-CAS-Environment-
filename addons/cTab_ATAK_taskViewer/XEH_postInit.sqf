#include "script_component.hpp"

// Global variable storage for task viewer configurations.
GVAR(List) = createHashMap;

//- TaskViewer configurations for mission "description.ext"
//: Load configurations from the mission file.
private _cfgTaskViewer = "true" configClasses (missionConfigFile >> "CfgTaskViewer");
{
	private _taskId = configName _x;
	private _name = getText (_x >> "name");

	//- Check "_name" is exist
	if (_name isEqualTo "") then {
		ERROR("Task Viewer config ""name"" is missing.");
		ERROR_MSG("Task Viewer config ""name"" is missing.");
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

	//- Add Task
	[_configName, _name, _desc, _media, _pos] call FUNC(AddTask);
} forEach _cfgTaskViewer;
