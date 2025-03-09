/*
  NAME : BCE_fnc_UpdateFireAdjust

  ["_control","_vector"]

  "_control" - Button Control
  "_vector" - Input 2D Vector e.g. [0,1], [2,0]

  return : Updated 2D Vector
*/
params ["_control",["_vector",[]]];

private _curAdjust = (localNamespace getVariable ["BCE_Fire_Adjust","0,0"]) splitString ",";
_curAdjust = _curAdjust apply {parseNumber _x};

//- on "_control" or "_vector" Empty
if (isNil{_control} || _vector isEqualTo []) exitWith {_curAdjust};

//- Get Multiplier (10m, 50m)
private _group = ctrlParentControlsGroup _control;
private _adjustMeter = _group controlsGroupCtrl 5004;
private _multiplier = _adjustMeter getVariable ["AdjustMeter",1];

_vector = _vector vectorMultiply _multiplier;
private _curAdjust = _curAdjust vectorAdd _vector;

//- Update value
localNamespace setVariable ["BCE_Fire_Adjust",_curAdjust joinString ","];

["BCE_onFireAdjusted", [_group,_curAdjust]] call CBA_fnc_localEvent;

//- Return
_curAdjust