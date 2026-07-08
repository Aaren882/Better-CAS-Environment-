#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_cTab_ATAK_fnc_ATAK_FireAdjustMeter
Description:
		Toggles the fire adjustment meter value (1 or 5) => (10 meters or 50 meters) for the fire control system,
		updating the corresponding UI control text.

Parameters:
		_control  - The UI control object to be updated and interacted.

Returns:
		<NONE>

Author:
		Aaren
---------------------------------------------------------------------------- */

params ["_control"];
TRACE_1("fn_ATAK_FireAdjustMeter",_this);

private _current = ["CURRENT", ""] call BCE_fnc_get_FireAdjustValues;

//- Check can't be "IMPACT"/NONE
if (_current == "" || _current == "IMPACT") exitWith {};

private _curValue = [_current] call BCE_fnc_get_FireAdjustValues;
_curValue params [["_adjust", "0,0"],["_multiplier", 1]];

// private _curVal = ["Meter", _default] call BCE_fnc_get_FireAdjustValues;
private _result = [1,5] select (_multiplier == 1);

//- Toggle Adjust "Meter" Value
_curValue set [1, _result];
[_current, _curValue] call BCE_fnc_set_FireAdjustValues;

//- Update Bnt Text
_control ctrlSetText format ["<-- %1 m -->", _result * 10];
