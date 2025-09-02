/*
  NAME : BCE_fnc_get_TaskCurUnit

  Get Current TaskUnit from current controlling unit

  Params : (will get from current setup by Default)
    _unit    : (Optional) 
    _index : [
      _curType : (Optional) 
      _cateSel : (Optional)
    ]

  Return :
    TaskUnit <OBJECT>
*/
params [
  ["_unit", call CBA_fnc_currentUnit],
  ["_index", []]
];

_index params [
	["_type", -1],
	["_cate",["Cate"] call BCE_fnc_get_TaskCurSetup]
];

if (_type < 0) then {
	_type = [_cate] call BCE_fnc_get_TaskCurType;
};

// private _props = [displayNull, _curType, _cateSel] call BCE_fnc_getDisplayTaskProps;
// _props params ["","","","","_taskUnit_Var"]

// private _taskUnit_Var = _props param [4,""];

// if (_taskUnit_Var == "") exitWith {objNull};

_unit getVariable ["#BCE_TaskUnit:" + ([_type,_cate] joinString "|"), objNull];