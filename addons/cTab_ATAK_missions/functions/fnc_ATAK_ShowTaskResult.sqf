#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_cTab_ATAK_missions_fnc_ATAK_ShowTaskResult
Description:
		Shows the ATAK task result interface or switches to the correct result tool
		based on the current task category.

		If the task description control is currently shown, the current task building
		UI is cleared. Otherwise, the function selects the appropriate ATAK tool for
		AIR or CFF tasks.

Parameters:
		<NONE>

Returns:
		<NONE>

Examples:
	call BCE_cTab_ATAK_missions_fnc_ATAK_ShowTaskResult

Author:
	Aaren
---------------------------------------------------------------------------- */

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
