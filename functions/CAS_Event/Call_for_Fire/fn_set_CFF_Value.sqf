/*
  NAME : BCE_fnc_set_CFF_Value

  CFF_MSN     : ["_random_POS","_lbAmmo","_setCount","_radius","_fuzeData","_Control_Function_Name"]
  NextFuze    :
  Aim_Index   :
  chargeInfo  :
*/

params ["_key","_value","_taskUnit"];

private _map = _taskUnit getVariable ["#CFF_MSN_Data", createHashMap];

if (isnil{_value}) then {
  _map deleteAt _key;
} else {
  _map set [_key,_value];
};

_taskUnit setVariable ["#CFF_MSN_Data", _map];