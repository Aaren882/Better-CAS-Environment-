#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_cTab_ATAK_missions_fnc_ATAK_LBTaskUnitChanged
Description:
		Handles the change of a Task Unit selection, updating UI elements with unit information.

Parameters:
		_control - The control object to update.
		_lbCurSel - The current selection from the list box.

Returns:
		<NONE>

Author:
		Aaren
---------------------------------------------------------------------------- */

params ["_control","_lbCurSel"];
TRACE_1("fnc_ATAK_LBTaskUnitChanged",_this);

_this call BCE_fnc_LBTaskUnitChanged;

private _group = (call BCE_fnc_ATAK_getCurrentAPP) # 1;
private _MissionCtrl = _group getVariable "Mission_Control";

//- Set the first line (line 1)
	private _firstLine = _MissionCtrl controlsGroupCtrl (17000 + 2040);
	
	private _unit = call CBA_fnc_currentUnit;
	private _taskUnit = [nil,"GND" call BCE_fnc_get_TaskCateIndex] call BCE_fnc_get_TaskCurUnit;

	_firstLine ctrlSetStructuredText parseText format [
		"“%1” / “%2”",
		[groupId group _taskUnit, "None"] select isnull _taskUnit,
		groupId group _unit
	];
