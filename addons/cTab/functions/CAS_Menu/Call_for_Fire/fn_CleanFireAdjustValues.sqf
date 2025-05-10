/*
  NAME : BCE_fnc_CleanFireAdjustValues

  Return : [0,0]
*/
params ["_control"];

["Adjust", "0,0"] call BCE_fnc_set_FireAdjustValues;

[_control, [0,0]] call BCE_fnc_UpdateFireAdjust; //- with Vector Return