/*
	Name: cTab_fnc_drawUserMarkers

	Author(s):
		Gundy, Riouken

	Edit:
		Aaren

	Description:
		Draw userMarkers held in cTabMarkerList to map control

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
	"_curSelMarker","_isnt_Drawing","_ColorCache"
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
(localNamespace getVariable ["cTab_Marker_CurHov",[]]) params [["_hovSel",-1],"_hovCol"];
_isnt_Drawing = isnil{localNamespace getVariable "BCE_DrawHold_lastClick"};
_ColorCache = uiNamespace getVariable "BCE_Marker_Color";

{
	_x params ["_marker","_texture","_ID","_markerShape","_def_Size","_editable"];

	private ["_markerType","_markerColor","_config","_onSameChannel","_color","_text"];

	_markerType = markerType _marker;
	_markerColor = markerColor _marker;
	_markerChannel = markerChannel _marker;
	_onSameChannel = [true, _markerChannel == currentChannel || _markerChannel < 0] select isMultiplayer;

	_config = configFile >> "CfgMarkers" >> _markerType;
	_color = [];
	{
		if (_markerColor == (_x # 0)) exitWith {
			_color = _x # 1;
		};
	} count _ColorCache;
	_color set [3, [0.4, markerAlpha _marker] select _onSameChannel];
	
	//- Marker Data
		[getMarkerPos _marker, markerDir _marker, markerSize _marker] params ["_pos","_dir","_size"];

	//- when the marker having cursor hovering on
		if (
			_onSameChannel &&
			_cursorMarkerIndex == _ID &&
			_curSelMarker < 0 && _isnt_Drawing &&
			_widgetMode == ([[0],[1,2]] findIf {_x find _markerShape > -1}) && //- ["ICON","RECTANGLE ELLIPSE"]
			(_toggle_show) &&
			_editable //- from Cache List
		) then {
			//- Set Selected Marker
			switch (true) do { //- must before "_LMB" so it wont be skipped
				case (_reSizing && _widgetMode == 0): {
					localNamespace setVariable ["cTab_Marker_CurSel",[_ID,_marker,2,getMousePosition]];
				};
				case (_reDirecting): {
					localNamespace setVariable ["cTab_Marker_CurSel",[_ID,_marker,1]];
				};
				case (_LMB): {
					localNamespace setVariable ["cTab_Marker_CurSel",[_ID,_marker,0,cTabMapCursorPos vectorDiff (markerPos _marker)]];
				};
			};

			//- if no Hover Color
			if (_hovSel < 0) then {
				localNamespace setVariable ["cTab_Marker_CurHov",[_ID,_markerColor]];
				_marker setMarkerColorLocal "cTab_Highlight";
			};
			_color = cTabTADhighlightColour;
		} else {
			if (_hovSel > -1 && _hovSel == _ID) then {
				localNamespace setVariable ["cTab_Marker_CurHov",nil];
				_marker setMarkerColorLocal _hovCol;
			};
		};

		//- Show type of marker
		if (
			_cursorMarkerIndex == _ID &&
			_marker find "BCE_" < 0 //- Skip BCE Click Marker
		) then {
			private _text = getText (_config >> "name");
			_ctrlScreen drawIcon ["#(rgb,1,1,1)color(0,0,0,0)",_color, _pos vectorDiff _size, 20, 20, 0, _text, 0, cTabTxtSize,"RobotoCondensed","left"];
		};

	//- Key Actions
		if (_curSelMarker == _ID && _isnt_Drawing) then {
			switch (true) do {
				//- Change Marker Size (Ctrl + LMB Hold)
				case (_reSizing && _widgetMode == 0): {
					private _s = vectorMagnitude (getMousePosition vectorDiff _Marker_Component);
					_s = 2 min (1 + _s)^2;
					_marker setMarkerSizeLocal [_s,_s];
				};
				//- Change Marker Direction (Ctrl + LMB Hold)
				case (_reDirecting): {
					//- Change marker direction
						private _dir = _pos getDirVisual cTabMapCursorPos;
						_marker setMarkerDirLocal ([_dir,360] select (_dir == 0));
						_ctrlScreen drawIcon ["#(rgb,1,1,1)color(0,0,0,0)",cTabTADhighlightColour,cTabMapCursorPos, 0, 0, 0, format ["%1 %2°",_dir call BCE_fnc_getAzimuth, round _dir], 0, cTabTxtSize * 1.5,"TahomaB"];
						_ctrlScreen drawArrow [_pos, cTabMapCursorPos, cTabTADhighlightColour];
				};
				//- Change marker Position (LMB Hold)
				case (_LMB): {
					_marker setMarkerPosLocal (cTabMapCursorPos vectorDiff _Marker_Component);
				};
			};
		};

	//- draw Marker Icon
		switch (_markerShape) do {
			case 0: {
				
				//- Only for "ICON"
					[_ctrlScreen,_marker,_pos,_color,([_dir,selectMax _size,_mapScale] joinString "|")] call cTab_fnc_DrawMarkerDir;
				
				//- Update Marker Size
				/*_size = _size vectorMultiply (_def_Size + cTabIconSize);
				_text = ["",markerText _marker] select cTabBFTtxt;
				
				_ctrlScreen drawIcon [
					_texture,
					_color,
					_pos,
					_size # 0,
					_size # 1,
					_dir,
					_text,
					[0,1] select markerShadow _marker,
					cTabTxtSize * ([1,1.5] select (_marker find "PLP_SMT_Grid" > -1 && _marker find "_text" > -1)),
					"RobotoCondensed",
					"right"
				];*/
				continue
			};
			default {continue};
		};
} count cTabMarkerList;

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