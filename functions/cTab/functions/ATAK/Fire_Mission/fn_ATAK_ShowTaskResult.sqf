/*
	NAME : BCE_fnc_ATAK_ShowTaskResult
*/
// private ["_group","_description"];

// _group = (call BCE_fnc_ATAK_getCurrentAPP) # 1;
// _dispaly = ctrlParent _group;

private _description = "taskDesc" call BCE_fnc_getTaskSingleComponent;

if (ctrlshown _description) then {
	privateAll;

	(["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings) params ["","","_subInfos"];
	_subInfos params ["_subMenu","_curLine"];
	
	// _curType = [] call BCE_fnc_get_TaskCurType;
	/* ([] call BCE_fnc_getDisplayTaskProps) params ["_varName","_default","_events"];
	([] call BCE_fnc_getTaskVar) params ["_taskVar"]; */
	
	//- Correct Remark Index
	/* _maxIndex = count _default;
	if (_curLine > _maxIndex) then {
		_curLine = -1;
	}; */

	["BCE_TaskBuilding_Clear", [_curLine]] call CBA_fnc_localEvent;
	// call (uiNamespace getVariable (_events get "Clear"));

	// private _fnc = ["BCE_fnc_clearTask9line","BCE_fnc_clearTask5line"] # _curType;
	// call (uiNamespace getVariable _fnc);
	
} else {
	[nil,"Task_Result",-1] call BCE_fnc_ATAK_ChangeTool;
};