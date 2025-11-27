/*
  NAME : BCE_fnc_get_Control_Data
  
  Get "BCE_Data" from #LINK - functions/CAS_Menu/fn_RegisterMissionControls.sqf

  PARAMS [
    _control  : the UI control
    _key      : the cfg Entry
  ]
*/
params ["_control","_Entry","_default"];

private _data = _control getVariable ["BCE_Data", createHashMap];
_result =+ _data getOrDefault [_Entry,_default];

_result
