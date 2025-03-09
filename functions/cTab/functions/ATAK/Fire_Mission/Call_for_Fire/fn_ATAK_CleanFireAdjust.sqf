/*
  NAME : BCE_fnc_ATAK_CleanFireAdjust

  Return : [0,0]
*/
params ["_control"];

localNamespace setVariable ["BCE_Fire_Adjust","0,0"];

[_control, [0,0]] call BCE_fnc_UpdateFireAdjust; //- with Vector Return