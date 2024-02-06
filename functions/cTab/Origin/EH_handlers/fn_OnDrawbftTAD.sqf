disableSerialization;

params ["_cntrlScreen"];

_display = ctrlParent _cntrlScreen;

// current position
_veh = vehicle cTab_player;
_playerPos = getPosASLVisual _veh;
_heading = getDirVisual _veh;
// change scale of map and centre to player position
_cntrlScreen ctrlMapAnimAdd [0, cTabMapScale, _playerPos];
ctrlMapAnimCommit _cntrlScreen;

[_cntrlScreen,false] call cTab_fnc_drawUserMarkers;
[_cntrlScreen,1] call cTab_fnc_drawBftMarkers;

// draw vehicle icon at own location
_cntrlScreen drawIcon [cTabPlayerVehicleIcon,cTabTADfontColour,_playerPos,cTabTADownIconBaseSize,cTabTADownIconBaseSize,_heading,"", 1,cTabTxtSize,"TahomaB","right"];

// draw TAD overlay (two circles, one at full scale, the other at half scale + current heading)
_cntrlScreen drawIcon ["\cTab\img\TAD_overlay_ca.paa",cTabTADfontColour,_playerPos,250,250,_heading,"",1,cTabTxtSize,"TahomaB","right"];

// update hook information
if (cTabDrawMapTools) then {
	_cntrlScreen call BCE_fnc_drawGPS;
};

true
