/*
	NAME : BCE_fnc_ATAK_ShowTaskResult
*/

private _description = "taskDesc" call BCE_fnc_getTaskSingleComponent;

if (ctrlshown _description) then {
	privateAll;

	(["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings) params ["","","_subInfos"];
	_subInfos params ["_subMenu","_curLine"];

	["BCE_TaskBuilding_Clear", [_curLine]] call CBA_fnc_localEvent;
} else {
	[nil,"Task_Result",-1] call BCE_fnc_ATAK_ChangeTool;
};