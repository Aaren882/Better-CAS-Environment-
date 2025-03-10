params ["_control", "_lbCurSel"];
// private ["_TaskList","_EditBox","_curType","_taskVar","_show"];
privateAll;

["Desc",_lbCurSel] call BCE_fnc_set_TaskCurSetup;

_TaskList = ctrlParentControlsGroup _control;
_EditBox = _TaskList controlsGroupCtrl (17000 + 2015);

_show = _lbCurSel < 1;
_EditBox ctrlShow _show;

call BCE_fnc_ATAK_Refresh_TaskInfos;

//- Set DESC Text
if !(_show) then {
	_EditBox ctrlSetText (_control lbText _lbCurSel);
};