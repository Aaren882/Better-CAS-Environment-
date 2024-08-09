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
		
		(ctrlPosition (_display displayCtrl 1)) params ["","_ctrlY","","_ctrlH"];
		_ctrl ctrlSetPositionX (ctrlPosition (_display displayCtrl 2616) # 0);
		_ctrl ctrlCommit 0;
		_ctrl ctrlSetPositionY (_ctrlY + _ctrlH);
		_ctrl ctrlSetPositionH ([
			0,
			3.5 * _dlgSize * (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) / ([
				_DspSize,
				1
			] select _isDialog))
		] select _show);

		_ctrl ctrlCommit ([0.2, 0] select _interfaceInit);
	};

	/////------------- Marker Widgets ---------------\\\\\
	//-- Marker Edittor
		if ((_x # 0) == "MarkerEDIT") exitWith {
			private _group = _display displayCtrl (17000 + 1301);
			private _show = (_x # 1) != "";
			_group ctrlShow _show;
			if (_show) then {
				[_display, (_x # 1)] call cTab_fnc_Marker_Edittor;
			};
		};

	//-- Marker Droppers
		if ((_x # 0) == "MarkerWidget") exitWith {
			(_x # 1) params ["_show","_curSel","_BoxSel","_texts","_widgetMode"];
			(ctrlPosition (_display displayCtrl 1)) params ["","_ctrlY","","_ctrlH"];

			private ["_toggleBnt","_group","_TitleMode","_cate"];
			_toggleBnt = _display displayCtrl 1300;
			_group = _display displayCtrl (17000 + 1300);
			_TitleMode = _group controlsGroupCtrl 100;
			_cate = _group controlsGroupCtrl 11;

			_group ctrlEnable _show;
			_toggleBnt ctrlEnable !_show;

			if (_show) then {
				private ["_dropBox","_Title","_titleIcon","_DrawingTools"];
				//- "DropBox" Setup
				_dropBox = _group controlsGroupCtrl 10;
				_dropBox ctrlRemoveAllEventHandlers "LBSelChanged";

				_Title = "STR_BCE_Marker_Dropper";
				_titleIcon = "\a3\3DEN\Data\Displays\Display3DEN\PanelRight\modeMarkers_ca.paa";
				
				//- Drawing Tools
				_DrawingTools = [20,201,21,22,23] apply {_group controlsGroupCtrl _x};

				switch _widgetMode do {
					//- Drawing Marker
					case 1: {
						_titleIcon = "a3\3den\data\displays\display3den\panelright\submode_marker_area_ca.paa";
						_Title = "STR_BCE_Drawing_Tool";

						_cate ctrlShow false;
						{_x ctrlshow true} forEach _DrawingTools;
					};

					//- Marker Dropper
					default {
						//- DropBox Selection
						// _dropBox lbSetCurSel (_BoxSel # _widgetMode);
						_cate lbSetCurSel _curSel;
						_cate ctrlShow true;
						{_x ctrlshow false} forEach _DrawingTools;
					};
				};

				//- Update Items in ComboBox
					[_cate,_curSel] call cTab_fnc_Update_MarkerItems;

				//- Add Drop Eventhandler
					_dropBox ctrlAddEventHandler ["LBSelChanged",cTab_fnc_onMarkerSelChanged];

				_TitleMode ctrlSetStructuredText parseText format [
					"<img image='%1'/> %2<img align='right' image='\MG8\AVFEVFX\data\swap.paa'/>",
					_titleIcon,
					localize _Title
				];
			};

			//- Update Marker Text on Init
			if (_interfaceInit) then {
				{
					private ["_txt","_ctrl"];
					_txt = _texts # _forEachIndex;
					_ctrl = _group controlsGroupCtrl _x;
					[_ctrl,_txt] call cTab_fnc_onMarkerTextEditted;
					_ctrl ctrlSetText _txt;
				} forEach [15,16,17];
			};

			//- Set POS
			if (_displayName find "Android" > -1) then {
				_group ctrlSetPositionH ([
					0,
					5 * ((ctrlPosition _TitleMode) # 3)
				] select _show);
			} else {
				private _posToggle = ctrlPosition _toggleBnt;
				private _pos = ctrlPosition _cate;
				_group ctrlSetPositionX ([
					(_posToggle # 0) + (_posToggle # 2),
					(_posToggle # 0) + (_posToggle # 2) - (_pos # 2)
				] select _show);
				_group ctrlSetPositionW ([
					0,
					_pos # 2
				] select _show);
			};
			

			_group ctrlCommit ([0.2, 0] select _interfaceInit);
		};
		// -- TAD -- //
			if ((_x # 0) == "MarkerDropper") exitWith {
				(_x # 1) params ["_show","_mode"];
				
				_title = _display displayCtrl (17000 + 1600);
				// - Color 
					_title ctrlSetBackgroundColor ([ //- Change Background to Green
						[0,0,0,1],
						[0.2235,1,0.078,1]
					] select _show);

					_title ctrlSetTextColor ([ //- Change TEXT to Green
						[0.2235,1,0.078,1],
						[0,0,0,1]
					] select _show);

				_ctrlText = _display displayCtrl (17000 + 1602);
				_text = ["BLK","EMY","BLU"] # _mode; //- select Current Marker Mode 
				_ctrlText ctrlSetText _text;

				{
					(_display displayCtrl (17000 + _x)) ctrlShow _show
				} count [1601,1602,1603,16030,16011];
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

				//-BTF Widgets
				1300,
				17000 + 1200,
				17000 + 1301,

				IDC_CTAB_SCREEN,
				IDC_CTAB_SCREEN_TOPO,
				IDC_CTAB_HCAM_FULL,
				IDC_CTAB_OSD_HOOK_GRID,
				IDC_CTAB_OSD_HOOK_ELEVATION,
				IDC_CTAB_OSD_HOOK_DST,
				IDC_CTAB_OSD_HOOK_DIR,
				IDC_CTAB_NOTIFICATION]
			};
			if (_displayName find "Android" > -1) exitWith {
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
				17000 + 2615,
				17000 + 2616,
				46600,

				//-BG
				17000 + 4630,
				17000 + 4631,
				17000 + 46310,
				17000 + 4632,
				17000 + 4650,
				17000 + 4640,

				//-BTF Widgets
				17000 + 1200,
				17000 + 1301,

				//-POLPOX Map Tools
				#ifdef PLP_TOOL
				73454,
				17000 + 1202,
				17000 + 12012,
				#endif
				IDC_CTAB_GROUP_DESKTOP,
				IDC_CTAB_GROUP_MENU,
				IDC_CTAB_GROUP_MESSAGE,
				// IDC_CTAB_GROUP_COMPOSE,
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
				17000 + 3300, 17000 + 33000,
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
						1300, //- Marker Widget
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
						_displayItemsToShow append [17000 + 2615,17000 + 2616]; //- Show Compass on Phone
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
						private _mapScale = cTabMapScale * cTabMapScaleFactor / 0.86 * (safezoneH * 0.8);
						[_displayName,[["mapWorldPos", [_targetMapCtrl] call cTab_fnc_ctrlMapCenter],["mapScaleDlg",_mapScale]],false] call cTab_fnc_setSettings;
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
						_Showlist = [17000 + 4630,17000 + 4631,17000 + 46310,17000 + 46320] + [([1776,1775] select (_showMenu))];
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

					//- Other than Andorid phone
					cTabRscLayerMailNotification cutText ["", "PLAIN"];
					_displayItemsToShow = [IDC_CTAB_GROUP_MESSAGE];
					call cTab_msg_gui_load;
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
					['rendertarget13',_data] call cTab_fnc_createHelmetCam;
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
				
				//- Update the ATAK Tools //
					if (_displayName find "Android" > -1) then {
						"showMenu" call BCE_fnc_cTab_UpdateInterface;
					};

				// show correct map contorl
				if (!ctrlShown _targetMapCtrl) then {
					_targetMapCtrl ctrlShow true;
					// wait until map control is shown, otherwise we can get in trouble with ctrlMapAnimCommit later on, depending on timing
					while {!ctrlShown _targetMapCtrl} do {};
				};
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

				if !("Android" in _displayName) then {
					cTabMapScale = cTabMapScale / cTabMapScaleFactor;
				};
				_osdCtrl = _display displayCtrl IDC_CTAB_OSD_MAP_SCALE;

				// divide by 2 because we want to display the radius, not the diameter
				if (!isNull _osdCtrl) then {
					private _mapScaleTxt = [_mapScaleKm / 2,0,1] call CBA_fnc_formatNumber;
					_osdCtrl ctrlSetText _mapScaleTxt;
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

		// ------------ UAV List Update ------------
		if (_x # 0 == "uavListUpdate") exitWith {
			if (_mode in ["UAV","TASK_Builder"]) then {
				_data = cTab_player getVariable ["TGP_View_Selected_Vehicle",objNull];
				[IDC_CTAB_CTABUAVLIST, 17000+IDC_CTAB_CTABUAVLIST] apply {
					(_display displayCtrl _x) call BCE_fnc_cTab_CreateCameraList;
				};
			};
		};
		// ------------ HCAM List Update ------------
		if (_x # 0 == "hCamListUpdate") exitWith {
			if (_mode == "HCAM") then {
				[_display displayCtrl IDC_CTAB_CTABHCAMLIST,1] call BCE_fnc_cTab_CreateCameraList;
			};
		};

		// ---------- Marker Color -----------
		if ((_x # 0) == "markerColor") exitWith {
			private _markerColor = _display displayCtrl (17000 + 1090);
			private _cfg = "getnumber (_x >> 'scope') == 2" configClasses (configFile >> "CfgMarkerColors");
			if (lbSize _markerColor == 0) then {
				if (_isDialog) then {
					private _EDIT_color = _display displayCtrl (17000 + 1301) controlsGroupCtrl 51;

					{
						private ["_name","_color","_index"];
						_name = getText (_x >> "name");
						_color = (getArray (_x >> "color")) apply {
							if (_x isEqualType "") then {call compile _x} else {_x};
						};
						_index = _markerColor lbAdd _name;
						_EDIT_color lbAdd _name;
						_markerColor lbSetPicture [_index, "a3\ui_f\data\map\markers\nato\n_unknown.paa"];
						_EDIT_color lbSetPicture [_index, "a3\ui_f\data\map\markers\nato\n_unknown.paa"];

						_markerColor lbSetPictureColorSelected [_index, _color];
						_markerColor lbSetPictureColor [_index, _color];
						_markerColor lbSetData [_index, str [configName _x, _color]];

						_EDIT_color lbSetPictureColorSelected [_index, _color];
						_EDIT_color lbSetPictureColor [_index, _color];
						//- Without "_EDIT_color" Data
						false
					} count _cfg;
					_markerColor lbSetCurSel (_x # 1);
					
					//- Set EH only for Dialog
						_markerColor ctrlAddEventHandler ["LBSelChanged", {[cTabIfOpen # 1,[['markerColor',_this # 1]]] call cTab_fnc_setSettings}];
				} else {
					//- is display ,so there's no need to create the entire Color List

					private _cfg = _cfg # (_x # 1);
					private _name = getText (_cfg >> "name");

					private _color = (getArray (_cfg >> "color")) apply {
						if (_x isEqualType "") then {call compile _x} else {_x};
					};

					private _index = _markerColor lbAdd _name;
					_markerColor lbSetPicture [_index, "a3\ui_f\data\map\markers\nato\n_unknown.paa"];
					_markerColor lbSetPictureColor [_index, _color];
					_markerColor lbSetData [_index, str [configName _cfg, _color]];
					_markerColor lbSetCurSel _index;
				};
			};
			
			//- Update Marker Appearance
			([_displayName,"MarkerWidget"] call cTab_fnc_getSettings) params [["_show",false],"_index","","","_widgetMode"];
			if (_show && (_index == 3 || _widgetMode == 1)) then {
				private _ctrl = (_display displayCtrl (17000 + 1300)) controlsGroupCtrl 11;
				[_ctrl,_index] call cTab_fnc_Update_MarkerItems;
			};
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

					private _PIP_IDC = [17000 + 1786, 1773] select _UAV_Interface;
					
					//- hide PIP display
					private _PIP_Ctrl = _display displayCtrl _PIP_IDC;
					_PIP_Ctrl ctrlShow false;
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
		if (_x # 0 == "hCam" && (_displayName find "Android" < 0)) exitWith {
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
				if (_displayName find "TAD" < 0) then {
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

				} else {
					
					//---------------- TAD ----------------//
					private [
						"_osdCtrl","_text","_osdCtrl","_text"
					];

					//- Update Text
						_osdCtrl = _display displayCtrl IDC_CTAB_OSD_HOOK_TGGL1;
						_text = ["CURS","OWN"] select (_x # 1);
						_osdCtrl ctrlSetText _text;

						_osdCtrl = _display displayCtrl IDC_CTAB_OSD_HOOK_TGGL2;
						_text = ["OWN","CURS"] select (_x # 1);
						_osdCtrl ctrlSetText _text;
				};
			};
		};

		// ---------- ATAK Tools -----------
		if (((_x # 0) == "showMenu") && (_mode == "BFT")) exitWith {
			{
				(_display displayCtrl 17000 + _x) ctrlShow false;
				false
			} count [
				4660, 
				4661, 
				4662, 
				4663,
				4650,
				4640
			];

			(_x # 1) params ["_page","_show","_line",["_PgComponents",[]]];
		
			private _group = [_display, _page, (_page != "main") && _show] call BCE_fnc_ATAK_openPage;
			
			private _background = _display displayCtrl IDC_CTAB_GROUP_MENU;
			_background ctrlShow _show;

			//- Get Map Type
				private ["_targetMapName","_mapTypes","_targetMapIDC","_targetMapCtrl","_bgW"];
				_targetMapName = [_displayName,"mapType"] call cTab_fnc_getSettings;
				_mapTypes = [_displayName,"mapTypes"] call cTab_fnc_getSettings;
				_targetMapIDC = [_mapTypes,_targetMapName] call cTab_fnc_getFromPairs;
				_targetMapCtrl = _display displayCtrl _targetMapIDC;
				_bgW = (ctrlPosition _background) # 2;

				_targetMapCtrl ctrlSetPositionW (_bgW / 2 * ([5, 3] select (_show || (uiNamespace getVariable ['BCE_ATAK_TRACK_Focus',false]))));
				_targetMapCtrl ctrlCommit 0;
				_targetMapCtrl ctrlMapSetPosition [];
			
			if (isnil{_group} || !_show) exitWith {};
			_group ctrlShow _show;

			//-ATAK Control Adjustments
			switch (_page) do {
				case "VideoFeeds": {
					private _switch_btn = _group controlsGroupCtrl 5;
					private _ListGroup = _group controlsGroupCtrl 10;
					private _ViewGroup = _group controlsGroupCtrl 20;
					private _commitTime = {[_this, 0] select _interfaceInit};
					private _hcam = [_displayName, "hcam"] call cTab_fnc_getSettings;

					//- Get Last Selection
						private _SubSel = _PgComponents param [0, [0,1] select (_hcam != "")];

					//- Control Components
						private _ctrl_TrackTG = _ViewGroup controlsGroupCtrl 11;
						private _ctrl_TrackInfo = _ViewGroup controlsGroupCtrl 12;
						private _ctrl_Vision = _ViewGroup controlsGroupCtrl 13;
						private _ctrl_Sync = _ViewGroup controlsGroupCtrl 14;
						private _ctrl_View = _ViewGroup controlsGroupCtrl 46310;
						private _ctrl_Turret = _ViewGroup controlsGroupCtrl 46320;
						private _ctrl_PIP = _ViewGroup controlsGroupCtrl 4632;
					
					//- Check if is Sub-Menu
						private _subMenu = _line > 0;

						_ListGroup ctrlEnable _subMenu;
						_ViewGroup ctrlEnable !_subMenu;

						_ListGroup ctrlSetPositionH ([
							0,
							(ctrlPosition _group) # 3
						] select _subMenu);
						_ListGroup ctrlSetFade ([1,0] select _subMenu);
						_ListGroup ctrlCommit (0.3 call _commitTime);
		
						{
							_x ctrlSetFade ([0,1] select _subMenu);
							_x ctrlCommit ((0.08 * (1 max _forEachIndex)) call _commitTime);
						} forEach allControls _ViewGroup;
					
					//- Setup View Control Lists
						if (_subMenu) exitWith {
							//- List Controls
								private _toolbox = _ListGroup controlsGroupCtrl 6;
								private _ls = _ListGroup controlsGroupCtrl 7;

							//- Setup Lists Selections
								_toolbox ctrlRemoveAllEventHandlers "ToolBoxSelChanged";
								_ls ctrlRemoveAllEventHandlers "LBSelChanged";

								//- Generate Camera Connectable List
								[_ls,_SubSel] call BCE_fnc_cTab_CreateCameraList;
								_toolbox lbSetCurSel _SubSel;

								_toolbox ctrlAddEventHandler ["ToolBoxSelChanged", {
									[_this # 0,3,_this # 1] call BCE_fnc_ATAK_Camera_Controls
								}];
								_ls ctrlAddEventHandler ["LBSelChanged", {
									[_this # 0,4,_this # 1] call BCE_fnc_ATAK_Camera_Controls
								}];

							_switch_btn ctrlSetStructuredText parseText "Select Camera";
							_ctrl_View ctrlRemoveAllEventHandlers "MouseEnter";
							_ctrl_View ctrlRemoveAllEventHandlers "MouseExit";
						};
					
					if (_interfaceInit) exitWith {};

					//- View Box Status
						private _veh = cTab_player getVariable ["TGP_View_Selected_Vehicle",objNull];
						private _isHcam = _SubSel == 1;
						//- exit if display is on
						private _displayOn = (
							!isnull(uiNamespace getVariable ["BCE_HCAM_View",displayNull]) || 
							((player getVariable ["TGP_View_EHs", -1]) != -1)
						);
					
					//- Setup PIP Camera
						call {
							//- Helmet CAM
							if (_isHcam) exitWith {
								_ctrl_Turret ctrlSetText "Helment CAM";
								call cTab_fnc_deleteUAVcam;
								player setVariable ["TGP_View_Selected_Optic",[[],objNull],true];
								_veh = ["rendertarget9",_hcam, !_displayOn] call cTab_fnc_createHelmetCam;
							};
							//- AV CAM
							if (!isnull _veh && !_displayOn) exitWith {
								call cTab_fnc_deleteHelmetCam; //- delete Hcam PIP
								[_veh,[[1,"rendertarget9"]],false] call cTab_fnc_createUavCam;
							};
						};

					private _null_Connected = isnull _veh;
					
					//- PIP Control
						_ctrl_PIP ctrlShow ((!_null_Connected || _isHcam) && !_displayOn);
					//- Button Control
						_ctrl_View ctrlEnable (!_null_Connected && !_displayOn);
					//- Widget Control
						{_x ctrlEnable (!_null_Connected && !_isHcam && !_displayOn)} count [_ctrl_TrackTG,_ctrl_Vision,_ctrl_Sync,_ctrl_Turret];

					//- Create PIP camera if mode is "UAV"
						private _title = if (_null_Connected) then {
							_ctrl_Turret ctrlSetText "- -";
							
							_ctrl_View ctrlSetFade 0;
							_ctrl_View ctrlSetText localize "STR_BCE_No_Signal";
							_ctrl_View ctrlcommit (0.2 call _commitTime);
							
							_ctrl_View ctrlRemoveAllEventHandlers "MouseEnter";
							_ctrl_View ctrlRemoveAllEventHandlers "MouseExit";

							"- -"
						} else {
							_ctrl_TrackTG ctrlSetBackgroundColor ([[0.5,0,0,0.3],[0,0,0.5,0.3]] select (uiNamespace getVariable ['BCE_ATAK_TRACK_Focus',false]));

							_ctrl_View ctrlSetFade 1;
							_ctrl_View ctrlSetText localize "STR_BCE_Live_Feed";
							_ctrl_View ctrlcommit 0;

							_ctrl_View ctrlAddEventHandler ["MouseEnter", {(_this # 0) ctrlSetFade 0.5; (_this # 0) ctrlcommit 0.2;}];
							_ctrl_View ctrlAddEventHandler ["MouseExit", {(_this # 0) ctrlSetFade 1; (_this # 0) ctrlcommit 0.2;}];

							[groupId group _veh, [_veh] call CBA_fnc_getGroupIndex] joinString " : "
						};

					//- Set Title Text
						_switch_btn ctrlSetStructuredText parseText _title;
						_ctrl_TrackInfo ctrlSetText localize "STR_BCE_None"; //- Rewrite the Focus Point (Relative Info)

					//- Update Vision Mode (after Camera is Generated)
							[_ctrl_TrackTG,0,false] call BCE_fnc_ATAK_Camera_Controls;
							[_ctrl_Vision,1,false] call BCE_fnc_ATAK_Camera_Controls;
							[_ctrl_Sync,2,false] call BCE_fnc_ATAK_Camera_Controls;
						
				};
				case "message": {
					private _title = _group controlsGroupCtrl 5;
					private _contacts = _group controlsGroupCtrl 6;
					private _list = _group controlsGroupCtrl 10;
					private _typing = _group controlsGroupCtrl 11;
					private _commitTime = {[_this, 0] select _interfaceInit};

					//- Get Contactor
					private _previus = [_displayName, "Contactor"] call cTab_fnc_getSettings;
					private _contactor = if (_interfaceInit || _previus != "") then {
						_previus
					} else {
						private _c = _contacts lbData (lbCurSel _contacts);
						[_displayName, [["Contactor",_c]],false] call cTab_fnc_setSettings;
						_c
					};

					//- Clear all Lists
						{ctrlDelete _x} count allControls _list;
						lbClear _contacts;
					
					//- on Showing Contactors (exitWith)
						if (_line > 0) exitWith {
							_list ctrlEnable false;
							_list ctrlSetFade 1;
							_list ctrlCommit (0.25 call _commitTime);
							
							_contacts ctrlEnable true;
							_contacts ctrlSetFade 0;
							_contacts ctrlSetPositionH ((ctrlPosition _list) # 3);
							_contacts ctrlCommit (0.2 call _commitTime);

							//- Get Contactors 
								private _plrList = playableUnits;
								private _validSides = call cTab_fnc_getPlayerSides;
								if (_plrList findIf {true} < 0) then {_plrList pushBack cTab_player};
								{
									if ((side _x in _validSides) && {isPlayer _x} && {[_x,ctab_core_leaderDevices] call cTab_fnc_checkGear}) then {
										private _data = str _x;
										private _name = format [
											"%1:%2 (%3)",
											groupId group _x,
											[_x] call CBA_fnc_getGroupIndex,
											name _x
										];
										private _index = _contacts lbAdd _name;
										_contacts lbSetData [_index, _data];
										if (_previus == _data) then {
											_contacts lbSetCurSel _index;
											_title ctrlSetStructuredText parseText _name;
										};
									};
									false
								} count _plrList;
								uiNamespace setVariable ['cTab_msg_playerList', _plrList];
								lbSort _contacts;
						};
						_contacts ctrlEnable false;
						_contacts ctrlSetFade 1;
						_contacts ctrlSetPositionH 0;
						_contacts ctrlCommit (0.2 call _commitTime);

					_list ctrlEnable true;
					_list ctrlSetFade 0;
					_list ctrlCommit (0.25 call _commitTime);

					//- sort out the correct "_contactor" name (STRING)
						{
							if (str _x == _contactor) exitWith {
								_contactor = name _x;
							};
						} count ([cTab_player] + playableUnits);
					
					//- exit on none "_contactor" Selected
						if (_contactor == "") exitWith {
							_title ctrlSetStructuredText parseText format ['"%1"',localize "STR_BCE_None"];
						};
					_title ctrlSetStructuredText parseText _contactor;

					//- Msg Sort
						private _msgArray = cTab_player getVariable ["cTab_messages_" + call cTab_fnc_getPlayerEncryptionKey,[]];

						private _index = 0;
						private _size_H = 0;
						private _time_AC = 0;
						{
							_x params ["_title","_msgBody","_msgState"];
							private _sep = _title find "-";

							//- Skip on empty
								if (_sep < 0) then {continue};
							
							private _name = (_title select [_title find "("]) trim ["() ", 0];

							//- Skip on Diff Contactor
								if (_contactor != _name) then {continue};
							
							private _time = _title select [0,_sep];
							private _time_s = (_time splitString ":") apply {parseNumber _x};
							private _chatRoom = (_title select [_sep]) trim ["- ", 0];

							//- Sent
							private _size = 1;

							//- on every 30 mins
								//- on more than (30 mins)
									_time_s = abs((_time_s # 0) * 60 + (_time_s # 1));

								if ((_time_s - _time_AC) >= 30) then {
									private _size = 0.8;
									private _ctrlMsg = [_list,4, ["--",_time,"--"] joinString " "] call BCE_fnc_ATAK_msg_Line_Create;
									private _ctrl_H = (ctrlPosition _ctrlMsg) # 3;

									_ctrlMsg ctrlSetPositionY _size_H;
									_ctrlMsg ctrlSetPositionH (_ctrl_H * _size);
									_ctrlMsg ctrlCommit 0;
									
									_size_H = _size_H + (_ctrl_H * _size);
									_index = _index + 1;
								};
								_time_AC = _time_s;
								
							//- get how many "\t" in the message
								_msgBody = toString Flatten((toArray _msgBody) apply {
									if (10 == _x) then {
										_size = _size + 1;
										toArray "<br/>"
									} else {
										_x
									};
								});

							private _txt = if (_msgState == 2) then {
								_msgBody
							} else {
								//- Receives
								_size = _size + 1;
								_name = format [
									"<t shadow='2' color='#ffffff'>%1 <t valign='middle' size='0.55'>(%2)</t> :</t>",
									_name,
									_time
								];
								[_name,_msgBody] joinString "<br/>"
							};

							private _ctrlMsg = [_list,_msgState,_txt] call BCE_fnc_ATAK_msg_Line_Create;
							private _ctrl_H = (ctrlPosition _ctrlMsg) # 3;

							_ctrlMsg ctrlSetPositionY _size_H;
							_ctrlMsg ctrlSetPositionH (_ctrl_H * _size);
							_ctrlMsg ctrlCommit 0;
							
							//- sorting Data
								_size_H = _size_H + (_ctrl_H * _size);
								_index = _index + 1;
						} forEach _msgArray;
					
					cTabRscLayerMailNotification cutText ["", "PLAIN"];
					_list spawn {
						uiSleep 0.1;
						_this ctrlSetScrollValues [1, -1];
					};
				};
				case "mission": {
					//-restore Task Type
					_group ctrlSetScrollValues [uiNamespace getVariable ["BCE_ATAK_Scroll_Value",0], -1];

					private _ctrl = _group controlsGroupCtrl (17000 + 2107);
					_ctrl lbSetCurSel (uiNamespace getVariable ["BCE_Current_TaskType",0]);
				};
				case "Task_Result": {
					private _ctrl = _group controlsGroupCtrl 11;
					private _curType = uiNameSpace getVariable ["BCE_Current_TaskType",0];
					private _taskVar = uiNameSpace getVariable (["BCE_CAS_9Line_Var","BCE_CAS_5Line_Var"] # _curType);
					[_ctrl,[9,5] # _curType,_taskVar,player getVariable ["TGP_View_Selected_Vehicle",objNull]] call BCE_fnc_SetTaskReceiver;
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
