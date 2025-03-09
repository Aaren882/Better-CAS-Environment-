/* 
  NAME : BCE_fnc_ATAK_FireAdjustMeter

  ["_control","_value"]

  Toggle Adjust "Meter" Value 1,5
*/
params ["_control"];

private _default = 1;
private _curVal = ["Meter", _default] call BCE_fnc_get_FireAdjustValues;
private _result = [1,5] select (_curVal == _default);

//- Toggle Adjust "Meter" Value
["Meter", _result] call BCE_fnc_set_FireAdjustValues;

//- Update Bnt Text
_control ctrlSetText format ["<-- %1 m -->", _result * 10];