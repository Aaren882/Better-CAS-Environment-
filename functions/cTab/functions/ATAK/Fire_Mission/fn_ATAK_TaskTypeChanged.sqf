/*
	NAME : BCE_fnc_ATAK_TaskTypeChanged
*/
params ["_control","_lbCurSel"];

private _TaskList = ctrlParentControlsGroup _control;
private _group = ctrlParentControlsGroup _TaskList;

//- Update TaskType Value
	private _category = _group controlsGroupCtrl (17000 + 2102);
	private _settings = _lbCurSel call BCE_fnc_ATAK_set_TaskType; //- Update task type in cTab Variable

//- Update Task Control
	["Type", _lbCurSel] call BCE_fnc_set_TaskCurSetup;
	private _MissionCtrl = [_group,_settings] call BCE_fnc_ATAK_updateTaskControl;

//-Setup Remarks POS on ATAK Mission Builder
	/*_last_MissionCtrlPOS = ctrlPosition (_ctrls # _lbCurSel # -1);
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
	_ctrl ctrlcommit 0;*/

if (isNull _MissionCtrl) exitWith {};

//- Initiate 
	private _vehicle = player getVariable ["TGP_View_Selected_Vehicle",objNull];
	_TaskList call BCE_fnc_ATAK_Refresh_Weapons;

	//- Air 5 Line
	if (_lbCurSel == 1) then {
		(_MissionCtrl controlsGroupCtrl (17000 + 2040)) ctrlSetStructuredText parseText format ["“%1” / “%2”", [groupId group _vehicle, "None"] select isnull _vehicle, groupId group player];
	};

//-Update DESC Selection
	private _ctrlDESC = _MissionCtrl controlsGroupCtrl (17000 + 2027);
	_ctrlDESC lbSetCurSel (localNamespace getVariable ["BCE_ATAK_Desc_Type",0]);