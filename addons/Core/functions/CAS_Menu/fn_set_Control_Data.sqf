/*
  NAME : BCE_fnc_set_Control_Data
  
  Set "BCE_Data" from #LINK - functions/CAS_Menu/fn_RegisterMissionControls.sqf

  PARAMS [
    _control  : the UI control
    _key      : the cfg Entry
  ]
*/
params ["_control","_Entry","_value"];

private _data = _control getVariable ["BCE_Data", createHashMap];
_data set [_Entry,_value];
_control setVariable ["BCE_Data", _data];

_data
