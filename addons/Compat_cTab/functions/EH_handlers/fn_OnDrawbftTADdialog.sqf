params ["_cntrlScreen"];

private _display = ctrlParent _cntrlScreen;

cTabMapScale = ctrlMapScale _cntrlScreen;

[_cntrlScreen,true] call cTab_fnc_drawUserMarkers;
[_cntrlScreen,1] call cTab_fnc_drawBftMarkers;

// draw vehicle icon at own location
private _veh = vehicle cTab_player;
private _playerPos = getPosASLVisual _veh;
private _heading = getDirVisual _veh;
_cntrlScreen drawIcon [cTabPlayerVehicleIcon,cTabTADfontColour,_playerPos,cTabTADownIconScaledSize,cTabTADownIconScaledSize,_heading,"", 1,cTabTxtSize,"TahomaB","right"];

// update hook information
if (cTabDrawMapTools) then {
	[_display,_cntrlScreen,_playerPos,cTabMapCursorPos,0,true] call cTab_fnc_drawHook;
	_cntrlScreen call BCE_fnc_drawGPS;
} else {
	[_display,_cntrlScreen,_playerPos,cTabMapCursorPos,1,true] call cTab_fnc_drawHook;
};

true
