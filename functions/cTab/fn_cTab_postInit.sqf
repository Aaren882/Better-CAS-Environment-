#include "\cTab\shared\cTab_gui_macros.hpp"

[cTabSettings,"Tablet",[
	["dlgIfPosition",[]],
	["mode","DESKTOP"],
	["markerColor",0],
	["showIconText",true],
	["mapWorldPos",[]],
	["mapScaleDsp",2],
	["mapScaleDlg",2],
	["MarkerWidget",[false,0,0,[]]],
	["mapTypes",[["SAT",IDC_CTAB_SCREEN],["TOPO",IDC_CTAB_SCREEN_TOPO]]],
	["mapType","SAT"],
	["uavCam",""],
	["hCam",""],
	["BCE_mapTools",false],
	["PLP_mapTools",false],
	["mapTools",true],
	["nightMode",2],
	["Weather_Condition",[false,"","[1,1]"]],
	["brightness",0.9]
]] call BIS_fnc_setToPairs;

[cTabSettings,"Android",[
	["dlgIfPosition",[]],
	["dspIfPosition",false],
	["mode","BFT"],
	["markerColor",0],
	["showIconText",true],
	["mapWorldPos",[]],
	["mapScaleDsp",0.4],
	["mapScaleDlg",0.4],
	["mapTypes",[["SAT",IDC_CTAB_SCREEN],["TOPO",IDC_CTAB_SCREEN_TOPO]]],
	["mapType","SAT"],
	["showMenu",["main",false,-1]],
	["MarkerWidget",[false,0,0,[]]],
	["showModeMenu",false],
	["uavCam",""],
	["uavInfo",false],
	["mapTools",true],
	["PLP_mapTools",false],
	["nightMode",2],
	//- Define Size
	#define PhoneW (profilenamespace getvariable ['IGUI_GRID_cTab_ATAK_DSP_W',(safezoneW * 0.443437)])
	#define CustomPhoneH (profilenamespace getvariable ['IGUI_GRID_cTab_ATAK_DSP_H',(PhoneW * 4/3)])
	["Weather_Condition",[false,"", str [((safezoneW * 0.8) * 4/3) / CustomPhoneH, 1.15]]],

	["brightness",0.9]
]] call BIS_fnc_setToPairs;

[cTabSettings,"FBCB2",[
	["dlgIfPosition",[]],
	["mapWorldPos",[]],
	["showIconText",true],
	["mapScaleDsp",2],
	["mapScaleDlg",2],
	["mapTypes",[["SAT",IDC_CTAB_SCREEN],["TOPO",IDC_CTAB_SCREEN_TOPO]]],
	["mapType","SAT"],
	["mapTools",true],
	["nightMode",0],
	["brightness",0.9],
	["Weather_Condition",[false,""]]
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
