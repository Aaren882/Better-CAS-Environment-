/*
	 Name: cTab_fnc_updateInterface

	 Author(s):
	Gundy

	Edit:
	Aaren

	 Description:
	Update current interface (display or dialog) to match current settings.
	If no parameters are specified, all interface elements are updated

	Parameters:
	(Optional)
	0: ARRAY - Property pairs in the form of [["propertyName",propertyValue],[...]]

	 Returns:
	BOOLEAN - Always true

	 Example:
	[[["mapType","SAT"],["mapScaleDsp","4"]]] call cTab_fnc_updateInterface;
*/

#include "\cTab\shared\cTab_gui_macros.hpp"

//-POLPOX Map Tools
#if __has_include("\plp\plp_mapToolsRemastered\config.bin")
	#define PLP_TOOL 1
#endif

private ["_interfaceInit","_maptoolsInit","_TAC_Vis","_settings","_display","_displayName","_null","_osdCtrl","_text","_mode","_mapTypes","_mapType","_mapIDC","_targetMapName","_targetMapIDC","_targetMapCtrl","_previousMapCtrl","_previousMapIDC","_renderTarget","_loadingCtrl","_targetMapScale","_mapScaleKm","_mapScaleMin","_mapScaleMax","_mapScaleTxt","_mapWorldPos","_targetMapWorldPos","_displayItems","_btnActCtrl","_displayItemsToShow","_mapTools","_data","_uavListCtrl","_hcamListCtrl","_index","_isDialog","_background","_brightness","_nightMode","_backgroundPosition","_backgroundPositionX","_backgroundPositionW","_backgroundConfigPositionX","_xOffset","_dspIfPosition","_backgroundOffset","_ctrlPos","_mousePos"];
disableSerialization;

if (isNil "cTabIfOpen") exitWith {false};
_displayName = cTabIfOpen # 1;

_display = uiNamespace getVariable _displayName;
uiNameSpace setVariable ["cTab_BFT_CurSel",objNull];

_interfaceInit = false;
_maptoolsInit = false;
_TAC_Vis = false;
_loadingCtrl = _display displayCtrl IDC_CTAB_LOADINGTXT;
_targetMapCtrl = controlNull;
_targetMapScale = nil;
_targetMapWorldPos = nil;
_isDialog = [_displayName] call cTab_fnc_isDialog;

if (count _this == 1) then {
	_settings = _this # 0;
} else {
	// Retrieve all settings for the currently open interface
	_settings = [_displayName] call cTab_fnc_getSettings;
	_interfaceInit = true;
};

_mode = [_settings,"mode"] call cTab_fnc_getFromPairs;
if (isNil "_mode") then {
	_mode = [_displayName,"mode"] call cTab_fnc_getSettings;
	_loadingCtrl = displayNull;
} else {
	// show "Loading" control to hide all the action while its going on
	if (!isNull _loadingCtrl) then {
		_loadingCtrl ctrlShow true;
		while {!ctrlShown _loadingCtrl} do {};
	};
};

_settings apply {
	call {
	// ------------ DISPLAY POSITION ------------
	if (_x # 0 == "dspIfPosition") exitWith {
		_dspIfPosition = _x # 1;

		if !(_isDialog) then {
			// get the current position of the background control
			_backgroundPosition = [_displayName] call cTab_fnc_getBackgroundPosition;
			_backgroundPositionX = _backgroundPosition # 0 # 0;
			_backgroundPositionW = _backgroundPosition # 0 # 2;

			// get the original position of the background control
			_backgroundConfigPositionX = _backgroundPosition # 1 # 0;

			// figure out if we need to do anything
			if !((_backgroundPositionX != _backgroundConfigPositionX) isEqualTo _dspIfPosition) then {
				// calculate offset required to shift position to the opposite
				_xOffset = if (_backgroundPositionX == _backgroundConfigPositionX) then {
					2 * safeZoneX + safeZoneW - _backgroundPositionW - 2 * _backgroundPositionX
				} else {
					_backgroundConfigPositionX - _backgroundPositionX
				};
				[_displayName,[_xOffset,0]] call cTab_fnc_setInterfacePosition;
			};
		};
	};
	// ------------ DIALOG POSITION ------------
	if (_x # 0 == "dlgIfPosition") exitWith {
		_backgroundOffset = _x # 1;

		if (_isDialog) then {
			if (_backgroundOffset isEqualTo []) then {
				_backgroundOffset = if (_interfaceInit) then {
					[0,0]
				} else {
					// reset to defaults
					_backgroundPosition = [_displayName] call cTab_fnc_getBackgroundPosition;
					[(_backgroundPosition # 1 # 0) - (_backgroundPosition # 0 # 0),(_backgroundPosition # 1 # 1) - (_backgroundPosition # 0 # 1)]
				};
			};
			if !(_backgroundOffset isEqualTo [0,0]) then {
				// move by offset
				[_displayName,_backgroundOffset] call cTab_fnc_setInterfacePosition;
			};
		};
	};
	// ------------ BRIGHTNESS ------------
	// Value ranges from 0 to 1, 0 being off and 1 being full brightness
	if (_x # 0 == "brightness") exitWith {
		_osdCtrl = _display displayCtrl IDC_CTAB_BRIGHTNESS;
		if (!isNull _osdCtrl) then {
			_brightness = _x # 1;
			_nightMode = [_displayName,"nightMode"] call cTab_fnc_getSettings;
			// if we are running night mode, lower the brightness proportionally
			if (!isNil "_nightMode") then {
				if (_nightMode == 1 || {_nightMode == 2 && (sunOrMoon < 0.2)}) then {_brightness = _brightness * 0.7};
			};
			_osdCtrl ctrlSetBackgroundColor [0,0,0,1 - _brightness];
		};
	};

	#define TAD_BG ["\cTab\img\TAD_background_ca.paa","\cTab\img\TAD_background_night_ca.paa"]
	#define DAGR_BG ["\cTab\img\microDAGR_background_ca.paa","\cTab\img\microDAGR_background_night_ca.paa"]
	#define TAB_BG ["\cTab\img\tablet_background_ca.paa","\cTab\img\tablet_background_night_ca.paa"]

	//-Check if it's "1erGTD"
	#if __has_include("\z\ctab\addons\core\config.bin")
		#define PHONE_BG ["\cTab\img\android_s7_ca.paa","\cTab\img\android_s7_night_ca.paa"]
	#else
		#define PHONE_BG ["\cTab\img\android_background_ca.paa","\cTab\img\android_background_night_ca.paa"]
	#endif

	// ------------ NIGHT MODE ------------
	// 0 = day mode, 1 = night mode, 2 = automatic
	if (_x # 0 == "nightMode") exitWith {
		_nightMode = _x # 1;
		// transform nightMode into boolean
		_nightMode = (_nightMode == 1) || (_nightMode == 2 && (sunOrMoon < 0.2));
		_background = call {
			if (_displayName in ["cTab_TAD_dsp","cTab_TAD_dlg"]) exitWith {
				TAD_BG select _nightMode
			};
			if (_displayName in ["cTab_Android_dlg","cTab_Android_dsp"]) exitWith {
				PHONE_BG select _nightMode
			};
			if (_displayName in ["cTab_microDAGR_dsp","cTab_microDAGR_dlg"]) exitWith {
				DAGR_BG select _nightMode
			};
			if (_displayName in ["cTab_Tablet_dlg"]) exitWith {
				TAB_BG select _nightMode
			};
			""
		};
		if (_background != "") then {
			(_display displayCtrl IDC_CTAB_BACKGROUND) ctrlSetText _background;
			// call brightness adjustment if this is outside of interface init
			if (!_interfaceInit) then {
				_settings pushBack ["brightness",[_displayName,"brightness"] call cTab_fnc_getSettings];
			};
		};
	};

	//- Weather Condition
	if ((_x # 0) == "Weather_Condition") exitWith {
		private ["_ctrl","_loop"];
		_ctrl = _display displayCtrl 26160;

		(_x # 1) params ["_show","_loopName",["_Size","[1,1]"]];
		(call compile _Size) params ["_DspSize","_dlgSize"];

		_loop = _displayName != _loopName;
		[_displayName, _loop] call BCE_fnc_cTab_getWeather_Infos;
		
		if (_loop) then {
			[_displayName,[["Weather_Condition",[_show,_displayName,_Size]]],false] call cTab_fnc_setSettings;
		};
		
		_ctrl ctrlSetPositionX ((ctrlPosition (_display displayCtrl 2616)) # 0);
		_ctrl ctrlSetPositionH ([
			0,
			3.5 * _dlgSize * (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) / ([
				_DspSize,
				1
			] select _isDialog))
		] select _show);

		_ctrl ctrlCommit ([0.2, 0] select _interfaceInit);
	};

	// ------------ MODE ------------
	if (_x # 0 == "mode") exitWith {
		cTabUserPos = [];

		_displayItems = call {
			if (_displayName == "cTab_Tablet_dlg") exitWith {
				[3300,3301,3302,3303,3304,3305,3306,3307,3308,3309,3310,3311,

				17000 + 3300,
				17000 + 33000,
				17000 + 3301,
				IDC_CTAB_GROUP_DESKTOP,
				IDC_CTAB_GROUP_UAV,
				IDC_CTAB_GROUP_HCAM,
				IDC_CTAB_GROUP_MESSAGE,
				4651,
				4652,
				4653,
				17000 + 4651,
				17000 + 4652,
				17000 + 4653,
				IDC_CTAB_CTABHCAMMAP,
				IDC_CTAB_CTABUAVMAP,
				17000 + 1200,
				17000 + 1201,
				17000 + 12010,
				17000 + 12011,

				//-POLPOX Map Tools
				#ifdef PLP_TOOL
				73454,
				17000 + 1202,
				17000 + 12012,
				#endif
				IDC_CTAB_SCREEN,
				IDC_CTAB_SCREEN_TOPO,
				IDC_CTAB_HCAM_FULL,
				IDC_CTAB_OSD_HOOK_GRID,
				IDC_CTAB_OSD_HOOK_ELEVATION,
				IDC_CTAB_OSD_HOOK_DST,
				IDC_CTAB_OSD_HOOK_DIR,
				IDC_CTAB_NOTIFICATION]
			};
			if (_displayName in ["cTab_Android_dlg","cTab_Android_dsp"]) exitWith {
				[3300,3301,3302,3303,3304,3305,3306,3307,3308,3309,3310,3311,
				4630,
				17000 + 3300,
				17000 + 33000,
				1775,
				1776,
				17000 + 46320,

				//-ATAK
				3510,
				17000 + 4660,
				17000 + 4661,
				17000 + 4662,
				17000 + 4663,
				46600,

				//-BG
				17000 + 4630,
				17000 + 4631,
				17000 + 4632,
				17000 + 4650,

				//-BTF Widgets
				17000 + 1200,
				//-POLPOX Map Tools
				#ifdef PLP_TOOL
				73454,
				17000 + 1202,
				17000 + 12012,
				#endif
				IDC_CTAB_GROUP_DESKTOP,
				IDC_CTAB_GROUP_MENU,
				IDC_CTAB_GROUP_MESSAGE,
				IDC_CTAB_GROUP_COMPOSE,
				IDC_CTAB_SCREEN,
				IDC_CTAB_SCREEN_TOPO,
				IDC_CTAB_OSD_HOOK_GRID,
				IDC_CTAB_OSD_HOOK_ELEVATION,
				IDC_CTAB_OSD_HOOK_DST,
				IDC_CTAB_OSD_HOOK_DIR,
				IDC_CTAB_NOTIFICATION]
			};
			if (_displayName in ["cTab_FBCB2_dlg","cTab_TAD_dlg"]) exitWith {
				[3300,3301,3302,3303,3304,3305,3306,3307,3308,3309,3310,3311,
				IDC_CTAB_NOTIFICATION]
			};
			[IDC_CTAB_NOTIFICATION] // default
		};

		//-Setup show Controls on INIT
		if !(_displayItems isEqualTo []) then {
		_btnActCtrl = _display displayCtrl IDC_CTAB_BTNACT;
		_displayItemsToShow = [];

		call {
			// ---------- DESKTOP -----------
			if (_mode == "DESKTOP") exitWith {
				_displayItemsToShow pushback IDC_CTAB_GROUP_DESKTOP;
				_btnActCtrl ctrlSetText "";
				_btnActCtrl ctrlSetTooltip "";
			};
			// ---------- BFT -----------
			if (_mode == "BFT") exitWith {
				_mapTypes = [_displayName,"mapTypes"] call cTab_fnc_getSettings;
				_mapType = [_displayName,"mapType"] call cTab_fnc_getSettings;
				_mapIDC = [_mapTypes,_mapType] call cTab_fnc_getFromPairs;
				_TAC_Vis = true;

				_displayItemsToShow = [
					_mapIDC,
					3510,
					17000 + 1200,
					17000 + 1201,
					17000 + 1202,
					IDC_CTAB_OSD_HOOK_GRID,
					IDC_CTAB_OSD_HOOK_ELEVATION,
					IDC_CTAB_OSD_HOOK_DST,
					IDC_CTAB_OSD_HOOK_DIR
				];

				//-Tool Menu
				if (_displayName in ["cTab_Android_dlg","cTab_Android_dsp"]) then {
					private _showMenu = [_displayName, "showMenu"] call cTab_fnc_getSettings;
					if (_showMenu # 1) then {
						_displayItemsToShow pushback IDC_CTAB_GROUP_MENU;
						if !(_interfaceInit) then {
							_settings pushBack ["showMenu",[_displayName,"showMenu"] call cTab_fnc_getSettings];
						};
					};
				};

				_btnActCtrl ctrlSetTooltip "";
				_maptoolsInit = true;

				private _widgets = [
					[
						#ifdef PLP_TOOL
							"PLP_mapTools",
						#endif
						"BCE_mapTools"
					],
					[]
				] select (_displayName in ["cTab_Android_dlg","cTab_Android_dsp"]);

				(["mapTools"] + _widgets) apply {
					_settings pushBack [_x,[_displayName,_x] call cTab_fnc_getSettings];
				};
				// update scale and world position when not on interface init
				if (!_interfaceInit) then {
					if (_isDialog) then {
						["mapScaleDlg","mapWorldPos"] apply {
							_settings pushBack [_x,[_displayName,_x] call cTab_fnc_getSettings];
						};
					};
				};
			};
			// ---------- _NOT_ BFT -----------
			if (_isDialog) then {
				_mapTypes = [_displayName,"mapTypes"] call cTab_fnc_getSettings;
				if (count _mapTypes > 1) then {
					_targetMapName = [_displayName,"mapType"] call cTab_fnc_getSettings;
					_targetMapIDC = [_mapTypes,_targetMapName] call cTab_fnc_getFromPairs;
					_targetMapCtrl = _display displayCtrl _targetMapIDC;

					// If we find the map to be shown, we are switching away from BFT. Lets save map scale and position
					if (ctrlShown _targetMapCtrl) then {
						_mapScale = cTabMapScale * cTabMapScaleFactor / 0.86 * (safezoneH * 0.8);
						[_displayName,[["mapWorldPos",cTabMapWorldPos],["mapScaleDlg",_mapScale]],false] call cTab_fnc_setSettings;
					};
				};
			};
			// ---------- UAV -----------
			if (_mode in "UAV") exitWith {
			_displayItemsToShow = [
				IDC_CTAB_GROUP_UAV,
				IDC_CTAB_CTABUAVMAP
			];

			if (_displayName in ["cTab_Android_dlg","cTab_Android_dsp"]) then {
				private ["_showMenu","_Showlist"];
				_showMenu = [_displayName,"uavInfo"] call cTab_fnc_getSettings;
				_Showlist = [17000 + 4630,17000 + 4631,17000 + 4632,17000 + 46320] + [([1776,1775] select (_showMenu))];
				_displayItemsToShow append _Showlist;
			} else {
				_btnActCtrl ctrlSetTooltip "View Gunner Optics";
			};

			_settings pushBack ["uavListUpdate",true];
			if (!_interfaceInit) then {
				_settings pushBack ["uavCam",str (cTab_player getVariable ["TGP_View_Selected_Vehicle",objNull])];
			};
			};
			// ---------- HELMET CAM -----------
			if (_mode == "HCAM") exitWith {
				_displayItemsToShow = [
					IDC_CTAB_GROUP_HCAM,
					IDC_CTAB_CTABHCAMMAP
				];
				_btnActCtrl ctrlSetTooltip "Toggle Fullscreen";
				_settings pushBack ["hCamListUpdate",true];
				if (!_interfaceInit) then {
					_settings pushBack ["hCam",[_displayName,"hCam"] call cTab_fnc_getSettings];
				};
			};
			// ---------- MESSAGING -----------
			if (_mode == "MESSAGE") exitWith {
				_displayItemsToShow = [IDC_CTAB_GROUP_MESSAGE];
				call cTab_msg_gui_load;
				cTabRscLayerMailNotification cutText ["", "PLAIN"];
				_btnActCtrl ctrlSetTooltip "";
			};
			// ---------- MESSAGING COMPOSE -----------
			if (_mode == "COMPOSE") exitWith {
				_displayItemsToShow pushBack IDC_CTAB_GROUP_COMPOSE;
				call cTab_msg_gui_load;
			};

			// ---------- Task Builder -----------
			if (_mode == "TASK_Builder") exitWith {
				_displayItemsToShow = [
					4651,
					4652,
					4653,
					17000 + 4651,
					17000 + 4652,
					17000 + 4653
				];
				_btnActCtrl ctrlSetTooltip "";
			};

			// ---------- FULLSCREEN HELMET CAM -----------
			if (_mode == "HCAM_FULL") exitWith {
				_displayItemsToShow = [IDC_CTAB_HCAM_FULL];
				_data = [_displayName,"hCam"] call cTab_fnc_getSettings;
				_btnActCtrl ctrlSetTooltip "Toggle Fullscreen";
				['rendertarget13',_data] spawn cTab_fnc_createHelmetCam;
			};
		};

		// hide every _displayItems not in _displayItemsToShow
		{(_display displayCtrl _x) ctrlShow (_x in _displayItemsToShow)} count _displayItems;


/////////////////////////////////////////////////////////////////////////////////
			// ---------- Task Builder -----------
			if (_mode == "TASK_Builder") then {
				[_display,17000] call BCE_fnc_Reset_TaskList;

				//-Show and Hide Switcable Lists
				[_display displayCtrl (17000 + 3101),(uiNameSpace getVariable ["ctab_Extended_List_Sel",[0,[]]]) # 0,0] call BCE_fnc_ctab_Switch_ExtendedList;

				_settings pushBack ["uavListUpdate",true];

				if (!_interfaceInit) then {
					_settings pushBack ["uavCam",str (cTab_player getVariable ["TGP_View_Selected_Vehicle",objNull])];
				};
			};
			// ----------------------------------
		};

		//-Check Visibility of BFT
			cTab_player setVariable ["BCE_TACMap_Visiable",_TAC_Vis,true];
		};

		//----------------------------------------------------------------------------------------------//

		// ------------ SHOW ICON TEXT ------------
		if (_x # 0 == "showIconText") exitWith {
			_osdCtrl = _display displayCtrl IDC_CTAB_OSD_TXT_TGGL;
			if (!isNull _osdCtrl) then {
				_text = ["OFF","ON"] select (_x # 1);
				_osdCtrl ctrlSetText _text;
			};
		};
		// ------------ MAP SCALE DSP------------
		if (_x # 0 == "mapScaleDsp") exitWith {
			if (_mode == "BFT" && !_isDialog) then {
				_mapScaleKm = _x # 1;
				// pre-Calculate map scales
				_mapScaleMin = [_displayName,"mapScaleMin"] call cTab_fnc_getSettings;
				_mapScaleMax = [_displayName,"mapScaleMax"] call cTab_fnc_getSettings;
				_mapScaleKm = call {
					if (_mapScaleKm >= _mapScaleMax) exitWith {_mapScaleMax};
					if (_mapScaleKm <= _mapScaleMin) exitWith {_mapScaleMin};
					// pick the next best scale that is an even multiple of the minimum map scale... It does tip in favour of the larger scale due to the use of logarithm, so its not perfect
					_mapScaleMin * 2 ^ round (log (_mapScaleKm / _mapScaleMin) / log (2))
				};
				if (_mapScaleKm != (_x # 1)) then {
					[_displayName,[["mapScaleDsp",_mapScaleKm]],false] call cTab_fnc_setSettings;
				};
				cTabMapScale = _mapScaleKm / cTabMapScaleFactor;

				_osdCtrl = _display displayCtrl IDC_CTAB_OSD_MAP_SCALE;
				if (!isNull _osdCtrl) then {
					// divide by 2 because we want to display the radius, not the diameter
					_mapScaleTxt = if (_mapScaleKm > 1) then {
						_mapScaleKm / 2
					} else {
						[_mapScaleKm / 2,0,1] call CBA_fnc_formatNumber
					};
					_osdCtrl ctrlSetText format ["%1",_mapScaleTxt];
				};
			};
		};
		// ------------ MAP SCALE DLG------------
		if (_x # 0 == "mapScaleDlg") exitWith {
			if (_mode == "BFT" && _isDialog) then {
				_mapScaleKm = _x # 1;
				_targetMapScale = _mapScaleKm / cTabMapScaleFactor * 0.86 / (safezoneH * 0.8);
			};
		};
		// ------------ MAP WORLD POSITION ------------
		if (_x # 0 == "mapWorldPos") exitWith {
			if (_mode == "BFT") then {
				if (_isDialog) then {
					_mapWorldPos = _x # 1;
					if !(_mapWorldPos isEqualTo []) then {
						_targetMapWorldPos = _mapWorldPos;
					};
				};
			};
		};
		// ------------ MAP TYPE ------------
		if (_x # 0 == "mapType") exitWith {
			_mapTypes = [_displayName,"mapTypes"] call cTab_fnc_getSettings;
			if ((count _mapTypes > 1) && (_mode == "BFT")) then {
				_targetMapName = _x # 1;
				_targetMapIDC = [_mapTypes,_targetMapName] call cTab_fnc_getFromPairs;
				_targetMapCtrl = _display displayCtrl _targetMapIDC;

				if (!_interfaceInit && _isDialog) then {
					_previousMapCtrl = controlNull;
					{
						_previousMapIDC = _x # 1;
						_previousMapCtrl = _display displayCtrl _previousMapIDC;
						if (ctrlShown _previousMapCtrl) exitWith {};
						_previousMapCtrl = controlNull;
					} count _mapTypes;

					// See if _targetMapCtrl is already being shown
					if ((!ctrlShown _targetMapCtrl) && (_targetMapCtrl != _previousMapCtrl)) then {
						// Update _targetMapCtrl to scale and position of _previousMapCtrl
						if (isNil "_targetMapScale") then {_targetMapScale = ctrlMapScale _previousMapCtrl;};
						if (isNil "_targetMapWorldPos") then {_targetMapWorldPos = [_previousMapCtrl] call cTab_fnc_ctrlMapCenter};
					};
				};

				// Hide all unwanted map types
				_mapTypes apply {
					if (_x # 0 != _targetMapName) then {
						(_display displayCtrl (_x # 1)) ctrlShow false;
					};
				};

				// Update OSD element if it exists
				_osdCtrl = _display displayCtrl IDC_CTAB_OSD_MAP_TGGL;
				if (!isNull _osdCtrl) then {_osdCtrl ctrlSetText _targetMapName;};

				// show correct map contorl
				if (!ctrlShown _targetMapCtrl) then {
					_targetMapCtrl ctrlShow true;
					// wait until map control is shown, otherwise we can get in trouble with ctrlMapAnimCommit later on, depending on timing
					while {!ctrlShown _targetMapCtrl} do {};
				};
			};
		};

		// ------------ UAV List Update ------------
		if (_x # 0 == "uavListUpdate") exitWith {
			if (_mode in ["UAV","TASK_Builder"]) then {
				_data = cTab_player getVariable ["TGP_View_Selected_Vehicle",objNull];
				[IDC_CTAB_CTABUAVLIST, 17000+IDC_CTAB_CTABUAVLIST] apply {
					private ["_uavListCtrl","_default"];
					_uavListCtrl = _display displayCtrl _x;
					if (isnull _uavListCtrl) then {continue};

					lbClear _uavListCtrl;
					_default = _uavListCtrl lbAdd "--";
					_uavListCtrl lbSetData [_default,str objNull];

					// Populate list of UAVs
					cTabUAVlist apply {
						if (count (crew _x) > 0) then {
							private _index = _uavListCtrl lbAdd format ["[%1] %2", name (driver _x), getText (configOf _x >> "displayname")];
							_uavListCtrl lbSetData [_index,str _x];
						};
					};

					if !(isnull _data) then {
						// Find last selected UAV and # if found
						for "_i" from 0 to (lbSize _uavListCtrl - 1) do {
							if (str _data == (_uavListCtrl lbData _i)) exitWith {
								_uavListCtrl lbSetCurSel _i;
							};
						};
						// If no UAV could be selected, clear last selected UAV
						if (lbCurSel _uavListCtrl == -1) then {
							[_displayName,[["uavCam",""]]] call cTab_fnc_setSettings;
							cTab_player setVariable ["TGP_View_Selected_Vehicle",objNull];
							_uavListCtrl lbSetCurSel 0;
						};
					} else {
						_uavListCtrl lbSetCurSel 0;
					};
				};
			};
		};
		// ------------ HCAM List Update ------------
		if (_x # 0 == "hCamListUpdate") exitWith {
			if (_mode == "HCAM") then {
				_data = [_displayName,"hCam"] call cTab_fnc_getSettings;
				_hcamListCtrl = _display displayCtrl IDC_CTAB_CTABHCAMLIST;
				// Populate list of HCAMs
				lbClear _hcamListCtrl;
				_hcamListCtrl lbSetCurSel -1;
				cTabHcamlist apply {
					_index = _hcamListCtrl lbAdd format ["%1:%2 (%3)",groupId group _x,[_x] call CBA_fnc_getGroupIndex,name _x];
					_hcamListCtrl lbSetData [_index,str _x];
				};
				lbSort [_hcamListCtrl, "ASC"];
				if (_data != "") then {
					// Find last selected hCam and # if found
					for "_x" from 0 to (lbSize _hcamListCtrl - 1) do {
						if (_data == _hcamListCtrl lbData _x) exitWith {
							if (lbCurSel _hcamListCtrl != _x) then {
								_hcamListCtrl lbSetCurSel _x;
							};
						};
					};

					// If no hCam could be selected, clear last selected hCam
					if (lbCurSel _hcamListCtrl == -1) then {
						[_displayName,[["hCam",""]]] call cTab_fnc_setSettings;
					};
				};
			};
		};

		// ---------- Marker Color -----------
		if ((_x # 0) == "markerColor") exitWith {
			private _markerColor = _display displayCtrl (17000 + 1090);
			if (lbSize _markerColor == 0) then {
				private _cfg = "getnumber (_x >> 'scope') == 2" configClasses (configFile >> "CfgMarkerColors");
				{
					private ["_name","_color","_index"];
					_name = getText (_x >> "name");
					_color = (getArray (_x >> "color")) apply {
					if (_x isEqualType "") then {call compile _x} else {_x};
					};
					_index = _markerColor lbAdd _name;
					_markerColor lbSetPicture [_index, "a3\ui_f\data\map\markers\nato\n_unknown.paa"];

					_markerColor lbSetPictureColorSelected [_index, _color];
					_markerColor lbSetPictureColor [_index, _color];
					_markerColor lbSetData [_index, str [configName _x, _color]];
				} count _cfg;
			};
			_markerColor lbSetCurSel (_x # 1);
		};

		// ------------ UAV CAM ------------
		// ------------ init AV info ------------
		if ((_x # 0) == "uavCam") exitWith {
			if (_mode in ["UAV","TASK_Builder"]) then {
				private ["_UAV_Interface","_data","_veh","_veh_changed","_list"];

				_UAV_Interface = _mode == "UAV";

				//-Find Vehicle
				_data = _x # 1;
				_veh = objNull;
				{
					if (_data == str _x) exitWith {_veh = _x};
				} count cTabUAVlist;

				_veh_changed = _veh isNotEqualTo (cTab_player getVariable ["TGP_View_Selected_Vehicle",objNull]);

				cTab_player setVariable ["TGP_View_Selected_Vehicle",_veh];
				_condition = [((uiNameSpace getVariable ["ctab_Extended_List_Sel",[0,[]]]) # 0) == 0,true] select _UAV_Interface;

				//-Create PIP camera if mode is "UAV"
				if !(isNull _veh) then {
					[_veh,[[1,["rendertarget8","rendertarget9"] select _UAV_Interface]],_UAV_Interface] call cTab_fnc_createUavCam;
				} else {
					//-Clean Up if the vehicle is null
					call cTab_fnc_deleteUAVcam;
					player setVariable ["TGP_View_Selected_Optic",[[],objNull],true];
					[1787,2020,2021] apply {lbClear (_display displayCtrl (17000 + _x))};
					(_display displayCtrl (17000 + 1788)) ctrlSetStructuredText parseText "";

					if (_displayName in ["cTab_Android_dlg","cTab_Android_dsp"]) then {
						(_display displayCtrl (17000 + 46320)) ctrlSetText "--";
					};
				};

				//-Task Builder
				if !(_UAV_Interface) then {
					if (_veh_changed) then {
						[_display,17000,0] call BCE_fnc_Reset_TaskList;
					};
					[_display,_display displayCtrl (17000 + 1787),_veh,true] call BCE_fnc_checkList;
				};

				//-update vehicle info
				_list = _display displayCtrl (([17000,0] select _UAV_Interface) + 1775);
				[_list,_veh] call BCE_fnc_ctab_List_AV_Info;
			};
		};

		// ------------ HCAM ------------
		if (_x # 0 == "hCam") exitWith {
			_renderTarget = ["rendertarget12","rendertarget13"] select (_mode == "HCAM_FULL");

			if (!isNil "_renderTarget") then {
				_data = _x # 1;
				if (_data != "") then {
					[_renderTarget,_data] call cTab_fnc_createHelmetCam;
				} else {
					call cTab_fnc_deleteHelmetCam;
				}
			};
		};
		// ------------ MAP TOOLS ------------
		if ((_x # 0) in ["mapTools","BCE_mapTools","PLP_mapTools"]) exitWith {

			if ((_x # 0) == "mapTools") then {
				cTabDrawMapTools = _x # 1;
			};

			if (_mode == "BFT") then {
				if !(_displayName in ["cTab_TAD_dlg","cTab_TAD_dsp"]) then {
					private ["_Tool_toggle","_BCE_toggle","_PLP_toggle","_ToolCtrl","_toggleW","_period","_MoveDir","_cal_H","_Tool_statment","_toggled_ctrl","_sort"];

					_Tool_toggle = _display displayCtrl (17000 + 1200);
					_BCE_toggle = _display displayCtrl (17000 + 1201);

					#ifdef PLP_TOOL
						_PLP_toggle = _display displayCtrl (17000 + 1202);
					#endif

					_ToolCtrl = _display displayCtrl IDC_CTAB_OSD_HOOK_DIR;

					(ctrlPosition _Tool_toggle) params ["","","_toggleW","_toggleH"];
					(ctrlPosition _ToolCtrl) params ["_CTRLX","_CTRLY","_CTRLW","_CTRLH"];

					_period = [0.2,0] select (_interfaceInit || _maptoolsInit);
					_MoveDir = [1,-1] select ("Android" in _displayName);

					//-Get Y axis and H
					_cal_H = _CTRLH / 2;
					_Tool_statment = [
						[[_CTRLW - _toggleW, 0] select (_MoveDir < 0) , [_CTRLX + (_CTRLW * _MoveDir) ,0]],
						[[(-_toggleW), _CTRLW] select (_MoveDir < 0), [_CTRLX ,_CTRLW]]
					];

					_toggled_ctrl = switch (_x # 0) do {
						case "mapTools": {
							[
								IDC_CTAB_OSD_HOOK_GRID,
								IDC_CTAB_OSD_HOOK_DIR,
								IDC_CTAB_OSD_HOOK_DST,
								IDC_CTAB_OSD_HOOK_ELEVATION
							] apply {
								private _ctrl = _display displayCtrl _x;
								if (!isNull _ctrl) then {
									_ctrl ctrlShow cTabDrawMapTools;
								};
							};

							_Tool_toggle
						};

						#ifdef PLP_TOOL
							case "PLP_mapTools": {
								private _status = _x # 1;
								private _ctrl = _display displayCtrl (17000 + 12012);
								(_display displayCtrl 73454) ctrlshow _status;

								if (_status) then {
									[_ctrl,lbCurSel _ctrl] call BCE_fnc_ctab_BFT_ToolBox;
								} else {
									private _PLP_EH = uiNamespace getVariable ["PLP_SMT_EH",-1];
									private _PLP_Tool = _display displayCtrl 73453;

									if !(isNull _PLP_Tool) then {
										ctrlDelete _PLP_Tool;
									};

									if (_PLP_EH > 0) then {
										private ["_mapTypes","_currentMapType","_currentMapTypeIndex","_mapIDC"];
										_mapTypes = [_displayName,"mapTypes"] call cTab_fnc_getSettings;
										_currentMapType = [_displayName,"mapType"] call cTab_fnc_getSettings;
										_currentMapTypeIndex = [_mapTypes,_currentMapType] call BIS_fnc_findInPairs;
										_mapIDC = _mapTypes # _currentMapTypeIndex # 1;
										(_display displayCtrl _mapIDC) ctrlRemoveEventHandler ["Draw",_PLP_EH];
									};
								};

								_PLP_toggle
							};
						#endif

						case "BCE_mapTools": {
							private _status = _x # 1;
							private _list = _display displayCtrl (17000 + 12010);
							[_list, lbCurSel _list, _status] call BCE_fnc_ctab_BFT_ToolBox;

							_BCE_toggle
						};
					};

					_sort = [];
					{
						if (isnull (_x # 0)) then {continue};
						_x params ["_toggle","_idc","_size","_id"];

						private _status = [_displayName,_id] call cTab_fnc_getSettings;
						private _POS = _Tool_statment select _status;

						private _ctrls = [_toggle] + (_idc apply {
							_x params ["_IDC",["_showOnInit",true]];
							private _c = _display displayctrl (17000 + _IDC);
							if (_showOnInit) then {
							_c ctrlshow _status;
							};

							//-Preset of List Content
							if (_MoveDir < 0) then {
								_c ctrlSetPositionX _CTRLX;
								_c ctrlCommit 0;
							};

							(_POS # 1) params ["_Cx","_Cw"];
							_c ctrlSetPositionX _Cx;
							_c ctrlSetPositionW _Cw;
							_c
						});

						_toggle ctrlSetPositionX (_CTRLX + (_POS # 0));

						//-Output
						_sort pushBack [_ctrls, _size * _CTRLH, _status];
					} forEach [
						[_Tool_toggle,[], 4, "mapTools"],
						#ifdef PLP_TOOL
							[_PLP_toggle,[12012], 7, "PLP_mapTools"],
						#endif
						[_BCE_toggle,[[12011,false], 12010], 4, "BCE_mapTools"]
					];

					//- Set Y axis of current selected ctrl
					private _i = _CTRLY + _CTRLH;

					//-Set Y axis
					{
						_x params ["_ctrls","_H",["_Open",false]];

						private _j = 0;
						{
							private ["_Start","_Cy"];

							_Start = _forEachIndex == 0;
							_Cy = [_i - _H + _j, _i - _toggleH] select _Start;

							_x ctrlSetPositionY _Cy;
							_x ctrlCommit _period;

							if !(_Start) then {
								_j = _j + ((ctrlPosition _x) # 3);
							};
						} forEach _ctrls;

						_i = _i - (_cal_H / 4) - ([_toggleH, _H] select _Open);
					} count _sort;

				};

				//--------------------------------//
				_osdCtrl = _display displayCtrl IDC_CTAB_OSD_HOOK_TGGL1;
				if (!isNull _osdCtrl) then {
					_text = ["CURS","OWN"] select (_x # 1);
					_osdCtrl ctrlSetText _text;
				};
				_osdCtrl = _display displayCtrl IDC_CTAB_OSD_HOOK_TGGL2;
				if (!isNull _osdCtrl) then {
					_text = ["OWN","CURS"] select (_x # 1);
					_osdCtrl ctrlSetText _text;
				};
			};
		};

		// ---------- ATAK Tools -----------
		if (((_x # 0) == "showMenu") && (_mode == "BFT")) exitWith {
			{
				(_display displayCtrl _x) ctrlShow false
			} count [IDC_CTAB_GROUP_MENU, 17000 + 4660, 17000 + 4661, 17000 + 4662, 17000 + 4663];

			(_x # 1) params ["_page","_show"];
		
			private _show_IDC = [_display, _page, (_page != "main") && _show] call BCE_fnc_ATAK_openPage;
			{
				if (isnil{_x}) exitwith {};
				(_display displayCtrl _x) ctrlShow _show;
			} count [IDC_CTAB_GROUP_MENU,_show_IDC];
			
			if (_show) then {
				private ["_group","_ctrl"];
				//-ATAK Control Adjustments
				switch (_page) do {
					case "mission": {
						//-restore Task Type
						_group = _display displayCtrl (17000 + 4661);
						_group ctrlSetScrollValues [uiNamespace getVariable ["BCE_ATAK_Scroll_Value",0], -1];

						_ctrl = _group controlsGroupCtrl (17000 + 2107);
						_ctrl lbSetCurSel (uiNamespace getVariable ["BCE_Current_TaskType",0]);
					};
					case "Task_Result": {
						_group = _display displayCtrl (17000 + 4663);
						_ctrl = _group controlsGroupCtrl 11;
						private _curType = uiNameSpace getVariable ["BCE_Current_TaskType",0];
						private _taskVar = uiNameSpace getVariable (["BCE_CAS_9Line_Var","BCE_CAS_5Line_Var"] # _curType);
						[_ctrl,[9,5] # _curType,_taskVar,player getVariable ["TGP_View_Selected_Vehicle",objNull]] call BCE_fnc_SetTaskReceiver;
					};
				};
			};
		};

		if (_x # 0 == "uavInfo") exitWith {
			private _status = _x # 1;
			[[1775,_status],[1776,!_status]] apply {
				_x params ["_idc","_show"];
				private _osdCtrl = _display displayCtrl _idc;
				if (!isNull _osdCtrl) then {
					_osdCtrl ctrlShow _show;
				};
			};
			if (_status) exitWith {
				[_display displayCtrl 1775, cTab_player getVariable ["TGP_View_Selected_Vehicle",objNull]] call BCE_fnc_ctab_List_AV_Info;
			};
		};
		// ----------------------------------
	};
};

// update scale and world position if we have to. If so, fill in the blanks and make the changes
if ((!isNil "_targetMapScale") || (!isNil "_targetMapWorldPos")) then {
	if (isNull _targetMapCtrl) then {
		_targetMapName = [_displayName,"mapType"] call cTab_fnc_getSettings;
		_mapTypes = [_displayName,"mapTypes"] call cTab_fnc_getSettings;
		_targetMapIDC = [_mapTypes,_targetMapName] call cTab_fnc_getFromPairs;
		_targetMapCtrl = _display displayCtrl _targetMapIDC;
	};
	if (isNil "_targetMapScale") then {
		_targetMapScale = ctrlMapScale _targetMapCtrl;
	};
	if (isNil "_targetMapWorldPos") then {
		_targetMapWorldPos = [_targetMapCtrl] call cTab_fnc_ctrlMapCenter;
	};
	_targetMapCtrl ctrlMapAnimAdd [0,_targetMapScale,_targetMapWorldPos];
	ctrlMapAnimCommit _targetMapCtrl;
	while {!(ctrlMapAnimDone _targetMapCtrl)} do {};
};

// now hide the "Loading" control since we are done
if (!isNull _loadingCtrl) then {
	// move mouse cursor to the center of the screen if its a dialog
	if (_interfaceInit && _isDialog) then {
		_ctrlPos = ctrlPosition _loadingCtrl;
		// put the mouse position in the center of the screen
		_mousePos = [(_ctrlPos # 0) + ((_ctrlPos # 2) / 2),(_ctrlPos # 1) + ((_ctrlPos # 3) / 2)];
		// delay moving the mouse cursor by one frame using a PFH, for some reason its not working without
		[{
			[_this # 1] call CBA_fnc_removePerFrameHandler;
			setMousePosition (_this # 0);
		},0,_mousePos] call CBA_fnc_addPerFrameHandler;
	};

	_loadingCtrl ctrlShow false;
	while {ctrlShown _loadingCtrl} do {};
};

// call notification system
if (_interfaceInit) then {[] call cTab_fnc_processNotifications};

true
