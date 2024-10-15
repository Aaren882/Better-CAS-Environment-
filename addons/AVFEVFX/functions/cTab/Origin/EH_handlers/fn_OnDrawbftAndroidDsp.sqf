#pragma hemtt flag pe23_ignore_has_include

params ["_cntrlScreen"];

_display = ctrlParent _cntrlScreen;

_veh = vehicle cTab_player;
_playerPos = getPosASLVisual _veh;
_heading = getDirVisual _veh;

// change scale of map and centre to player position
if !(uiNamespace getVariable ["BCE_ATAK_TRACK_Focus",false]) then {
	_cntrlScreen ctrlMapAnimAdd [0, cTabMapScale, _playerPos];
	ctrlMapAnimCommit _cntrlScreen;
};

// [_cntrlScreen,false] call cTab_fnc_drawUserMarkers;
[_cntrlScreen,0] call cTab_fnc_drawBftMarkers;

//- Only for "ICON"
	private _mapScale = ctrlMapScale _cntrlScreen;
	private _ColorCache = uiNamespace getVariable "BCE_Marker_Color";
	{
		private _markerShape = MarkerShape _x;
		private _config = configFile >> "CfgMarkers" >> markerType _x;
		if (
			_x select [0,1] == "-" ||
			_markerShape != "ICON" ||
			(_markerShape == "ICON" && getNumber (_config >> "size") == 0)
		) then {continue};

		private _markerColor = markerColor _x;
		private _markerChannel = markerChannel _x;
		
		private _color = [];
		{
			if (_markerColor == (_x # 0)) exitWith {
				_color = _x # 1;
			};
		} count _ColorCache;

		private _onSameChannel = [true, _markerChannel == currentChannel || _markerChannel < 0] select isMultiplayer;
		_color set [3, [0.4, markerAlpha _x] select _onSameChannel];
		
		[getMarkerPos _x, markerDir _x, selectMax (markerSize _x)] params ["_pos","_dir","_size"];
		[_cntrlScreen,_x,_pos,_color,([_dir, _size,_mapScale] joinString "|")] call cTab_fnc_DrawMarkerDir;
	} forEach allMapMarkers;

	#if __has_include("\z\ace\addons\map_gestures\config.bin")
		call cTab_fnc_onDrawMapPointer;
	#endif

if (cTabDrawMapTools) then {
	[_display,_cntrlScreen] call BCE_fnc_cTabMap;
};

// draw directional arrow at own location
_cntrlScreen drawIcon ["\A3\ui_f\data\map\VehicleIcons\iconmanvirtual_ca.paa",cTabMicroDAGRfontColour,_playerPos,cTabTADownIconBaseSize,cTabTADownIconBaseSize,_heading,"", 1,cTabTxtSize,"TahomaB","right"];

true