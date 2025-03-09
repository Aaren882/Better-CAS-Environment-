/*
  NAME : BCE_fnc_UpdateFireAdjust

  ["_control","_vector"]

  "_control" - Button Control
  "_vector" - Input 2D Vector e.g. [0,1], [2,0]

  return : Updated 2D Vector
*/
params ["_control",["_vector",[]]];

//- Get Current Adjust
private _cur = ["Adjust", "0,0"] call BCE_fnc_get_FireAdjustValues;
private _curAdjust = (_cur splitString ",") apply {parseNumber _x};

//- on "_control" Empty
if (isNil{_control}) exitWith {_curAdjust};

//- Get Multiplier (10m, 50m)
private _group = ctrlParentControlsGroup _control;
private _multiplier = ["Meter", 1] call BCE_fnc_get_FireAdjustValues;

_vector = _vector vectorMultiply _multiplier;
private _curAdjust = _curAdjust vectorAdd _vector;

//- Update value
["Adjust", _curAdjust joinString ","] call BCE_fnc_set_FireAdjustValues;

["BCE_onFireAdjusted", [_group, _curAdjust]] call CBA_fnc_localEvent;

//- Return
_curAdjust