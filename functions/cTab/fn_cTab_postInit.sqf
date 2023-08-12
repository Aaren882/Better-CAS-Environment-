#include "\cTab\shared\cTab_gui_macros.hpp"

[cTabSettings,"Tablet",[
	["dlgIfPosition",[]],
	["mode","DESKTOP"],
	["showIconText",true],
	["mapWorldPos",[]],
	["mapScaleDsp",2],
	["mapScaleDlg",2],
	["mapTypes",[["SAT",IDC_CTAB_SCREEN],["TOPO",IDC_CTAB_SCREEN_TOPO]]],
	["mapType","SAT"],
	["uavCam",""],
	["hCam",""],
	["BCE_mapTools",false],
	["mapTools",true],
	["nightMode",2],
	["brightness",0.9]
]] call BIS_fnc_setToPairs;

[cTabSettings,"Android",[
	["dlgIfPosition",[]],
	["dspIfPosition",false],
	["mode","BFT"],
	["showIconText",true],
	["mapWorldPos",[]],
	["mapScaleDsp",0.4],
	["mapScaleDlg",0.4],
	["mapTypes",[["SAT",IDC_CTAB_SCREEN],["TOPO",IDC_CTAB_SCREEN_TOPO]]],
	["mapType","SAT"],
	["showMenu",false],
	["showModeMenu",false],
	["uavCam",""],
	["uavInfo",false],
	["mapTools",true],
	["nightMode",2],
	["brightness",0.9]
]] call BIS_fnc_setToPairs;

["cTab_checkForPlayerChange", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;

cTabOnDrawbft = ctab_fnc_onDrawbft;
cTabOnDrawbftVeh = ctab_fnc_onDrawbftVeh;
cTabOnDrawbftTAD = ctab_fnc_onDrawbftTAD;
cTabOnDrawbftTADdialog = ctab_fnc_onDrawbftTADdialog;
cTabOnDrawbftAndroid = ctab_fnc_onDrawbftAndroid;
cTabOnDrawbftAndroidDsp = ctab_fnc_onDrawbftAndroidDsp;
cTabOnDrawUAV = ctab_fnc_onDrawUAV;
cTab_Tablet_btnACT = ctab_fnc_Tablet_btnACT;
