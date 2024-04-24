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

{
	// _markerData = _x # 1;
	// _markerData params ["_pos","_texture1","_texture2","_dir","_color"];
	private ["_config","_icon","_color","_markerData","_text"];
	_config = configFile >> "CfgMarkers" >> markerType _x;

	_icon = getText (_config >> "icon");
	_color = (getArray (configFile >> "CfgMarkerColors" >> markerColor _x >> "Color")) apply {
		if (_x isEqualType "") then {call compile _x} else {_x};
	};
	
	_markerData = [getMarkerPos _x, _icon, markerDir _x, (markerSize _x) apply {cTabIconSize * _x}];
	_markerData params ["_pos","_texture1","_dir","_size"];
	
	//- if the marker having cursor hovering on
	if (_forEachIndex isEqualTo _cursorMarkerIndex) then {
		_color = cTabTADhighlightColour;
		_secondPos = [_pos,_arrowLength,_dir] call BIS_fnc_relPos;
		_ctrlScreen drawArrow [_pos, _secondPos, _color];
	};

	_text = if (cTabBFTtxt) then {
		markerText _x;
	} else {
		""
	};
	_ctrlScreen drawIcon [_texture1,_color,_pos, _size # 0, _size # 1, 0, _text, 0, cTabTxtSize,"TahomaB"];
	
	false
} forEach _markers;

true
