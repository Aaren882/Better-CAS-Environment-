params ["_control", "_lbCurSel"];
private ["_TaskList","_EditBox","_curType","_taskVar","_show"];

uiNamespace setVariable ["BCE_ATAK_Desc_Type",_lbCurSel];

_TaskList = ctrlParentControlsGroup _control;
_EditBox = _TaskList controlsGroupCtrl (17000 + 2015);

_curType = uiNameSpace getVariable ["BCE_Current_TaskType",0];
_taskVar = uiNameSpace getVariable (["BCE_CAS_9Line_Var","BCE_CAS_5Line_Var"] # _curType);

_show = _lbCurSel < 1;
_EditBox ctrlShow _show;

call BCE_fnc_ATAK_Refresh_TaskInfos;

//- Set DESC Text
if !(_show) then {
	_EditBox ctrlSetText (_control lbText _lbCurSel);
};