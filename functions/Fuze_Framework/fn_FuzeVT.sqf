/*
  NAME : BCE_fnc_FuzeVT

  VT fuze trigger condition
*/

params ["_fuzeValue","_projectile"];

!(alive _projectile) &&
((vectorDirVisual _projectile) # 2) < 0 && //- Check _projectile is point downward
((getPosVisual _projectile) # 2) < _fuzeValue