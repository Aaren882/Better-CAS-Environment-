if (isNil 'cTabActUav') exitWith {};

params ["_cntrlScreen"];

_pos = getPosASL cTabActUav;

[_cntrlScreen,false] call cTab_fnc_drawUserMarkers;
[_cntrlScreen,0] call cTab_fnc_drawBftMarkers;

// draw icon at own location
_veh = vehicle cTab_player;
_cntrlScreen drawIcon ["\A3\ui_f\data\map\VehicleIcons\iconmanvirtual_ca.paa",cTabMicroDAGRfontColour,getPosASL _veh,cTabTADownIconBaseSize,cTabTADownIconBaseSize,direction _veh,"", 1,cTabTxtSize,"TahomaB","right"];

_cntrlScreen ctrlMapAnimAdd [0,cTabMapScaleUAV,cTabActUav];
ctrlMapAnimCommit _cntrlScreen;
true
