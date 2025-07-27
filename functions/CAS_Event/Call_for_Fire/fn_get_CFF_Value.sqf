/*
  NAME : BCE_fnc_get_CFF_Value

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
  Aim_Index     : 
  chargeInfo    : 
*/

params ["_key","_default","_taskUnit"];

private _map = _taskUnit getVariable ["#CFF_MSN_Data", createHashMap];
_map getOrDefault [_key, _default];