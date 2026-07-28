#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_cTab_ATAK_missions_AIR_fnc_ATAK_TaskUnitChanged_AIR
Description:
		Handles the unit/taskUnit change event.

Parameters:
		_unit     - The unit which is sending the task (e.g. current player unit) <OBJECT>
		_taskUnit - The selected task Receiving unit (e.g. jet / helicopter) <OBJECT>

Returns:
		<NONE>

Author:
		Aaren
---------------------------------------------------------------------------- */

params ["_unit","_taskUnit"];
TRACE_1("fnc_ATAK_TaskUnitChanged_AIR",_this);

private _group = (call BCE_fnc_ATAK_getCurrentAPP) # 1;
private _MissionCtrl = _group getVariable "Mission_Control";

//- Set the first line (line 1)
	private _firstLine = _MissionCtrl controlsGroupCtrl (17000 + 2040);

	_firstLine ctrlSetStructuredText parseText format [
		"“%1” / “%2”",
		[groupId group _taskUnit, "None"] select isnull _taskUnit,
		groupId group _unit
	];
