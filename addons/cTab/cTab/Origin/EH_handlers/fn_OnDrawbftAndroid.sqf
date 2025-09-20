params ["_cntrlScreen"];

private _display = ctrlParent _cntrlScreen;

if (isNil{cTabMapScale}) then {
	cTabMapScale = ctrlMapScale _cntrlScreen;
};

[_cntrlScreen,true] call cTab_fnc_drawUserMarkers;
[_cntrlScreen,0] call cTab_fnc_drawBftMarkers;

// draw directional arrow at own location
private _veh = vehicle cTab_player;
private _playerPos = getPosASLVisual _veh;
private _heading = getDirVisual _veh;
_cntrlScreen drawIcon ["\A3\ui_f\data\map\VehicleIcons\iconmanvirtual_ca.paa",cTabMicroDAGRfontColour,_playerPos,cTabTADownIconBaseSize,cTabTADownIconBaseSize,_heading,"", 1,cTabTxtSize,"TahomaB","right"];

// update hook information
if (cTabDrawMapTools) then {
	[_display,_cntrlScreen,_playerPos,cTabMapCursorPos,0,false] call cTab_fnc_drawHook;
	[_display,_cntrlScreen] call BCE_fnc_cTabMap;
};

true
