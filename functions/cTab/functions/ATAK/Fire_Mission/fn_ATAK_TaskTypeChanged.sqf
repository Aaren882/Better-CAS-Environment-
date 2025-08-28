params ["_control","_lbCurSel"];
private ["_TaskList","_vehicle","_ctrls","_last_CtrlPOS","_ctrlDESC","_ctrlDESC_POS","_ctrl","_curLine","_shownCtrls"];

_TaskList = ctrlParentControlsGroup _control;
_IDCs = getArray (configFile >> "cTab_Android_dlg" >> "TaskIDCs_List");
_vehicle = player getVariable ["TGP_View_Selected_Vehicle",objNull];
uiNameSpace setVariable ["BCE_Current_TaskType",_lbCurSel];

_TaskList call BCE_fnc_ATAK_Refresh_Weapons;

// - ["_9line","_5line"]
// - Output all + hide them all
	_ctrls = [];
	{
		private _enable = _forEachIndex == _lbCurSel;
		_ctrls pushback (_x apply {
			private _ctrl = _TaskList controlsGroupCtrl _x;
			_ctrl ctrlShow _enable;
			_ctrl
		});
	} foreach _IDCs;

	if (_lbCurSel == 1) then {
		(_TaskList controlsGroupCtrl (17000 + 2040)) ctrlSetStructuredText parseText format ["“%1” / “%2”", [groupId group _vehicle, "None"] select isnull _vehicle, groupId group player];
	};

//-Setup Remarks POS on ATAK Mission Builder
_last_CtrlPOS = ctrlPosition (_ctrls # _lbCurSel # -1);
{
	private _ctrl = _TaskList controlsGroupCtrl (3000 + _forEachIndex);
	_ctrl ctrlSetPositionY ((_last_CtrlPOS # 1) + ((_last_CtrlPOS # 3) * (_x + 0.25)));
	_ctrl ctrlcommit 0;
} forEach [1.05, 1.1, 2.35];

_ctrlDESC = _TaskList controlsGroupCtrl (17000 + ([2027,2043] # _lbCurSel));
_ctrlDESC_POS = ctrlPosition _ctrlDESC;

//-Setup DESC POS
_ctrl = _TaskList controlsGroupCtrl (17000 + 2015);
_ctrl ctrlSetPositionY ((_ctrlDESC_POS # 1) + ((_ctrlDESC_POS # 3) * 9 / 7));
_ctrl ctrlcommit 0;

//-Update DESC Selection
_ctrlDESC lbSetCurSel (uiNamespace getVariable ["BCE_ATAK_Desc_Type",0]);