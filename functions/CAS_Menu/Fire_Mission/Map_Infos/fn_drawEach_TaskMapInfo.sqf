/*
  NAME : BCE_fnc_drawEach_TaskMapInfo

  Params :
    _map : Map Control be draw on
    _taskDetail : (OPTIONAL) Draw Current Task By Default, e.g. [0,1], [1,1]
*/

params ["_map"];

//- Get Entries
private _map_Infos = localNamespace getVariable ["#BCE_TASK_DRAW_ICONS",[]];

{
  _map drawIcon _x;
} forEach _map_Infos;