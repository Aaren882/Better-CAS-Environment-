#pragma hemtt flag pe23_ignore_has_include
/*
	Name: cTab_fnc_open
	
	Author(s):
		Gundy
	
	Description:
		Handles dialog / display startup and registering of event handlers
		
		This function will define cTabIfOpen, using the following format:
			Parameter 0: Interface type, 0 = Main, 1 = Secondary, 2 = Tertiary
			Parameter 1: Name of uiNameSpace variable for display / dialog (i.e. "cTab_Tablet_dlg")
			Parameter 2: Unit we registered the killed eventhandler for
			Parameter 3: ID of registered eventhandler for killed event
			Parameter 4: Vehicle we registered the GetOut eventhandler for (even if no EH is registered)
			Parameter 5: ID of registered eventhandler for GetOut event (nil if no EH is registered)
			Parameter 6: ID of registered eventhandler for Draw3D event (nil if no EH is registered)
			Parameter 7: ID of registered eventhandler A.C.E medical_onUnconscious event (nil if no EH is registered)
			Parameter 8: ID of registered eventhandler A.C.E playerInventoryChanged event (nil if no EH is registered)
	
	Parameters:
		0: INTEGER - Interface type, 0 = Main, 1 = Secondary
		1: STRING	- Name of uiNameSpace variable for display / dialog (i.e. "cTab_Tablet_dlg")
		2: OBJECT	- Unit to register killed eventhandler for
		3: OBJECT	- Vehicle to register GetOut eventhandler for
	
	Returns:
		BOOLEAN - TRUE
	
	Example:
		// open TAD display as main interface type
		[0,"cTab_TAD_dsp",player,vehicle player] call cTab_fnc_open;
*/

#include "\cTab\shared\cTab_gui_macros.hpp"

if (cTabIfOpenStart || (!isNil "cTabIfOpen")) exitWith {false};
cTabIfOpenStart = true;

params ["_interfaceType","_displayName", "_player", "_vehicle"];

private _isDialog = [_displayName] call cTab_fnc_isDialog;

#define TAD_BG ["\cTab\img\TAD_background_ca.paa","\cTab\img\TAD_background_night_ca.paa"]
#define DAGR_BG ["\cTab\img\microDAGR_background_ca.paa","\cTab\img\microDAGR_background_night_ca.paa"]
#define TAB_BG ["\cTab\img\tablet_background_ca.paa","\cTab\img\tablet_background_night_ca.paa"]
#define FBCB2_BG ["\cTab\img\FBCB2.paa","\cTab\img\FBCB2.paa"]

//-Check if it's "1erGTD"
#if __has_include("\z\ctab\addons\core\config.bin")
	#define PHONE_BG ["\cTab\img\android_s7_ca.paa","\cTab\img\android_s7_night_ca.paa"]
#else
	#define PHONE_BG ["\cTab\img\android_background_ca.paa","\cTab\img\android_background_night_ca.paa"]
#endif

private _textures = call {
		if (_displayName in ["cTab_TAD_dsp","cTab_TAD_dlg"]) exitWith {
			TAD_BG
		};
		if (_displayName in ["cTab_Android_dsp","cTab_Android_dlg"]) exitWith {
			PHONE_BG
		};
		if (_displayName in ["cTab_microDAGR_dsp","cTab_microDAGR_dlg"]) exitWith {
			DAGR_BG
		};
		if (_displayName in ["cTab_Tablet_dlg"]) exitWith {
			TAB_BG
		};
		if (_displayName in ["cTab_FBCB2_dlg"]) exitWith {
			FBCB2_BG
		};
		["",""]
	};

cTabIfOpen = [_interfaceType,_displayName,_player,
	_player addEventHandler ["killed",{[] call cTab_fnc_close}],
	_vehicle,nil,nil,nil,nil,_textures];

if (_vehicle != _player && (_isDialog || _displayName in ["cTab_TAD_dsp"])) then {
	cTabIfOpen set [5,
		_vehicle addEventHandler ["GetOut",{if (_this # 2 == cTab_player) then {[] call cTab_fnc_close}}]
	];
};

// Set up event handler to update display header / footer
private _EH = switch (true) do {
	case ("Android" in _displayName): {
		addMissionEventHandler ["Draw3D",{
			_display = uiNamespace getVariable (cTabIfOpen # 1);
			_veh = vehicle cTab_player;
			_heading = direction _veh;
			_heading_sel = round (_heading / 90);
			
			_octant = [
				"N",
				"E",
				"S",
				"W",
				"N"
			] # _heading_sel;
			
			//- Digi Compass
				_ctrl_heading = _display displayCtrl (17000+2615);
					_ctrl_heading ctrlSetAngle [360 - _heading, 0.5, 0.5];

				_ctrl_heading = _display displayCtrl (17000+2616);
					_ctrl_heading ctrlSetText _octant;
					_ctrl_heading ctrlSetTextColor ([[1,1,1,1],[1,0,0,1]] select (_heading_sel == 0 || _heading_sel == 4));
			
			//- Self Infos
			// update grid position
			(_display displayCtrl (17000 + 2622)) ctrlSetText (mapGridPosition getPosASLVisual _veh);
			
			// update current heading
			(_display displayCtrl (17000 + 2621)) ctrlSetText format ["%1 %2°", [_heading] call cTab_fnc_degreeToOctant,[_heading,3] call CBA_fnc_formatNumber];

			// update time
			(_display displayCtrl IDC_CTAB_OSD_TIME) ctrlSetText call cTab_fnc_currentTime;
		}];
	};
	case ("_TAD_" in _displayName): {
		addMissionEventHandler ["Draw3D",{
			_display = uiNamespace getVariable (cTabIfOpen # 1);
			_veh = vehicle cTab_player;
			_playerPos = getPosASLVisual _veh;
		
			// update time
			(_display displayCtrl IDC_CTAB_OSD_TIME) ctrlSetText call cTab_fnc_currentTime;
			
			// update grid position
			(_display displayCtrl IDC_CTAB_OSD_GRID) ctrlSetText (mapGridPosition _playerPos);
			
			// update current heading
			(_display displayCtrl IDC_CTAB_OSD_DIR_DEGREE) ctrlSetText format ["%1°",[direction _veh,3] call CBA_fnc_formatNumber];
			
			// update current elevation (ASL) on TAD
			(_display displayCtrl IDC_CTAB_OSD_ELEVATION) ctrlSetText format ["%1m",[round (_playerPos # 2),4] call CBA_fnc_formatNumber];
		}]
	};
	case ("microDAGR" in _displayName): {
		addMissionEventHandler ["Draw3D",{
			_display = uiNamespace getVariable (cTabIfOpen # 1);
			_veh = vehicle cTab_player;
			_heading = direction _veh;
			// update time
			(_display displayCtrl IDC_CTAB_OSD_TIME) ctrlSetText call cTab_fnc_currentTime;
			
			// update grid position
			(_display displayCtrl IDC_CTAB_OSD_GRID) ctrlSetText (mapGridPosition getPosASLVisual _veh);
			
			// update current heading
			(_display displayCtrl IDC_CTAB_OSD_DIR_DEGREE) ctrlSetText format ["%1°", [_heading,3] call CBA_fnc_formatNumber];
			(_display displayCtrl IDC_CTAB_OSD_DIR_OCTANT) ctrlSetText ([_heading] call cTab_fnc_degreeToOctant);
		}];
	};
	default {
		addMissionEventHandler ["Draw3D",{
			_display = uiNamespace getVariable (cTabIfOpen # 1);
			_veh = vehicle cTab_player;
			_heading = direction _veh;
			// update time
			(_display displayCtrl IDC_CTAB_OSD_TIME) ctrlSetText call cTab_fnc_currentTime;
			
			// update grid position
			(_display displayCtrl IDC_CTAB_OSD_GRID) ctrlSetText (mapGridPosition getPosASLVisual _veh);
			
			// update current heading
			(_display displayCtrl IDC_CTAB_OSD_DIR_DEGREE) ctrlSetText format ["%1 %2°", [_heading] call cTab_fnc_degreeToOctant,[_heading,3] call CBA_fnc_formatNumber];
		}];
	}
};
cTabIfOpen set [6,_EH]; //- Store the EH ID

// If ace_medical is used, register with medical_onUnconscious event
#if __has_include("\z\ace\addons\medical\config.cpp")
  cTabIfOpen set [7,
    ["medical_onUnconscious",{
      if (_this # 0 == cTab_player && _this # 1) then {
        [] call cTab_fnc_close;
      };
    }] call ace_common_fnc_addEventHandler
  ];
#endif

// If ace_common is used, register with playerInventoryChanged event
#if __has_include("\z\ace\addons\common\config.bin")	
	cTabIfOpen set [8,
		["playerInventoryChanged",{
			_this call cTab_fnc_onPlayerInventoryChanged;
		}] call ace_common_fnc_addEventHandler
	];
#endif

if (_isDialog) then {
	// Check if map and / or a dialog is open and close them
	if (visibleMap) then {openMap false};
	while {dialog} do {
 		closeDialog 0;
	};
	
	// XXX: Switching to display would allow to walk even when device is open
	// (findDisplay 46) createDisplay _displayName;

	createDialog _displayName;
} else {
	cTabRscLayer cutRsc [_displayName,"PLAIN",0, false];
};

true