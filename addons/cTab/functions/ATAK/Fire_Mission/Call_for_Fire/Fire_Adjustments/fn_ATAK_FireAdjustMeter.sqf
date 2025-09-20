/* 
  NAME : BCE_fnc_ATAK_FireAdjustMeter

  ["_control","_value"]

  Toggle Adjust "Meter" Value 1,5
*/
params ["_control"];

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
