#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_cTab_ATAK_missions_fnc_ATAK_DescType_Changed
Description:
		Handles the change event for the description type in the mission editor.
		Updates the corresponding UI elements (EditBox) based on the selection.

Parameters:
		_control - The UI control containing the description preset dropdown.
		_lbCurSel - The selected index from the description type dropdown (0, 1, 2...).
		_curLine - The specific task description line being edited (e.g., 5th, 3rd line).

Returns:
		<NONE>.

Author:
		Aaren
---------------------------------------------------------------------------- */

params ["_control", "_lbCurSel","_curLine"];
TRACE_1("fnc_ATAK_DescType_Changed",_this);

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
