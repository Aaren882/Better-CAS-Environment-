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

//- tell the Marker index
private _cursorMarkerIndex = [-1,[_ctrlScreen,cTabMapCursorPos] call cTab_fnc_findUserMarker] select _highlight;
if (_cursorMarkerIndex isEqualType objNull) then {
	_cursorMarkerIndex = -1;
};

private _mapScale = ctrlMapScale _ctrlScreen;
private _text = "";

private _displayName = cTabIfOpen # 1;
private _toggle = [_displayName,"MarkerWidget"] call cTab_fnc_getSettings;

private _toggle_show = false;
private _widgetMode = -1;
if (!isNil {_toggle}) then {
	_toggle_show = _toggle # 0;
	_widgetMode = _toggle # 4;
};

//- is holding LCtrl + Left Click
private _reDirecting = inputMouse "487653376";
private _reSizing = inputMouse "940638208";
private _LMB = (inputMouse 0) > 0;

private _isnt_Drawing = isNil{localNamespace getVariable "BCE_DrawHold_lastClick"};
(localNamespace getVariable ["cTab_Marker_CurSel",[]]) params [["_curSelMarker",-1],"_EditMarker","_drawMode","_Marker_Component"];
(localNamespace getVariable ["cTab_Marker_CurHov",[]]) params [["_hovSel",-1],"_hovCol","_hovmarker"];

{
	_x params ["_marker","_texture","_ID","_markerShape","_def_Size","_editable","_color","_markerDrawMode"];

	private _markerChannel = markerChannel _marker;
	private _onSameChannel = [true, _markerChannel == currentChannel || _markerChannel < 0] select isMultiplayer;
	_color set [3, [0.4, markerAlpha _marker] select _onSameChannel];
	
	//- Marker Data
		[getMarkerPos _marker, markerDir _marker, markerSize _marker] params ["_pos","_dir","_size"];

	//- when the marker having cursor hovering on
		if (
			_onSameChannel &&
			_cursorMarkerIndex == _ID &&
			_curSelMarker < 0 && _isnt_Drawing &&
			_widgetMode == _markerDrawMode && //- Check marker system match with "_markerDrawMode"
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
				private _markerColor = markerColor _marker;
				localNamespace setVariable ["cTab_Marker_CurHov",[_ID,_markerColor,_marker]];
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
			"BCE_" in _marker //- Skip BCE Click Marker
		) then {
			private _name = ((markerType _marker) call BCE_fnc_getMarkerItem) param [0, ""];
			_ctrlScreen drawIcon ["#(rgb,1,1,1)color(0,0,0,0)",_color, _pos vectorDiff _size, 20, 20, 0, _name, 0, cTabTxtSize,"RobotoCondensed","left"];
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
		if (_markerShape == 0) then {
			//- Only for "ICON"
				[_ctrlScreen, _marker, _pos, _color, [_dir,selectMax _size,_mapScale]] call cTab_fnc_DrawMarkerDir;
			continue
		};
} forEach cTabMarkerList;

//- Apply change to Network
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

//- #NOTE - Draw ACE map pointer
	call cTab_fnc_onDrawMapPointer;

//- Check Rangefinder (Requir ACE + cTab 1erGTD)
	call cTab_fnc_DrawRangefinder_ACE;
