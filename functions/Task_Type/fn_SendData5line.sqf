params ["_taskUnit","_taskVar"];

_taskVar params ["_taskVar_0","_taskVar_1","_taskVar_2","_taskVar_3","_taskVar_4"];

//-Processing
(_taskVar_0 # 3) params ["_WeapName","_ModeName","_class","_Mode","_turret","_Count","_muzzle","_ATK_range","_ATK_height"];

private _FAD_NA = (_taskVar_4 # 1) == -1;

//-FAD/H
private _FRPOS = _taskVar_1 # 2;
private _TGPOS = _taskVar_2 # 2;

private _POS = if (_FAD_NA) then {
  private _from = _taskUnit;
  // call _drawT
} else {
  (_TGPOS getPos [
    3000,
    _taskVar_4 # 1
  ])
};
private _EGRS = round ((_taskVar_2 # 2) getDirVisual _POS);
// [_taskUnit, [], _POS, _TGPOS, _EGRS, [_class,_Mode,_turret,_Count,_muzzle,_ATK_range,_ATK_height],_taskVar,5] call BCE_fnc_Plane_CASEvent;

[[], _POS, _TGPOS, _EGRS, [_class,_Mode,_turret,_Count,_muzzle,_ATK_range,_ATK_height],_taskVar,5]