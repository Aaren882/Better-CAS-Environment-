#include "script_component.hpp"

//- "CfgTaskViewer" from mission's "description.ext"
[QGVAR(PostLoad_TaskViewerFromMission), {

	//- Load CfgTaskViewer on clients
	private _cfgTaskViewer = missionConfigFile >> "CfgTaskViewer";
	private _cfgTaskViewer = "getText (_x >> 'name') != ''" configClasses _cfgTaskViewer;
	{
		private _taskId = configName _x;
		[_taskId] call FUNC(AddTaskLocal);
	} forEach _cfgTaskViewer;
}] call CBA_fnc_addEventHandler;