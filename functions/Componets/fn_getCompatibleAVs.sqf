vehicles Select {
  (_x isKindOf "Air") && 
  (isEngineOn _x) && 
  (playerSide == side _x) && 
  ((([_x,0] call BCE_fnc_Check_Optics) findif {true}) > -1)
};