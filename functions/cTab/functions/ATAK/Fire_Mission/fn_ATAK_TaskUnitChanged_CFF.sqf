/*
	NAME : BCE_fnc_ATAK_TaskUnitChanged_CFF
*/
params ["_unit","_taskUnit"];

_this call BCE_fnc_TaskUnitChanged_CFF;

private _group = (call BCE_fnc_ATAK_getCurrentAPP) # 1;
private _MissionCtrl = _group getVariable "Mission_Control";

//- Set the first line (line 1)
	private _firstLine = _MissionCtrl controlsGroupCtrl (17000 + 2040);

	_firstLine ctrlSetStructuredText parseText format [
		"“%1” / “%2”",
		[groupId group _taskUnit, "None"] select isnull _taskUnit,
		groupId group _unit
	];