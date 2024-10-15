if (isNil 'cTabHcams') exitWith {};
_camHost = cTabHcams # 1;

_cntrlScreen = _this # 0;
_display = ctrlParent _cntrlScreen;
_pos = getPosASLVisual _camHost;

[_cntrlScreen,false] call cTab_fnc_drawUserMarkers;
[_cntrlScreen,0] call cTab_fnc_drawBftMarkers;

// draw icon at own location
_veh = vehicle cTab_player;
_cntrlScreen drawIcon ["\A3\ui_f\data\map\VehicleIcons\iconmanvirtual_ca.paa",cTabMicroDAGRfontColour,getPosASLVisual _veh,cTabTADownIconBaseSize,cTabTADownIconBaseSize,getDirVisual _veh,"", 1,cTabTxtSize,"TahomaB","right"];

// draw icon at helmet cam location
_cntrlScreen drawIcon ["\A3\ui_f\data\map\VehicleIcons\iconmanvirtual_ca.paa",cTabTADhighlightColour,_pos,cTabTADownIconBaseSize,cTabTADownIconBaseSize,getDirVisual _camHost,"",0,cTabTxtSize,"TahomaB","right"];

_cntrlScreen ctrlMapAnimAdd [0,cTabMapScaleHCam,_pos];
ctrlMapAnimCommit _cntrlScreen;
true