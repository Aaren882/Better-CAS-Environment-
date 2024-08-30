#include "\cTab\shared\cTab_gui_macros.hpp"

[cTabSettings,"Tablet",[
	["dlgIfPosition",[]],
	["mode","DESKTOP"],
	["markerColor",0],
	["showIconText",true],
	["mapWorldPos",[]],
	["mapScaleDsp",2],
	["mapScaleDlg",2],
	["MarkerEDIT",""],
	["MarkerWidget",[false,0,[0,0],[],0,0,100]],
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
	["showMenu",["main",false,-1,[]]],
	["MarkerWidget",[false,0,[0,0],[],0,0,100]],
	["MarkerEDIT",""],
	["Contactor",""],
	["showModeMenu",false],
	["uavInfo",false],
	["mapTools",true],
	["PLP_mapTools",false],
	["nightMode",2],
	["hCam",""],
	
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

[cTabSettings,"TAD",[
	["dlgIfPosition",[]],
	["dspIfPosition",false],
	["mapWorldPos",[]],
	["showIconText",true],
	["mapScaleDsp",2],
	["mapScaleDlg",2],
	["mapScaleMin",1],
	["mapTypes",[["SAT",IDC_CTAB_SCREEN],["TOPO",IDC_CTAB_SCREEN_TOPO],["BLK",IDC_CTAB_SCREEN_BLACK]]],
	["mapType","SAT"],
	["MarkerDropper",[false,0,0]],
	["mapTools",true],
	["nightMode",0],
	["brightness",0.8]
]] call BIS_fnc_setToPairs;

["cTab_checkForPlayerChange", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;

cTabOnDrawbft = ctab_fnc_onDrawbft;
cTabOnDrawbftVeh = ctab_fnc_onDrawbftVeh;
cTabOnDrawbftTAD = ctab_fnc_onDrawbftTAD;
cTabOnDrawbftTADdialog = ctab_fnc_onDrawbftTADdialog;
cTabOnDrawbftAndroid = ctab_fnc_onDrawbftAndroid;
cTabOnDrawbftAndroidDsp = ctab_fnc_onDrawbftAndroidDsp;
cTabOnDrawHCam = ctab_fnc_OnDrawHCam;
cTabOnDrawUAV = ctab_fnc_onDrawUAV;
cTab_Tablet_btnACT = ctab_fnc_Tablet_btnACT;
cTab_msg_gui_load = ctab_fnc_msg_gui_load;

cTabTxtSize = 0.06;

["cTab_msg_receive",
	{
		params ["_msgRecipient","_msgTitle","_msgBody","_msgEncryptionKey","_sender"];

		_playerEncryptionKey = call cTab_fnc_getPlayerEncryptionKey;
		_msgArray = _msgRecipient getVariable ["cTab_messages_" + _msgEncryptionKey,[]];
		// _msgArray pushBack [_msgTitle,_msgBody,0];
		// _msgRecipient setVariable ["cTab_messages_" + _msgEncryptionKey,_msgArray];

		["ctab_messagesUpdated"] call CBA_fnc_localEvent;

		if (
			_msgRecipient == cTab_player && 
			_sender != cTab_player && 
			(_playerEncryptionKey == _msgEncryptionKey) && 
			([cTab_player,ctab_core_leaderDevices] call cTab_fnc_checkGear)
		) then {
			playSound "cTab_phoneVibrate";
			
			private _displayName = cTabIfOpen # 1;
			if (
				!isNil "cTabIfOpen" && 
				(
					"MESSAGE" == ([_displayName,"mode"] call cTab_fnc_getSettings) ||
					"message" in ([_displayName,"showMenu"] call cTab_fnc_getSettings)
				)
			) then {
				[] call cTab_msg_gui_load;

				["MSG",format [localize "STR_BCE_NewMessage",name _sender],6] call cTab_fnc_addNotification;
			} else {
				cTabRscLayerMailNotification cutRsc ["cTab_Mail_ico_disp", "PLAIN"]; 
			};
		};
	}
] call CBA_fnc_addLocalEventHandler;

//- Set Marker Cache
	private _classes = "true" configClasses (configFile >> "cTab_CfgMarkers");
	private _result = _classes apply {
		private ["_Categories","_color","_hide"];
		_Categories = getArray (_x >> "Categories");
		_color = (getArray (_x >> "color")) apply {
			if (_x isEqualType "") then {call compile _x} else {_x};
		};
		_hide = getNumber (_x >> "Hide_Direction");

		_Categories = flatten (_Categories apply {
		(format [ 
			"getText (_x >> 'markerClass') == '%1' && getNumber (_x >> 'scope') > 0", _x 
			]) configClasses (configFile >> "CfgMarkers") apply { 
				configName _x 
			};
		});

		if (_hide > 0) then {
			[_Categories,_color,1]
		} else {
			[_Categories,_color]
		};
	};

	uiNamespace setVariable ["BCE_Marker_Map",(_classes apply {configName _x}) createHashMapFromArray _result];