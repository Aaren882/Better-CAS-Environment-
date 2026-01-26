disableSerialization;

params ["_cntrlScreen"];


// current position
_veh = vehicle cTab_player;
_playerPos = getPosASLVisual _veh;
_heading = getDirVisual _veh;

// change scale of map and centre to player position
_cntrlScreen ctrlMapAnimAdd [0, cTabMapScale, _playerPos];
ctrlMapAnimCommit _cntrlScreen;

// [_cntrlScreen,false] call cTab_fnc_drawUserMarkers;
[_cntrlScreen,1] call cTab_fnc_drawBftMarkers;

//- Only for "ICON"
	private _mapScale = ctrlMapScale _cntrlScreen;
	{
		_x params ["_marker","_texture","_ID","_markerShape","_def_Size","_editable","_color","_markerDrawMode"];

		if (
			_marker select [0,1] == "-" ||
			_markerShape isNotEqualTo 0 ||
			_def_Size isEqualTo 0
		) then {continue};

		private _markerChannel = markerChannel _marker;
		private _onSameChannel = [true, _markerChannel == currentChannel || _markerChannel < 0] select isMultiplayer;
		_color set [3, [0.4, markerAlpha _marker] select _onSameChannel];
		
		[getMarkerPos _marker, markerDir _marker, selectMax (markerSize _marker)] params ["_pos","_dir","_size"];
		[_cntrlScreen, _marker, _pos, _color, ([_dir, _size,_mapScale] joinString "|")] call cTab_fnc_DrawMarkerDir;
	} forEach cTabMarkerList;

//- #NOTE - Draw ACE map pointer
	call cTab_fnc_onDrawMapPointer;
	
// draw vehicle icon at own location
_cntrlScreen drawIcon [cTabPlayerVehicleIcon,cTabTADfontColour,_playerPos,cTabTADownIconBaseSize,cTabTADownIconBaseSize,_heading,"", 1,cTabTxtSize,"TahomaB","right"];

// draw TAD overlay (two circles, one at full scale, the other at half scale + current heading)
_cntrlScreen drawIcon ["\cTab\img\TAD_overlay_ca.paa",cTabTADfontColour,_playerPos,250,250,_heading,"",1,cTabTxtSize,"TahomaB","right"];

// update hook information
if (cTabDrawMapTools) then {
	_cntrlScreen call BCE_fnc_drawGPS;
};

true
