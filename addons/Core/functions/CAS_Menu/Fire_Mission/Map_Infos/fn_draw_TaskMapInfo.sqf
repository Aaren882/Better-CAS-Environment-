/*
  NAME : BCE_fnc_draw_TaskMapInfo

  Params :
    _map        : Map Control be draw on
    _curLine    : (OPTIONAL) Index (0,1,2)
    _taskDetail : (OPTIONAL) Draw Current Task By Default, e.g. [0,1], [1,1]

    _entry      : element of "Map_Infos[] = {}" in #LINK - Mission_Property.hpp
*/
params ["_map","_curLine",["_taskDetail",[]]];

if (isNil{_curLine}) then {
  _curLine = (ctrlParent _map) call BCE_fnc_get_TaskCurLine;
};

private _map_Infos = (_taskDetail call BCE_fnc_getDisplayTaskProps) # 3;
private _entry = _map_Infos # _curLine;

(_taskDetail call BCE_fnc_getTaskVar) params ["_taskVar","_default"];
private _curValue = (_taskVar # _curLine) param [2, []];

//- Exit if Task line is Emtpy
  if (_curValue isEqualTo []) exitWith {};

//- format ["%1", _taskVar # 0]
  private _text = format [
    [_entry,"display","%1"] call BCE_fnc_get_TaskMapInfo,
    _taskVar # _curLine # 0
  ];

//- Draw ICON #ANCHOR - DRAWING
_map drawIcon [
  [_entry,"Icon"] call BCE_fnc_get_TaskMapInfo,
  [_entry,"color",[1,1,1,1]] call BCE_fnc_get_TaskMapInfo,
  _curValue, //- position
  [_entry,"sizeW",40] call BCE_fnc_get_TaskMapInfo,
  [_entry,"sizeH",40] call BCE_fnc_get_TaskMapInfo,
  [_entry,"angle",0] call BCE_fnc_get_TaskMapInfo,
  _text, 
  [_entry,"shadow",1] call BCE_fnc_get_TaskMapInfo,
  [_entry,"textSize",1] call BCE_fnc_get_TaskMapInfo,
  [_entry,"font","RobotoCondensed"] call BCE_fnc_get_TaskMapInfo,
  [_entry,"align","left"] call BCE_fnc_get_TaskMapInfo
];
