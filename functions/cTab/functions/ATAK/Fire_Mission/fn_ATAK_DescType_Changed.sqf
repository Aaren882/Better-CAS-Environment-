/*
	NAME : BCE_fnc_ATAK_DescType_Changed

	PARAMS :
		_control  : Description preset Drop menu
		_lbCurSel : Drop menu Selection (Number 0,1,2...)
		_curLine  : The line of Task Description #NOTE - 5th, 3rd... line
*/
params ["_control", "_lbCurSel","_curLine"];

if (isnull _control) exitWith {};

//- Update Description Sel preset
["Desc",_lbCurSel] call BCE_fnc_set_TaskCurSetup;

//- Get Description EditBox
	(_curLine call BCE_fnc_getTaskComponents) params ["_shownCtrls"];
	_shownCtrls params ["_EditBox"];

private _show = _lbCurSel < 1;
_EditBox ctrlShow _show;

//- Set DESC Text (Enter DESC value)
if !(_show) then {
	_EditBox ctrlSetText (_control lbText _lbCurSel);
	["BCE_TaskBuilding_Enter", [_curLine]] call CBA_fnc_localEvent;
};