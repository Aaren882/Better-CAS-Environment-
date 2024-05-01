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

private [
	"_mapScale","_arrowLength","_cursorMarkerIndex","_text",
	"_toggle",
	"_markers",
	"_holding_LMB","_LMB",
	"_changeDir","_changePos","_checkInSameWidget",
	"_curSelMarker","_getBrush"
];

_mapScale = ctrlMapScale _ctrlScreen;
_arrowLength = cTabUserMarkerArrowSize * _mapScale;
_cursorMarkerIndex = [-1,[_ctrlScreen,cTabMapCursorPos] call cTab_fnc_findUserMarker] select _highlight;
_text = "";

_toggle = [cTabIfOpen # 1,"MarkerWidget"] call cTab_fnc_getSettings;

_markers = if (isMultiplayer) then {
	allMapMarkers select {markerChannel _x == currentChannel}
} else {
	allMapMarkers
};

//- is holding LCtrl + Left Click
_holding_LMB = inputMouse "487653376";
_LMB = (inputMouse 0) >= 1;

_changeDir = false;
_changePos = false;
_checkInSameWidget = false;
_curSelMarker = uiNameSpace getVariable ["cTab_Marker_CurSel",-1];

_getBrush = {
	private _brush = getText (configFile >> "CfgMarkerBrushes" >> markerBrush _this >> "texture");

	if (_brush == "") then {
		_brush = "#(rgb,1,1,1)color(1,1,1,0.5)";
	};

	if ("(0,0,0,0)" in _brush) then {
		_brush = "";
	};
	_brush
};

{
	private ["_config","_hide_Direction","_Rectangle","_texture","_color","_markerData","_text"];

	_config = configFile >> "CfgMarkers" >> markerType _x;

	//- Only for cTab Markers
  _hide_Direction = if ("cTab" in _x) then {
		private _Data = ((_x select [15]) splitString ":") apply {parseNumber _x};

		//- (_toggle # 4) is "Current Widget Mode" 0. Marker Dropper 1. Drawing tools
			_checkInSameWidget = (_toggle # 4) == (_Data # 4);
		0 < (_Data # 3);
	} else {
		false
	};

	//- Marker Data
		_texture = getText (_config >> "icon");
		_size = markerSize _x;

		_markerData = [getMarkerPos _x, markerDir _x];
		_markerData params ["_pos","_dir"];
		
		_color = (getArray (configFile >> "CfgMarkerColors" >> markerColor _x >> "Color")) apply {
			if (_x isEqualType "") then {call compile _x} else {_x};
		};
		_color set [3, markerAlpha _x];
	
	//- when the marker having cursor hovering on
		if (
			_forEachIndex isEqualTo _cursorMarkerIndex && 
			!("PLP" in _x) && 
			_checkInSameWidget
		) then {

			//- Set Selected Marker
			if (_curSelMarker < 0) then {
				switch (true) do {
					//- Change Marker Direction (Ctrl + LMB)
					case (_holding_LMB): {
						uiNameSpace setVariable ["cTab_Marker_CurSel",_forEachIndex];
					};

					case (_LMB): {
						uiNameSpace setVariable ["cTab_Marker_CurSel",_forEachIndex];
					};
				};
			};

			private _text = getText (_config >> "name");
			_ctrlScreen drawIcon ["#(rgb,1,1,1)color(0,0,0,0)",_color, _pos vectorDiff _size, _size # 0, _size # 1, 0, _text, 0, cTabTxtSize,"RobotoCondensed","left"];
			_color = cTabTADhighlightColour;
		};

		//- Key Actions
			if (_curSelMarker == _forEachIndex) then {
				switch (true) do {
					//- Change Marker Direction (Ctrl + LMB Hold)
					case (_holding_LMB): {
						//- Change marker direction
							private _dir = _pos getDirVisual cTabMapCursorPos;
							_x setMarkerDir _dir;
							_ctrlScreen drawIcon ["#(rgb,1,1,1)color(0,0,0,0)",cTabTADhighlightColour,cTabMapCursorPos, 0, 0, 0, format ["%1 %2°",_dir call BCE_fnc_getAzimuth, round _dir], 0, cTabTxtSize * 1.5,"TahomaB"];
							_ctrlScreen drawArrow [_pos, cTabMapCursorPos, cTabTADhighlightColour];
							_changeDir = true;
					};

					//- Change marker Position (LMB Hold)
					case (_LMB): {
						_x setMarkerPos cTabMapCursorPos;
						_changePos = true;
					};
				};
			};
		
	//- Draw Direction Arrow
		if (_dir != 0 && !_hide_Direction && _changeDir) then {
			private _secondPos = [_pos,_arrowLength,_dir] call BIS_fnc_relPos;
			_ctrlScreen drawArrow [_pos, _secondPos, _color];
		};

	//- draw Marker Icon
		if (cTabBFTtxt) then {
			_text = markerText _x;
		};

		switch (MarkerShape _x) do {
			case "ICON": {};
			case "RECTANGLE": {
				_ctrlScreen drawRectangle [
					_pos ,(_size # 0),(_size # 1),_dir,_color,(_x call _getBrush)
				];
			};
			case "ELLIPSE": {
				_ctrlScreen drawEllipse [
					_pos ,(_size # 0),(_size # 1),_dir,_color,(_x call _getBrush)
				];
			};
			default {continue};
		};

		_size = _size apply {cTabIconSize * _x};
		_ctrlScreen drawIcon [
			_texture,
			_color,
			_pos,
			_size # 0,
			_size # 1,
			_dir,
			_text,
			0,
			cTabTxtSize * ([1,1.5] select ("PLP_SMT_Grid" in _x && "_text" in _x)),
			"RobotoCondensed",
			"right"
		];
} forEach _markers;

if (!_holding_LMB && !_LMB && _curSelMarker > -1) then {
	uiNameSpace setVariable ["cTab_Marker_CurSel",nil];
};