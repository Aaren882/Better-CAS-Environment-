params ["_control"];
private ["_group","_description"];

_group = (call BCE_fnc_ATAK_getCurrentAPP) # 1;
_description = _group controlsGroupCtrl (17000 + 2004);

if (ctrlshown _description) then {
	private ["_curType","_taskVar","_Veh_Changed","_isOverwrite","_IDC_offset"];

	(["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings) params ["","","_subInfos"];
	_subInfos params ["_subMenu","_curLine"];
	
	_curType = uiNameSpace getVariable ["BCE_Current_TaskType",0];
	((["9Line","5Line"] # _curType) call BCE_fnc_getTaskVar) params ["_taskVar","_default","_maxIndex"];

	//- Correct Remark Index
	if (_curLine > _maxIndex) then {
		_curLine = -1;
	};

	_Veh_Changed = false;
	_isOverwrite = false;
	_IDC_offset = 17000;
	_shownCtrls = [_group,_curLine,1,false,true] call BCE_fnc_Show_CurTaskCtrls;
	call ([BCE_fnc_clearTask9line,BCE_fnc_clearTask5line] # _curType);
} else {
	[nil,"Task_Result",-1] call BCE_fnc_ATAK_ChangeTool;
};