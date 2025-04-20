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

	//- Check Category Selection
	private _cateSel = ["Cate",0] call BCE_fnc_get_TaskCurSetup;

	switch (_cateSel) do {
		//- AIR
		case 0: {
			[nil,"Task_Result",-1] call BCE_fnc_ATAK_ChangeTool;
		};
		//- CFF
		case 1: {
			[nil,"Task_CFF_List",-1] call BCE_fnc_ATAK_ChangeTool;
		};
	};
};