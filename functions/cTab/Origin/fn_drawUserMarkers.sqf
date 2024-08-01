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
	"_cursorMarkerIndex","_mapScale","_text",
	"_toggle","_toggle_show",
	"_widgetMode",
	"_reDirecting","_reSizing","_LMB",
	"_checkInSameWidget",
	"_curSelMarker","_isnt_Drawing","_getBrush"
];

//- tell the Marker index
_cursorMarkerIndex = [-1,[_ctrlScreen,cTabMapCursorPos] call cTab_fnc_findUserMarker] select _highlight;
if (_cursorMarkerIndex isEqualType objNull) then {
	_cursorMarkerIndex = -1;
};

_mapScale = ctrlMapScale _ctrlScreen;
_text = "";

_displayName = cTabIfOpen # 1;
_toggle = [_displayName,"MarkerWidget"] call cTab_fnc_getSettings;
if (isNil {_toggle}) then {
	_toggle_show = false;
	_widgetMode = -1;
} else {
	_toggle_show = _toggle # 0;
	_widgetMode = _toggle # 4;
};


//- is holding LCtrl + Left Click
_reDirecting = inputMouse "487653376";
_reSizing = inputMouse "940638208";
_LMB = (inputMouse 0) > 0;

_checkInSameWidget = false;
(localNamespace getVariable ["cTab_Marker_CurSel",[]]) params [["_curSelMarker",-1],"_EditMarker","_drawMode","_Marker_Component"];
_isnt_Drawing = isnil{localNamespace getVariable "BCE_DrawHold_lastClick"};

_getBrush = {
	private _brush = getText (configFile >> "CfgMarkerBrushes" >> markerBrush _this >> "texture");

	if (_brush == "") exitwith {"#(rgb,1,1,1)color(1,1,1,0.5)"};
	if ("(0,0,0,0)" in _brush) exitwith {""};
	_brush
};

{
	private ["_markerType","_markerShape","_config","_onSameChannel","_hide_Direction","_texture","_color","_text"];

	_markerType = markerType _x;
	_markerShape = MarkerShape _x;
	_markerChannel = markerChannel _x;
	_config = configFile >> "CfgMarkers" >> _markerType;
	
	//- Skip if it's System Marker
		if (_markerShape == "ICON" && getNumber (_config >> "size") == 0) then {continue};

	_onSameChannel = [true, _markerChannel == currentChannel || _markerChannel < 0] select isMultiplayer;

	//- Only for cTab Markers
  _hide_Direction = if (
		_x find "_cTab" > -1 || _x find "_USER" > -1
	) then {
		(((_x select [15]) splitString "/") apply {parseNumber _x}) params ["","","","_HideDir",["_type",0],""];

		//- Optimize
			if (isnil{_HideDir}) then {
				private _values = values (uiNamespace getVariable "bce_marker_map");
				private _find = _values findIf {_markerType in (_x # 0)};
				_HideDir = (_values # _find) param [2, 0];
			};

		//- "_widgetMode" is "Current Widget Mode" 0. Marker Dropper 1. Drawing tools
			_checkInSameWidget = _widgetMode == _type;
		0 < _HideDir
	} else {
		false
	};

	//- Marker Data
		_texture = getText (_config >> "icon");
		[getMarkerPos _x, markerDir _x, markerSize _x] params ["_pos","_dir","_size"];
		
		_color = (getArray (configFile >> "CfgMarkerColors" >> markerColor _x >> "Color")) apply {
			if (_x isEqualType "") then {call compile _x} else {_x};
		};
		_color set [3, [0.4, markerAlpha _x] select _onSameChannel];
	
	//- Show type of marker
		if (
			_cursorMarkerIndex == _forEachIndex &&
			_x find "BCE_" < 0 //- Skip BCE Click Marker
		) then {
			private _text = getText (_config >> "name");
			_ctrlScreen drawIcon ["#(rgb,1,1,1)color(0,0,0,0)",_color, _pos vectorDiff _size, 20, 20, 0, _text, 0, cTabTxtSize,"RobotoCondensed","left"];
		};
	
	//- when the marker having cursor hovering on
		if (
			_onSameChannel &&
			_cursorMarkerIndex == _forEachIndex &&
			_curSelMarker < 0 && _isnt_Drawing &&
			_checkInSameWidget &&
			(_toggle_show) &&
			!(_x find "PLP" > -1) &&
			(_x find "_cTab" > -1 || _x find "_USER" > -1)
		) then {
			//- Set Selected Marker
			switch (true) do { //- must before "_LMB" so it wont be skipped
				case (_reSizing && _widgetMode == 0): {
					localNamespace setVariable ["cTab_Marker_CurSel",[_forEachIndex,_x,2,getMousePosition]];
				};
				case (_reDirecting): {
					localNamespace setVariable ["cTab_Marker_CurSel",[_forEachIndex,_x,1]];
				};
				case (_LMB): {
					localNamespace setVariable ["cTab_Marker_CurSel",[_forEachIndex,_x,0,cTabMapCursorPos vectorDiff (markerPos _x)]];
				};
			};

			_color = cTabTADhighlightColour;
		};

		//- Key Actions
			if (_curSelMarker == _forEachIndex && _isnt_Drawing) then {
				switch (true) do {
					//- Change Marker Size (Ctrl + LMB Hold)
					case (_reSizing && _widgetMode == 0): {
						private _s = vectorMagnitude (getMousePosition vectorDiff _Marker_Component);
						_s = 2 min (1 + _s)^2;
						_x setMarkerSizeLocal [_s,_s];
					};
					//- Change Marker Direction (Ctrl + LMB Hold)
					case (_reDirecting): {
						//- Change marker direction
							private _dir = _pos getDirVisual cTabMapCursorPos;
							_x setMarkerDirLocal ([_dir,360] select (_dir == 0));
							_ctrlScreen drawIcon ["#(rgb,1,1,1)color(0,0,0,0)",cTabTADhighlightColour,cTabMapCursorPos, 0, 0, 0, format ["%1 %2°",_dir call BCE_fnc_getAzimuth, round _dir], 0, cTabTxtSize * 1.5,"TahomaB"];
							_ctrlScreen drawArrow [_pos, cTabMapCursorPos, cTabTADhighlightColour];
					};
					//- Change marker Position (LMB Hold)
					case (_LMB): {
						_x setMarkerPosLocal (cTabMapCursorPos vectorDiff _Marker_Component);
					};
				};
			};

	//- Draw Direction Arrow
		if (_dir != 0 && !_hide_Direction) then {
			private _arrowLength = cTabUserMarkerArrowSize * _mapScale * selectMax _size;
			private _secondPos = [_pos,_arrowLength,_dir] call BIS_fnc_relPos;
			_ctrlScreen drawArrow [_pos, _secondPos, _color];
		};

	//- draw Marker Icon
		_text = if (cTabBFTtxt) then {
			markerText _x;
		} else {
			""
		};

		switch (_markerShape) do {
			case "ICON": {
				//- Update Marker Size
					_size = _size vectorMultiply cTabIconSize;
				_ctrlScreen drawIcon [
					_texture,
					_color,
					_pos,
					_size # 0,
					_size # 1,
					_dir,
					_text,
					[0,1] select markerShadow _x,
					cTabTxtSize * ([1,1.5] select (_x find "PLP_SMT_Grid" > -1 && _x find "_text" > -1)),
					"RobotoCondensed",
					"right"
				];
				continue
			};
			case "POLYLINE": {
				private _lines = markerPolyline _x;

				for "_i" from 0 to (count _lines) - 3 step 2 do {
					_ctrlScreen drawLine [
						[_lines # _i, _lines # (_i + 1)],
						[_lines # (_i + 2), _lines # (_i + 3)],
						_color
					];
				};

				continue
			};
			case "RECTANGLE": {
				_ctrlScreen drawRectangle [
					_pos ,(_size # 0),(_size # 1),_dir,_color,(_x call _getBrush)
				];
				continue
			};
			case "ELLIPSE": {
				_ctrlScreen drawEllipse [
					_pos ,(_size # 0),(_size # 1),_dir,_color,(_x call _getBrush)
				];
				continue
			};
			default {continue};
		};
} forEach allMapMarkers;

if (!(_reDirecting || _reSizing || _LMB) && _curSelMarker > -1) then {
	switch (_drawMode) do {
		case 2: {
			_EditMarker setMarkerSize MarkerSize _EditMarker;
		};
		case 1: {
			_EditMarker setMarkerDir MarkerDir _EditMarker;
		};
		case 0: {
			_EditMarker setMarkerPos MarkerPos _EditMarker;
		};
	};
	localNamespace setVariable ["cTab_Marker_CurSel",nil];
};

//- Drawing Tools
	if (_widgetMode == 1) then {
		call cTab_fnc_DrawArea;
	};

#ifdef ACE_LOADED
	if !(ace_map_gestures_enabled) exitWith {};

	call {
		if (
			_toggle_show || (inputMouse 0) != 2
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

	if (getClientStateNumber < 10) then {
		[_ctrlScreen, ace_map_gestures_briefingMode] call cTab_fnc_DrawMapPointer;
	} else {
		[_ctrlScreen, [[ACE_player, ace_map_gestures_maxRange]]] call cTab_fnc_DrawMapPointer;
	};
#endif