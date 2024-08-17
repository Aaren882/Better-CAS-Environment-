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
	"_cursorMarkerIndex","_mapScale","_text",
	"_toggle","_toggle_show",
	"_widgetMode",
	"_reDirecting","_reSizing","_LMB",
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

(localNamespace getVariable ["cTab_Marker_CurSel",[]]) params [["_curSelMarker",-1],"_EditMarker","_drawMode","_Marker_Component"];
_isnt_Drawing = isnil{localNamespace getVariable "BCE_DrawHold_lastClick"};

_getBrush = {
	private _brush = getText (configFile >> "CfgMarkerBrushes" >> markerBrush _this >> "texture");
	if (_brush == "") exitwith {"#(rgb,1,1,1)color(1,1,1,0.5)"};
	if (_brush find "(0,0,0,0)" > -1) exitwith {""};
	_brush
};

{
	//- Skip on Prefix "-"
		if (_x select [0,1] == "-") then {continue};

	private ["_markerType","_markerColor","_markerShape","_config","_texture","_onSameChannel","_color","_text"];

	_markerShape = MarkerShape _x;
	_markerChannel = markerChannel _x;
	_markerType = markerType _x;
	_markerColor = markerColor _x;
	_onSameChannel = [true, _markerChannel == currentChannel || _markerChannel < 0] select isMultiplayer;

	_config = configFile >> "CfgMarkers" >> _markerType;
	_color = getArray ([
		configFile >> "CfgMarkerColors" >> _markerColor >> "Color",
		_config >> "color"
	] select (_markerColor == "Default"));

	_color = _color apply {
		if (_x isEqualType "") then {call compile _x} else {_x};
	};
	_color set [3, [0.4, markerAlpha _x] select _onSameChannel];

	if (_markerShape == "POLYLINE") then {
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
	
	//- Skip if it's System Marker
		if (_markerShape == "ICON" && getNumber (_config >> "size") == 0) then {continue};
	
	//- Marker Data
		_texture = getText (_config >> "icon");
		[getMarkerPos _x, markerDir _x, markerSize _x] params ["_pos","_dir","_size"];

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
			_widgetMode == (["ICON","RECTANGLE ELLIPSE"] findIf {_x find _markerShape > -1}) &&
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

	//- draw Marker Icon
		switch (_markerShape) do {
			case "ICON": {
				
				//- Only for "ICON"
					[_ctrlScreen,_x,_pos,_color,([_dir,selectMax _size,_mapScale] joinString "|")] call cTab_fnc_DrawMarkerDir;
				
				//- Update Marker Size
				_size = _size vectorMultiply cTabIconSize;
				_text = ["",markerText _x] select cTabBFTtxt;
				
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

#if __has_include("\z\ace\addons\map_gestures\config.bin")
	call cTab_fnc_onDrawMapPointer;
#endif