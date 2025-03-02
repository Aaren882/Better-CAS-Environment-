params ["_control","_lbCurSel"];
// private ["_TaskList","_vehicle","_ctrls","_last_CtrlPOS","_ctrlDESC","_ctrlDESC_POS","_ctrl","_curLine","_shownCtrls"];
privateAll;

_TaskList = ctrlParentControlsGroup _control;
_group = ctrlParentControlsGroup _TaskList;

//- Get Correct Mission Builder
	private _category = _group controlsGroupCtrl (17000 + 2102);
	private _cateData = _category getVariable ["data",[]];
	private _cateSel = lbCurSel _category;
	private _current_Cate = _cateData param [_cateSel,""];
	
_settings = ["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings;

_settings params ["","","_subInfos"];
_subMenu_Map = _subInfos param [2, createHashMap];

if (_current_Cate == "") exitWith {
	["Cannot found Mission Category : ""%1"" !!", _cateSel] call BIS_fnc_error;
};

//- Set SubMenu Infos (HashMap)
	_subMenu_Map set [_current_Cate, _lbCurSel];
	_subInfos set [2, _subMenu_Map];

//- Don't Update Interface (Save Only)
	_settings set [2, _subInfos];
	["cTab_Android_dlg",[["showMenu",_settings]],false] call cTab_fnc_setSettings;

//- Update Task Control
	uiNameSpace setVariable ["BCE_Current_TaskType",_lbCurSel];
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
	_vehicle = player getVariable ["TGP_View_Selected_Vehicle",objNull];
	_TaskList call BCE_fnc_ATAK_Refresh_Weapons;

	//- Air 5 Line
	if (_lbCurSel == 1) then {
		(_MissionCtrl controlsGroupCtrl (17000 + 2040)) ctrlSetStructuredText parseText format ["“%1” / “%2”", [groupId group _vehicle, "None"] select isnull _vehicle, groupId group player];
	};

//-Update DESC Selection
	private _ctrlDESC = _MissionCtrl controlsGroupCtrl (17000 + 2027);
	_ctrlDESC lbSetCurSel (localNamespace getVariable ["BCE_ATAK_Desc_Type",0]);