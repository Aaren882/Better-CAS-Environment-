/*
  NAME : BCE_fnc_FuzeDelay

  Delay fuze trigger condition
*/

params ["_fuzeValue","_projectile"];

private _pos = getPosASLVisual _projectile;
private _ins = lineIntersectsSurfaces [
  _pos,
  _pos vectorAdd ((vectorDirVisual _projectile) vectorMultiply (5 * _fuzeValue))
];

if (
  _ins findIf {true} > -1
) exitWith {
  _projectile setPosASL ((_ins # 0 # 0) vectorAdd ((velocity _projectile) vectorMultiply (5 * _fuzeValue)));
  true
};

!(alive _projectile)