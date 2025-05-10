/* 
  NAME : BCE_fnc_get_FireAdjustValues

  ["_key","_default","_replace"]
  
  Get "BCE_Fire_Adjust" Values
  [
    "Adjust" : "0,0",
    "Meter" : 1
  ]
*/
params ["_key",["_default",-1],["_replace",false]];

private _map = localNamespace getVariable ["BCE_Fire_Adjust",createHashMap];

_map getOrDefault [_key, _default, _replace];