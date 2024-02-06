params ["_cntrlScreen"];

_display = ctrlParent _cntrlScreen;

_veh = vehicle cTab_player;
_playerPos = getPosASL _veh;
_heading = direction _veh;

// change scale of map and centre to player position
_cntrlScreen ctrlMapAnimAdd [0, cTabMapScale, _playerPos];
ctrlMapAnimCommit _cntrlScreen;

[_cntrlScreen,false] call cTab_fnc_drawUserMarkers;
[_cntrlScreen,0] call cTab_fnc_drawBftMarkers;

if (cTabDrawMapTools) then {
	[_display,_cntrlScreen] call BCE_fnc_cTabMap;
};

// draw directional arrow at own location
_cntrlScreen drawIcon ["\A3\ui_f\data\map\VehicleIcons\iconmanvirtual_ca.paa",cTabMicroDAGRfontColour,_playerPos,cTabTADownIconBaseSize,cTabTADownIconBaseSize,_heading,"", 1,cTabTxtSize,"TahomaB","right"];

true
