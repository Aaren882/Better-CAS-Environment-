["cTab_checkForPlayerChange", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;

cTabOnDrawbft = {
	_cntrlScreen = _this # 0;
	_display = ctrlParent _cntrlScreen;

	cTabMapWorldPos = [_cntrlScreen] call cTab_fnc_ctrlMapCenter;
	cTabMapScale = ctrlMapScale _cntrlScreen;

	[_cntrlScreen,true] call cTab_fnc_drawUserMarkers;
	[_cntrlScreen,0] call cTab_fnc_drawBftMarkers;

	// draw directional arrow at own location
	_veh = vehicle cTab_player;
	_playerPos = getPosASLVisual _veh;
	_heading = getDirVisual _veh;
	_cntrlScreen drawIcon ["\A3\ui_f\data\map\VehicleIcons\iconmanvirtual_ca.paa",cTabMicroDAGRfontColour,_playerPos,cTabTADownIconBaseSize,cTabTADownIconBaseSize,_heading,"", 1,cTabTxtSize,"TahomaB","right"];

	// update hook information
	if (cTabDrawMapTools) then {
		[_display,_cntrlScreen,_playerPos,cTabMapCursorPos,0,false] call cTab_fnc_drawHook;
    [_display,_cntrlScreen] call BCE_fnc_cTabMap;
  };

	true
};

cTabOnDrawbftAndroid = {
	_cntrlScreen = _this # 0;
	_display = ctrlParent _cntrlScreen;

	cTabMapWorldPos = [_cntrlScreen] call cTab_fnc_ctrlMapCenter;
	cTabMapScale = ctrlMapScale _cntrlScreen;

	[_cntrlScreen,true] call cTab_fnc_drawUserMarkers;
	[_cntrlScreen,0] call cTab_fnc_drawBftMarkers;

	// draw directional arrow at own location
	_veh = vehicle cTab_player;
	_playerPos = getPosASLVisual _veh;
	_heading = getDirVisual _veh;
	_cntrlScreen drawIcon ["\A3\ui_f\data\map\VehicleIcons\iconmanvirtual_ca.paa",cTabMicroDAGRfontColour,_playerPos,cTabTADownIconBaseSize,cTabTADownIconBaseSize,_heading,"", 1,cTabTxtSize,"TahomaB","right"];

	// update hook information
	if (cTabDrawMapTools) then {
		[_display,_cntrlScreen,_playerPos,cTabMapCursorPos,0,false] call cTab_fnc_drawHook;
    [_display,_cntrlScreen] call BCE_fnc_cTabMap;
  };

	true
};

cTabOnDrawbftVeh = {
	_cntrlScreen = _this # 0;
	_display = ctrlParent _cntrlScreen;

	cTabMapWorldPos = [_cntrlScreen] call cTab_fnc_ctrlMapCenter;
	cTabMapScale = ctrlMapScale _cntrlScreen;

	[_cntrlScreen,true] call cTab_fnc_drawUserMarkers;
	[_cntrlScreen,0] call cTab_fnc_drawBftMarkers;

	// draw directional arrow at own location
	_veh = vehicle cTab_player;
	_playerPos = getPosASLVisual _veh;
	_heading = getDirVisual _veh;
	_cntrlScreen drawIcon ["\A3\ui_f\data\map\VehicleIcons\iconmanvirtual_ca.paa",cTabMicroDAGRfontColour,_playerPos,cTabTADownIconBaseSize,cTabTADownIconBaseSize,_heading,"", 1,cTabTxtSize,"TahomaB","right"];

	// update hook information
	if (cTabDrawMapTools) then {
		[_display,_cntrlScreen,_playerPos,cTabMapCursorPos,0,false] call cTab_fnc_drawHook;
    _cntrlScreen call BCE_fnc_drawGPS;
  };

	true
};

cTabOnDrawbftTADdialog = {
	disableSerialization;

	_cntrlScreen = _this # 0;
	_display = ctrlParent _cntrlScreen;

	cTabMapWorldPos = [_cntrlScreen] call cTab_fnc_ctrlMapCenter;
	cTabMapScale = ctrlMapScale _cntrlScreen;

	[_cntrlScreen,true] call cTab_fnc_drawUserMarkers;
	[_cntrlScreen,1] call cTab_fnc_drawBftMarkers;

	// draw vehicle icon at own location
	_veh = vehicle cTab_player;
	_playerPos = getPosASLVisual _veh;
	_heading = getDirVisual _veh;
	_cntrlScreen drawIcon [cTabPlayerVehicleIcon,cTabTADfontColour,_playerPos,cTabTADownIconScaledSize,cTabTADownIconScaledSize,_heading,"", 1,cTabTxtSize,"TahomaB","right"];

	// update hook information
	call {
		if (cTabDrawMapTools) exitWith {
			[_display,_cntrlScreen,_playerPos,cTabMapCursorPos,0,true] call cTab_fnc_drawHook;
      [_display,_cntrlScreen] call BCE_fnc_cTabMap;
    };
		[_display,_cntrlScreen,_playerPos,cTabMapCursorPos,1,true] call cTab_fnc_drawHook;
	};
	true
};

cTabOnDrawbftMicroDAGRdlg = {
	_cntrlScreen = _this # 0;
	_display = ctrlParent _cntrlScreen;

	cTabMapWorldPos = [_cntrlScreen] call cTab_fnc_ctrlMapCenter;
	cTabMapScale = ctrlMapScale _cntrlScreen;

	// current position
	_veh = vehicle cTab_player;
	_playerPos = getPosASLVisual _veh;
	_heading = getDirVisual _veh;

	[_cntrlScreen,false] call cTab_fnc_drawUserMarkers;
	[_cntrlScreen,cTabMicroDAGRmode] call cTab_fnc_drawBftMarkers;

	// draw directional arrow at own location
	_cntrlScreen drawIcon ["\A3\ui_f\data\map\VehicleIcons\iconmanvirtual_ca.paa",cTabMicroDAGRfontColour,_playerPos,cTabTADownIconBaseSize,cTabTADownIconBaseSize,_heading,"", 1,cTabTxtSize,"TahomaB","right"];

	// update hook information
	if (cTabDrawMapTools) then {
		[_display,_cntrlScreen,_playerPos,cTabMapCursorPos,0,false] call cTab_fnc_drawHook;
    [_display,_cntrlScreen] call BCE_fnc_cTabMap;
  };

	true
};

cTabOnDrawbftTAD = {
	disableSerialization;

	_cntrlScreen = _this # 0;
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
};

cTabOnDrawbftmicroDAGRdsp = {
	_cntrlScreen = _this # 0;
	_display = ctrlParent _cntrlScreen;

	// current position
	_veh = vehicle cTab_player;
	_playerPos = getPosASLVisual _veh;
	_heading = getDirVisual _veh;
	// change scale of map and centre to player position
	_cntrlScreen ctrlMapAnimAdd [0, cTabMapScale, _playerPos];
	ctrlMapAnimCommit _cntrlScreen;

	[_cntrlScreen,false] call cTab_fnc_drawUserMarkers;
	[_cntrlScreen,cTabMicroDAGRmode] call cTab_fnc_drawBftMarkers;

	// draw directional arrow at own location
	_cntrlScreen drawIcon ["\A3\ui_f\data\map\VehicleIcons\iconmanvirtual_ca.paa",cTabMicroDAGRfontColour,_playerPos,cTabTADownIconBaseSize,cTabTADownIconBaseSize,_heading,"", 1,cTabTxtSize,"TahomaB","right"];

	true
};

cTabOnDrawbftAndroidDsp = {
	_cntrlScreen = _this # 0;
	_display = ctrlParent _cntrlScreen;

	_veh = vehicle cTab_player;
	_playerPos = getPosASLVisual _veh;
	_heading = getDirVisual _veh;

	// change scale of map and centre to player position
	_cntrlScreen ctrlMapAnimAdd [0, cTabMapScale, _playerPos];
	ctrlMapAnimCommit _cntrlScreen;

	[_cntrlScreen,false] call cTab_fnc_drawUserMarkers;
	[_cntrlScreen,0] call cTab_fnc_drawBftMarkers;

	// draw directional arrow at own location
	_cntrlScreen drawIcon ["\A3\ui_f\data\map\VehicleIcons\iconmanvirtual_ca.paa",cTabMicroDAGRfontColour,_playerPos,cTabTADownIconBaseSize,cTabTADownIconBaseSize,_heading,"", 1,cTabTxtSize,"TahomaB","right"];

	true
};

cTabOnDrawUAV = {
	if (isNil 'cTabActUav') exitWith {};

	_cntrlScreen = _this # 0;
	_display = ctrlParent _cntrlScreen;
	_pos = getPosASL cTabActUav;

	[_cntrlScreen,false] call cTab_fnc_drawUserMarkers;
	[_cntrlScreen,0] call cTab_fnc_drawBftMarkers;

	// draw icon at own location
	_veh = vehicle cTab_player;
	_cntrlScreen drawIcon ["\A3\ui_f\data\map\VehicleIcons\iconmanvirtual_ca.paa",cTabMicroDAGRfontColour,getPosASL _veh,cTabTADownIconBaseSize,cTabTADownIconBaseSize,direction _veh,"", 1,cTabTxtSize,"TahomaB","right"];

	// draw icon at UAV location
	_cntrlScreen drawIcon ["\A3\ui_f\data\map\VehicleIcons\iconmanvirtual_ca.paa",cTabTADhighlightColour,_pos,cTabTADownIconBaseSize,cTabTADownIconBaseSize,direction cTabActUav,"",0,cTabTxtSize,"TahomaB","right"];

	_cntrlScreen ctrlMapAnimAdd [0,cTabMapScaleUAV,_pos];
	ctrlMapAnimCommit _cntrlScreen;
	true
};

cTab_Tablet_btnACT = {
	params [["_info",nil]];

	//-Control Turret
	if !(isnil {_info}) exitWith {
		_vehicle = cTab_player getVariable ["TGP_View_Selected_Vehicle",objNull];
		_current_turret = ((cTab_player getVariable "TGP_View_Selected_Optic") # 0) # 1;

		_condition = [
			({!((_x getVariable ["TGP_View_Turret_Control", []]) isEqualTo [])} count (crew _vehicle)) > 0,
			(isUAVConnected _vehicle)
		] select (unitIsUAV _vehicle);

		if (!(_vehicle isEqualTo objNull) && !(_condition) && ((_current_turret # 0) >= 0)) then {
			//-delete PIP Cam && close TAD UI
			call cTab_fnc_deleteUAVcam;
			call cTab_fnc_close;

			[{
				params ["_vehicle"];
				[_vehicle,cameraview] call BCE_fnc_onButtonClick_Gunner;
				_vehicle call BCE_fnc_TGP_Select_Confirm;
			}, [_vehicle], 0.1] call CBA_fnc_WaitAndExecute;
		} else {
			["UAV","Unable to Control the Turret",5] call cTab_fnc_addNotification;
		};
	};

	////////////////////////////////////////////////////////////////////////////
	_mode = ["cTab_Tablet_dlg","mode"] call cTab_fnc_getSettings;

	switch _mode do {
		//-View Camera
	  case "UAV": {
			private ["_vehicle","_current_turret"];

			_vehicle = cTab_player getVariable ["TGP_View_Selected_Vehicle",objNull];

			if !(_vehicle isEqualTo objNull) then {
				//-delete PIP Cam && close TAD UI
				call cTab_fnc_deleteUAVcam;
				call cTab_fnc_close;
				[{
					params ["_vehicle"];
					_vehicle call BCE_fnc_TGP_Select_Confirm;
				}, [_vehicle], 0.1] call CBA_fnc_WaitAndExecute;
			} else {
				["UAV","None Vehicle Selected",5] call cTab_fnc_addNotification;
			};
	  };
		case "HCAM": {
		  ["cTab_Tablet_dlg",[["mode","HCAM_FULL"]]] call cTab_fnc_setSettings;
		};
		case "HCAM_FULL": {
		  ["cTab_Tablet_dlg",[["mode","HCAM"]]] call cTab_fnc_setSettings;
		};
	};

	true
};
