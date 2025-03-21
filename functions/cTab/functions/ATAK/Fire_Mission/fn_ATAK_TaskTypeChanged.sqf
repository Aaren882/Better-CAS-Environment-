/*
	NAME : BCE_fnc_ATAK_TaskTypeChanged
*/
params ["_control","_lbCurSel"];

private _TaskList = ctrlParentControlsGroup _control;
private _group = ctrlParentControlsGroup _TaskList;

//- Update TaskType Value
	private _settings = _lbCurSel call BCE_fnc_ATAK_set_TaskType; //- Update task type in cTab Variable

//- Update Task Control
	_lbCurSel call BCE_fnc_set_TaskCurType;
	private _MissionCtrl = [_group,_settings] call BCE_fnc_ATAK_updateTaskControl;

if (isNull _MissionCtrl) exitWith {};

//- Initiate 
	call BCE_fnc_ATAK_Refresh_TaskInfos;

	//- Air 5 Line
	private _vehicle = player getVariable ["TGP_View_Selected_Vehicle",objNull];
	if (_lbCurSel == 1) then {
		(_MissionCtrl controlsGroupCtrl (17000 + 2040)) ctrlSetStructuredText parseText format ["“%1” / “%2”", [groupId group _vehicle, "None"] select isnull _vehicle, groupId group player];
	};
	
	/* _TaskList call BCE_fnc_ATAK_Refresh_Weapons;

//-Update DESC Selection
	private _ctrlDESC = _MissionCtrl controlsGroupCtrl (17000 + 2027);
	private _DESC_Type = ["Desc",0] call BCE_fnc_get_TaskCurSetup;
	_ctrlDESC lbSetCurSel _DESC_Type; */