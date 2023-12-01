params ["_control"];
private ["_group","_description"];

_display = ctrlParent _control;
_group = _display displayCtrl (17000 + 4662);
_description = _group controlsGroupCtrl (17000 + 2004);

if (ctrlshown _description) then {
	(["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings) params ["","","_curLine"];
	private ["_curType","_taskVar","_Veh_Changed","_isOverwrite"];
	_curType = uiNameSpace getVariable ["BCE_Current_TaskType",0];
	_taskVar = uiNameSpace getVariable (["BCE_CAS_9Line_Var","BCE_CAS_5Line_Var"] # _curType);
	_Veh_Changed = false;
	_isOverwrite = false;
	_shownCtrls = [_group,_curLine,1,false,true] call BCE_fnc_Show_CurTaskCtrls;
	call ([BCE_fnc_clearTask9line,BCE_fnc_clearTask5line] # _curType);
} else {
	['cTab_Android_dlg',[['showMenu',['Task_Result',true,-1]]]] call cTab_fnc_setSettings;
};