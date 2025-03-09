/* 
  NAME : BCE_fnc_set_FireAdjustValues

  ["_key","_value"]
  
  Set "BCE_Fire_Adjust" Values
  [
    "Adjust" : "0,0",
    "Meter" : 1
  ]
*/
params ["_key","_value"];

private _map = localNamespace getVariable ["BCE_Fire_Adjust",createHashMap];
_map set [_key,_value];

localNamespace setVariable ["BCE_Fire_Adjust", _map];