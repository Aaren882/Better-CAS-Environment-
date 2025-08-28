/*
  NAME : BCE_fnc_Update_TaskMapInfo

  Description:
    Update Each Task Map Info from infos
	
  Params :
    _taskDetail : (OPTIONAL) Draw Current Task By Default, e.g. [0,1], [1,1]
*/

params [
  ["_taskDetail", []]
];

//- Get Entries
private _map_Infos = (_taskDetail call BCE_fnc_getDisplayTaskProps) # 3;
(_taskDetail call BCE_fnc_getTaskVar) params ["_taskVar","_default"];

//- Update Icons
	private _drawIcons = call BCE_fnc_Update_TaskMapInfo_Icons;

//- Update Lines/Arrows
	// private _drawLines = call BCE_fnc_Update_TaskMapInfo_Lines;

localNamespace setVariable ["#BCE_TASK_DRAW_ICONS", _drawIcons];
// localNamespace setVariable ["#BCE_TASK_DRAW_LINES", _drawLines];
