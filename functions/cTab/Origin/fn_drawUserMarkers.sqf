/*
	Name: cTab_fnc_drawUserMarkers

	Author(s):
		Gundy, Riouken

	Edit:
		Aaren

	Description:
		Draw userMarkers held in cTabUserMarkerList to map control

		List format:
			Index 0: ARRAY	- marker position
			Index 1: STRING - path to marker icon
			Index 2: STRING - path to marker size icon
			Index 3: STRING - direction of reported movement
			Index 4: ARRAY	- marker color
			Index 5: STRING - marker time
			Index 6: STRING - text alignment

	Parameters:
		0: OBJECT	- Map control to draw BFT icons on
		1: BOOLEAN - Highlight marker under cursor

	Returns:
		BOOLEAN - Always TRUE

	Example:
		[_ctrlScreen] call cTab_fnc_drawUserMarkers;
*/

params ["_ctrlScreen","_highlight"];

_arrowLength = cTabUserMarkerArrowSize * ctrlMapScale _ctrlScreen;
_cursorMarkerIndex = [-1,[_ctrlScreen,cTabMapCursorPos] call cTab_fnc_findUserMarker] select _highlight;

_markers = if (isMultiplayer) then {
	allMapMarkers select {markerChannel _x == currentChannel}
} else {
	allMapMarkers
};

//- is holding Left Click
_holding_LM = 2 == inputMouse 0;
_curSelMarker = uiNameSpace getVariable ["cTab_BFT_CurSel",-1];

{
	private ["_config","_hide_Direction","_color","_markerData","_changeDir","_text"];

	_config = configFile >> "CfgMarkers" >> markerType _x;
  _hide_Direction = 1 > parseNumber (((_x select [15]) splitString ":") # 3);

	_texture1 = getText (_config >> "icon");
	_color = (getArray (configFile >> "CfgMarkerColors" >> markerColor _x >> "Color")) apply {
		if (_x isEqualType "") then {call compile _x} else {_x};
	};
	
	_markerData = [getMarkerPos _x, markerDir _x, (markerSize _x) apply {cTabIconSize * _x}];
	_markerData params ["_pos","_dir","_size"];
	
	//- if the marker having cursor hovering on
	if (_forEachIndex isEqualTo _cursorMarkerIndex) then {
		private _text = getText (_config >> "name");
		_ctrlScreen drawIcon ["#(rgb,1,1,1)color(1,1,1,0)",_color, _pos, _size # 0, _size # 1, 0, _text, 0, cTabTxtSize * 1.2,"RobotoCondensed","left"];

		_color = cTabTADhighlightColour;
	};

	_changeDir = (_forEachIndex isEqualTo _curSelMarker) && _holding_LM;
	if (_dir != 0 && _hide_Direction) then {
		private _secondPos = [_pos,_arrowLength * ([1, 2] select _changeDir),_dir] call BIS_fnc_relPos;
		_ctrlScreen drawArrow [_pos, _secondPos, [_color,cTabTADhighlightColour] select _changeDir];
	};
	
	//- Change marker direction
	if (_changeDir) then {
		private _dir = _pos getDirVisual cTabMapCursorPos;
		private _secondPos = [_pos, 2 * _arrowLength, _dir] call BIS_fnc_relPos;
		_x setMarkerDir _dir;
		_ctrlScreen drawIcon ["#(rgb,1,1,1)color(1,1,1,0)",cTabTADhighlightColour,_secondPos, 0, 0, 0, format ["%1 %2°",_dir call BCE_fnc_getAzimuth, round _dir], 0, cTabTxtSize * 1.5,"TahomaB"];
	};

	//- draw Marker Icon
	_text = if (cTabBFTtxt) then {
		markerText _x
	} else {
		""
	};
	_ctrlScreen drawIcon [_texture1,_color,_pos, _size # 0, _size # 1, _dir, _text, 0, cTabTxtSize,"RobotoCondensed"];
	
	false
} forEach _markers;

true
