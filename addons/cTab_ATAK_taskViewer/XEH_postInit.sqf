#include "script_component.hpp"

if (isServer) exitWith {};

//- Load CfgTaskViewer on clients
private _cfgTaskViewer = "getText (_x >> 'name') != ''" configClasses (missionConfigFile >> "CfgTaskViewer");
{
	private _taskId = configName _x;
	[_taskId] call FUNC(AddTaskLocal);
} forEach _cfgTaskViewer;
