/* 
  NAME : BCE_fnc_getCompatibleAVs
*/

vehicles Select {
  (_x isKindOf "Air") && 
  (isEngineOn _x) && 
  (playerSide == side _x)
};