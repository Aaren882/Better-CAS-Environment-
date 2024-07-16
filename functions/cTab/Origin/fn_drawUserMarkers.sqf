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

#if __has_include("\z\ace\addons\map_gestures\config.bin")
	#define ACE_LOADED 1
#endif

params ["_ctrlScreen","_highlight"];

private [
	"_mapScale","_arrowLength","_cursorMarkerIndex","_text",
	"_toggle",
	"_markers",
	"_holding_LMB","_LMB",
	"_checkInSameWidget",
	"_curSelMarker","_isnt_Drawing","_getBrush"
];

_mapScale = ctrlMapScale _ctrlScreen;
_arrowLength = cTabUserMarkerArrowSize * _mapScale;
_cursorMarkerIndex = [-1,[_ctrlScreen,cTabMapCursorPos] call cTab_fnc_findUserMarker] select _highlight;
_text = "";

_displayName = cTabIfOpen # 1;
_toggle = [_displayName,"MarkerWidget"] call cTab_fnc_getSettings;

_markers = if (isMultiplayer) then {
	allMapMarkers select {markerChannel _x == currentChannel}
} else {
	allMapMarkers
};

//- is holding LCtrl + Left Click
_holding_LMB = inputMouse "487653376";
_LMB = (inputMouse 0) > 0;
	
_checkInSameWidget = false;
(localNamespace getVariable ["cTab_Marker_CurSel",[]]) params [["_curSelMarker",-1],["_drawMode",-1],"_Marker_Component"];
_isnt_Drawing = isnil{localNamespace getVariable "BCE_DrawHold_lastClick"};

_getBrush = {
	private _brush = getText (configFile >> "CfgMarkerBrushes" >> markerBrush _this >> "texture");

	if (_brush == "") exitwith {"#(rgb,1,1,1)color(1,1,1,0.5)"};
	if ("(0,0,0,0)" in _brush) exitwith {""};
	_brush
};

{
	private ["_config","_hide_Direction","_Rectangle","_texture","_size","_color","_markerData","_text"];

	_config = configFile >> "CfgMarkers" >> markerType _x;

	//- Only for cTab Markers
  _hide_Direction = if (
		_x find "cTab" > -1 ||
		_x find "/" > -1
	) then {
		(((_x select [15]) splitString ":") apply {parseNumber _x}) params ["","","","_Channel",["_HideDir",0]];

		//- (_toggle # 4) is "Current Widget Mode" 0. Marker Dropper 1. Drawing tools
			_checkInSameWidget = (_toggle # 4) == _HideDir;
		0 < _Channel
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
	
	//- Show type of marker
		if (_cursorMarkerIndex == _forEachIndex) then {
			private _text = getText (_config >> "name");
			_ctrlScreen drawIcon ["#(rgb,1,1,1)color(0,0,0,0)",_color, _pos vectorDiff _size, 20, 20, 0, _text, 0, cTabTxtSize,"RobotoCondensed","left"];
		};
	
	//- when the marker having cursor hovering on
		if (
			_cursorMarkerIndex == _forEachIndex &&
			_curSelMarker < 0 && _isnt_Drawing &&
			_checkInSameWidget &&
			(_toggle # 0) &&
			!(_x find "PLP" > -1) &&
			(_x find "_cTab_DEFINED" > -1 || _x find "/" > -1)
		) then {
			//- Set Selected Marker
			switch (true) do {
				case (_holding_LMB): { //- must before "_LMB" so it wont be skipped
					localNamespace setVariable ["cTab_Marker_CurSel",[_forEachIndex,1]];
				};
				case (_LMB): {
					localNamespace setVariable ["cTab_Marker_CurSel",[_forEachIndex,0,cTabMapCursorPos vectorDiff (markerPos _x)]];
				};
			};

			_color = cTabTADhighlightColour;
		};

		//- Key Actions
			if (_curSelMarker == _forEachIndex && _isnt_Drawing) then {
				switch (true) do {
					//- Change Marker Direction (Ctrl + LMB Hold)
					case (_holding_LMB && _drawMode == 1): {
						//- Change marker direction
							private _dir = _pos getDirVisual cTabMapCursorPos;
							_x setMarkerDir _dir;
							_ctrlScreen drawIcon ["#(rgb,1,1,1)color(0,0,0,0)",cTabTADhighlightColour,cTabMapCursorPos, 0, 0, 0, format ["%1 %2°",_dir call BCE_fnc_getAzimuth, round _dir], 0, cTabTxtSize * 1.5,"TahomaB"];
							_ctrlScreen drawArrow [_pos, cTabMapCursorPos, cTabTADhighlightColour];
					};

					//- Change marker Position (LMB Hold)
					case (_LMB && _drawMode == 0): {
						_x setMarkerPos (cTabMapCursorPos vectorDiff _Marker_Component);
					};
				};
			};

	//- Draw Direction Arrow
		if (_dir != 0 && !_hide_Direction) then {
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
			1,
			cTabTxtSize * ([1,1.5] select (_x find "PLP_SMT_Grid" > -1 && _x find "_text" > -1)),
			"RobotoCondensed",
			"right"
		];
} forEach _markers;

if (!(_holding_LMB || _LMB) && _curSelMarker > -1) then {
	localNamespace setVariable ["cTab_Marker_CurSel",nil];
};

//- Drawing Tools
	if (1 == _toggle # 4) then {
		call cTab_fnc_DrawArea;
	};

#ifdef ACE_LOADED
	call {
		if (
			!ace_map_gestures_enabled ||
			_toggle # 0 ||
			(inputMouse 0) != 2
		) exitWith {
			if (ace_map_gestures_EnableTransmit) then {
				ace_map_gestures_EnableTransmit = false;
				ACE_player setVariable ["ace_map_gestures_pointPosition", nil, true];
			};
		};

		if (!ace_map_gestures_EnableTransmit) then {
			ace_map_gestures_EnableTransmit = true;
		};

		ace_map_gestures_cursorPosition = _ctrlScreen ctrlMapScreenToWorld getMousePosition;

		if (
			ace_map_gestures_cursorPosition distance2D (ACE_player getVariable ["ace_map_gestures_pointPosition", [0, 0, 0]]) >= 1
		) then {
			[ACE_player, "ace_map_gestures_pointPosition", ace_map_gestures_cursorPosition, ace_map_gestures_interval] call ace_common_fnc_setVariablePublic;
		};
	};
#endif

#ifdef ACE_LOADED
	if (!ace_map_gestures_enabled) exitWith {};
	if (getClientStateNumber < 10) then {
		[_ctrlScreen, ace_map_gestures_briefingMode] call ace_map_gestures_fnc_drawMapGestures;
	} else {
		[_ctrlScreen, [[ACE_player, ace_map_gestures_maxRange]]] call ace_map_gestures_fnc_drawMapGestures;
	};
#endif