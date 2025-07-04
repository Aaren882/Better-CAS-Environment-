/*
  NAME : BCE_fnc_FuzeVT

  VT fuze trigger condition
*/

params ["_fuzeValue","_projectile","_taskUnit"];

private _pos = getPosASLVisual _projectile;
private _ins = lineIntersectsSurfaces [
  _pos,
  _pos vectorAdd ((vectorDirVisual _projectile) vectorMultiply _fuzeValue),
  _projectile,
  _taskUnit
];

//- Check there anything in front "_fuzeValue" meters
  _ins findIf {true} > -1