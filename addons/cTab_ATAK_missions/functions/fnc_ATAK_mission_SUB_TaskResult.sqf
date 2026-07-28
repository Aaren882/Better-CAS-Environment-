#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_cTab_ATAK_missions_fnc_ATAK_mission_SUB_TaskResult
Description:
		Initializes and configures the task receiver for a sub-task in an ATAK mission.

Parameters:
		_group - The control group object managing the mission interface.
		_interfaceInit - Boolean flag to control interface initialization.
		_isDialog - Boolean flag to determine if a dialog box should be used.
		_settings - An object containing panel settings, including the target page and component map.

Returns:
		NONE

Examples
		(begin example)
				[params] call BCE_cTab_ATAK_missions_fnc_ATAK_mission_SUB_TaskResult
		(end)

Author:
		Aaren
---------------------------------------------------------------------------- */

params ["_group",["_interfaceInit",false],"_isDialog","_settings"];
TRACE_1("fnc_ATAK_mission_SUB_TaskResult",_this);

private _ctrl = _group controlsGroupCtrl 11;
private _curType = [] call BCE_fnc_get_TaskCurType;
private _taskVar = ([] call BCE_fnc_getTaskVar) # 0;

[
  _ctrl,
  [9,5] # _curType,
  _taskVar,
  [] call BCE_fnc_get_TaskCurUnit
] call BCE_fnc_SetTaskReceiver;
