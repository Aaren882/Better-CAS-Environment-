/*
  NAME : BCE_fnc_Update_TaskMapInfo_Lines

  Description:
    Update Each Task Map Info from icons

		Save in (localNamespace "#BCE_TASK_DRAW_ICONS")
*/

private _drawLines = [];
{
  if (_x == "") then {continue};
	private _entry = _x;
	private _curLine = _forEachIndex;
	
	private _task = _taskVar # _curLine;
	private _position = _task param [2, []];

	//- Skip if Task line is Emtpy
		if (_position isEqualTo []) then {continue};
	
	//- format ["%1", _taskVar # 0]
		private _text = format [
			[_entry,"display","%1"] call BCE_fnc_get_TaskMapInfo,
			_task param [0,""]
		];

	//- #ANCHOR - Draw ICON 
	_drawLines pushBack ([
		[_entry,"Icon"] call BCE_fnc_get_TaskMapInfo,
		[_entry,"color",[1,1,1,1]] call BCE_fnc_get_TaskMapInfo,
		_position, //- position
		[_entry,"sizeW",40] call BCE_fnc_get_TaskMapInfo,
		[_entry,"sizeH",40] call BCE_fnc_get_TaskMapInfo,
		[_entry,"angle",0] call BCE_fnc_get_TaskMapInfo,
		_text, 
		[_entry,"shadow",1] call BCE_fnc_get_TaskMapInfo,
		[_entry,"textSize",1] call BCE_fnc_get_TaskMapInfo,
		[_entry,"font","RobotoCondensed"] call BCE_fnc_get_TaskMapInfo,
		[_entry,"align","left"] call BCE_fnc_get_TaskMapInfo
	]);
} forEach _map_Infos;

_drawLines