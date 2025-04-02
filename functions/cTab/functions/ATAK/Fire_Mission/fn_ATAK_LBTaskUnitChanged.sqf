/*
	NAME : BCE_fnc_ATAK_LBTaskUnitChanged
*/
// params ["_unit","_taskUnit","_changed"];
params ["_control","_lbCurSel"];

_this call BCE_fnc_LBTaskUnitChanged;

private _group = (call BCE_fnc_ATAK_getCurrentAPP) # 1;
private _MissionCtrl = _group getVariable "Mission_Control";

//- Set the first line (line 1)
	private _firstLine = _MissionCtrl controlsGroupCtrl (17000 + 2040);
	
	private _unit = call CBA_fnc_currentUnit;
	private _taskUnit = [nil,"CFF" call BCE_fnc_get_TaskIndex] call BCE_fnc_get_TaskCurUnit;
	
	_firstLine ctrlSetStructuredText parseText format [
		"“%1” / “%2”",
		[groupId group _taskUnit, "None"] select isnull _taskUnit,
		groupId group _unit
	];