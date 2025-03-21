/*
  NAME : BCE_fnc_drawEach_TaskMapInfo

  Params :
    _map : Map Control be draw on
    _taskDetail : (OPTIONAL) Draw Current Task By Default, e.g. [0,1], [1,1]
*/

params [
  "_map", ["_taskDetail", []]
];

//- Get Entries
private _map_Infos = (_taskDetail call BCE_fnc_getDisplayTaskProps) # 3;

{
  if (_x == "") then {continue};
  [_map, _forEachIndex,_taskDetail] call BCE_fnc_draw_TaskMapInfo;
} forEach _map_Infos;