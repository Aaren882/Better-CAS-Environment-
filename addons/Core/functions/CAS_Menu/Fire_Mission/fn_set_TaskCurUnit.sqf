/*
  NAME : BCE_fnc_set_TaskCurUnit

  Set Current TaskUnit for current controlling unit

  Params : (will get from current setup by Default)
    _taskUnit <OBJECT> : The object will be stored
    _curType  <NUMBER> : (Optional) Index 0,1,2...
    _cateSel  <NUMBER> : (Optional) Index 0,1,2...

  Return :
    <BOOL>
*/
params ["_taskUnit",["_index", []]];

if (isNil{_taskUnit}) exitWith {false};
_index params [
	["_type", -1],
	["_cate",["Cate"] call BCE_fnc_get_TaskCurSetup]
];

if (_type < 0) then {
	_type = [_cate] call BCE_fnc_get_TaskCurType;
};

// private _props = [displayNull, _curType, _cateSel] call BCE_fnc_getDisplayTaskProps;
// private _taskUnit_Var = _props param [4,""];
private _taskUnit_Var = "#BCE_TaskUnit:" + ([_type,_cate] joinString "|");

private _unit = call CBA_fnc_currentUnit;

//- Check Vehicle Changed
if (_taskUnit == (_unit getVariable [_taskUnit_Var, objNull])) exitWith {
  false
};

_unit setVariable [_taskUnit_Var, _taskUnit];

//- Fire UI BCE_Event
  ["BCE_TaskBuilding_TaskUnitChanged", [_unit, _taskUnit]] call CBA_fnc_localEvent;

true
