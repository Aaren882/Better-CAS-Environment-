/*
	NAME : BCE_fnc_ATAK_TaskTypeChanged
*/
params ["_control","_lbCurSel"];

private _TaskList = ctrlParentControlsGroup _control;
private _group = ctrlParentControlsGroup _TaskList;

//- Update TaskType Value
	private _settings = _lbCurSel call BCE_fnc_ATAK_set_TaskType; //- Update task type in cTab Variable
	private _curCate = ["Cate"] call BCE_fnc_get_TaskCurSetup;

switch (_curCate) do {
	case 0: { //- Air Fire Support

		//- Save Type Selection (use for UI changes AIR_9, AIR_5)
			_lbCurSel call BCE_fnc_set_TaskCurType;

		//- Update Task Control
		private _MissionCtrl = [_group,_settings] call BCE_fnc_ATAK_updateTaskControl;

		if (isNull _MissionCtrl) exitWith {};

		//- Air 5 Line
		private _vehicle = [] call BCE_fnc_get_TaskCurUnit;
		if (_lbCurSel == 1) then {
			(_MissionCtrl controlsGroupCtrl (17000 + 2040)) ctrlSetStructuredText parseText format ["“%1” / “%2”", [groupId group _vehicle, "None"] select isnull _vehicle, groupId group player];
		};
	};
	case 1: { //- Call for Fire
		
		//- Save Type Selection (use for UI changes AIR_9, AIR_5)
			_lbCurSel call BCE_fnc_set_TaskCurType;

		//- Update Task Control
		private _MissionCtrl = [_group,_settings] call BCE_fnc_ATAK_updateTaskControl;
	};
};