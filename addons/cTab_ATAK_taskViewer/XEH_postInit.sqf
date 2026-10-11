#include "script_component.hpp"

// Global variable storage for task viewer configurations.
GVAR(List) = createHashMap;

//- "CfgTaskViewer" from mission's "description.ext" (NEXT FRAME)
[
	{
		//- Load CfgTaskViewer on clients
		private _cfgTaskViewer = missionConfigFile >> "CfgTaskViewer";
		private _cfgTaskViewer = "getText (_x >> 'name') != ''" configClasses _cfgTaskViewer;
		[_cfgTaskViewer] spawn {
			params ["_cfgTaskViewer"];

			private _fnc_IsTimeOut = {
				params ["_start", "_timeOut"];
				(diag_tickTime - _start) >= _timeOut
			};

			{
				private _taskId = configName _x;
				private _taskVarName = _taskId call FUNC(getTaskVar);
				TRACE_1("Start adding task: %1",_taskId);
				
				private _startTime = diag_tickTime;
				waitUntil {
					!isNil { missionNamespace getVariable _taskVarName } ||
					[_startTime, 3] call _fnc_IsTimeOut
				};

				//- Check timeout
				if ([_startTime, 3] call _fnc_IsTimeOut) then {
					ERROR_1("Task Viewer Timeout for task ID: %1",_taskId);
				} else {
					[_taskId] call FUNC(AddTaskLocal); //- Add task
				};
			} forEach _cfgTaskViewer;
		};
	}
] call CBA_fnc_execNextFrame;