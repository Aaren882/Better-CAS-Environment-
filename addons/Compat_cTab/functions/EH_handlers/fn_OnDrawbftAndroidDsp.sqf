params ["_cntrlScreen"];

private _display = ctrlParent _cntrlScreen;

private _veh = vehicle cTab_player;
private _playerPos = getPosASLVisual _veh;
private _heading = getDirVisual _veh;

// change scale of map and centre to player position
if !(uiNamespace getVariable ["BCE_ATAK_TRACK_Focus",false]) then {
	_cntrlScreen ctrlMapAnimAdd [0, cTabMapScale, _playerPos];
	ctrlMapAnimCommit _cntrlScreen;
};

[_cntrlScreen,0] call cTab_fnc_drawBftMarkers;

//- Only for "ICON"
	private _mapScale = ctrlMapScale _cntrlScreen;
	{
		_x params ["_marker","_texture","_ID","_markerShape","_def_Size","_editable","_color","_markerDrawMode"];
		
		if (
			_markerShape isNotEqualTo 0 ||
			_def_Size isEqualTo 0
		) then {continue};

		private _markerChannel = markerChannel _marker;
		private _onSameChannel = [true, _markerChannel == currentChannel || _markerChannel < 0] select isMultiplayer;
		_color set [3, [0.4, markerAlpha _marker] select _onSameChannel];
		
		[getMarkerPos _marker, markerDir _marker, selectMax (markerSize _marker)] params ["_pos","_dir","_size"];
		[_cntrlScreen, _marker, _pos, _color, [_dir, _size,_mapScale]] call cTab_fnc_DrawMarkerDir;
	} forEach cTabMarkerList;

//- #NOTE - Draw ACE map pointer
	call cTab_fnc_onDrawMapPointer;

if (cTabDrawMapTools) then {
	[_display,_cntrlScreen] call BCE_fnc_cTabMap;
};

// draw directional arrow at own location
_cntrlScreen drawIcon ["\A3\ui_f\data\map\VehicleIcons\iconmanvirtual_ca.paa",cTabMicroDAGRfontColour,_playerPos,cTabTADownIconBaseSize,cTabTADownIconBaseSize,_heading,"", 1,cTabTxtSize,"TahomaB","right"];

true
