/*
  NAME : BCE_fnc_set_CFF_Value

  CFF_MSN       : [
      "_random_POS",
      "_lbAmmo",
      "_setCount",
      "_radius",
      "_fuzeData",
      "_Control_Function_Name",
      "_Sheaf_Info",
      ["_MSN_RECUR", [0,60]] //- #NOTE - [ROUNDS, Interval]
    ]
  NextFuze      : 
  Aim_Index     : 
  chargeInfo    : 
*/

params ["_InputKey","_value","_taskUnit"];

private _fnc = {
  if (isnil{_value}) then {
    _map deleteAt _this;
  } else {
    _map set [_this,_value];
  };
};

private _map = _taskUnit getVariable ["#CFF_MSN_Data", createHashMap];

switch (typeName _InputKey) do {
  case "STRING": {
    _InputKey call _fnc;
  };
  case "ARRAY": {
    {_x call _fnc} forEach _InputKey;
  };
};

_taskUnit setVariable ["#CFF_MSN_Data", _map];