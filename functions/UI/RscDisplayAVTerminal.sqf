#include "\A3\ui_f\hpp\defineResincl.inc"
#include "\A3\ui_f\hpp\defineResinclDesign.inc"
#include "\MG8\AVFEVFX\cTab\has_cTab.hpp"
params["_mode","_params","_class"];

_fnc_onLBSelChanged = {
	params ["_ctrlValue","_selectedIndex"];

	_display = ctrlParent _ctrlValue;
	_checklist = _display displayCtrl 2100;
	_Selected = player getvariable ["TGP_View_Selected_Vehicle",objNull];

	_vehicle_str = _ctrlValue lbdata _selectedIndex;

	//-cTab Compat
	#ifdef cTAB_Installed
	  ['cTab_Tablet_dlg',[['uavCam',_vehicle_str]]] call cTab_fnc_setSettings;
	#endif

	//-CAS Layout
	_createTask = _display displayCtrl 2103;

	if (_vehicle_str == "") exitwith {
	  lbClear _checklist;

	  [1501,1502,1503,1504,1505,1506,1507] apply {
	  	(_display displayCtrl _x) ctrlSetText "-";
	  };
	  player setVariable ["TGP_View_Selected_Vehicle",objNull];
	  player setVariable ["TGP_View_Selected_Optic",[[],objNull],true];
	  (_display displayctrl 1600) ctrlEnable false;
	  (_display displayctrl 1601) ctrlEnable false;
	  (_display displayctrl 1602) ctrlEnable false;

	  //-CAS Menu
	  uiNameSpace setVariable ["BCE_CAS_ListSwtich", false];
	  [(_display displayctrl 1600), true] call BCE_fnc_clearTaskInfo;
	  [_display,1,true] call BCE_fnc_ListSwitch;
	  _createTask ctrlEnable false;
	};
	_vehicle = (vehicles Select {(_x isKindOf "Air") && (isEngineOn _x)}) apply {
	  if (_vehicle_str == str _x) exitwith {_x};
	};

	if !(_vehicle isEqualTo (player getVariable "TGP_View_Selected_Vehicle")) then {
	  uiNameSpace setVariable ["BCE_CAS_ListSwtich", false];
	  [(_display displayctrl 1600), true] call BCE_fnc_clearTaskInfo;
	};

	_Optic_LODs = [_vehicle,0] call BCE_fnc_Check_Optics;

	[_display,1,true,_vehicle] call BCE_fnc_ListSwitch;
	_createTask ctrlEnable true;

	//-Button Enable
	(_display displayctrl 1600) ctrlEnable !(_Optic_LODs isEqualTo []);
	(_display displayctrl 1602) ctrlEnable (count _Optic_LODs > 1);

	_Selected_Optic = player getVariable ["TGP_View_Selected_Optic",[[],objNull]];
	if (((player getVariable ["TGP_View_Selected_Optic",[]]) isEqualTo []) || (_vehicle isNotEqualTo (_Selected_Optic # 1))) then {
	  player setVariable ["TGP_View_Selected_Optic",[(_Optic_LODs # 0),_vehicle],true];
	};

	[{
		params ["_display","_ctrlValue","_Selected","_vehicle_New"];

		_vehicle = player getvariable ["TGP_View_Selected_Vehicle",objNull];

		if (!(isnull _vehicle) || (ctrlShown (_display displayCtrl 1700))) then {

			_Selected_Optic = player getVariable "TGP_View_Selected_Optic";
			_current_turret = (_Selected_Optic # 0) param [1,[0]];

			_turret_Unit = _vehicle turretUnit _current_turret;
			_turret_List = missionNamespace getVariable ["TGP_View_Turret_List",[]];

			_gunner = [name _turret_Unit,"-"] select (((isNull _turret_Unit) || (_turret_Unit isEqualTo (driver _vehicle))));
			_pilot = [name (driver _vehicle),"-"] select ((driver _vehicle) isEqualTo objNull);

			_Cond_CtrlVeh = [
		      false,
		      (isUAVConnected _vehicle) && (((UAVControl _vehicle) # 0) isNotEqualTo player)
		    ] select (unitIsUAV _vehicle);

			(_display displayCtrl 1501) ctrlSetText _pilot;
			(_display displayCtrl 1502) ctrlSetText _gunner;

			// - Disable Unavailable Turret
			if (
				_Cond_CtrlVeh ||
				(_gunner == "-") ||
				(_turret_Unit in _turret_List) ||
				(({!((_x getVariable ["TGP_View_Turret_Control", []]) isEqualTo [])} count (crew _vehicle)) > 0) ||
			  ((getText ([_vehicle, _current_turret] call BIS_fnc_turretConfig >> "turretInfoType")) in ["","RscWeaponZeroing"])
			) then {
			  (_display displayctrl 1601) ctrlEnable false;
			} else {
			  (_display displayctrl 1601) ctrlEnable true;
			};

			if (isnull _vehicle) then {
			  {
			  	(_display displayCtrl (1500 + _x)) ctrlSetText "-";
			  } count [3,4,5,6,7,8];
			} else {
			  private ["_config","_weapon"];
			  _config = configFile >> "CfgWeapons";
			  _weapon = [
			  	getText (_config >> _vehicle currentWeaponTurret _current_turret >> "DisplayName"),
			  	"-"
			  ] select (getText (_config >> _vehicle currentWeaponTurret _current_turret >> "DisplayName") == "");

			  (_display displayCtrl 1503) ctrlSetText format ["%1",_weapon];
			  (_display displayCtrl 1504) ctrlSetText format ["%1%2",round ((fuel _vehicle) * 100) , "%"];
			  (_display displayCtrl 1505) ctrlSetText format ["%1 %2",localize "$str_a3_rscdisplayartillery_artillerygridtext",mapGridPosition _vehicle];
			  (_display displayCtrl 1506) ctrlSetText format ["%1°",round (getdir _vehicle)];
			  (_display displayCtrl 1507) ctrlSetText format ["%1 km/h",round (speed _vehicle)];
			  (_display displayCtrl 1508) ctrlSetText format ["%1 m",round ((getPosASL _vehicle) # 2)];
			};
		};

		((lbCurSel _ctrlValue < 0) || !(_vehicle_New isEqualTo _vehicle) || !(alive player) || (isNull (findDisplay 160)))
	}, {
		params ["_display"];
		if (isNull _display) then {
		  player setVariable ['BCE_TACMap_Visiable',false,true];
		};
		}, [_display,_ctrlValue,_Selected,_vehicle]
	] call CBA_fnc_waitUntilAndExecute;

	player setVariable ["TGP_View_Selected_Vehicle",_vehicle];
};

switch _mode do
{
	case "onLoad":
	{
		player setVariable ["BCE_TACMap_Visiable",true,true];
		with uinamespace do
		{
			_display = _params # 0;
			(_display displayCtrl 1500) ctrlSetText format ["%1(TGP)",localize "$STR_A3_RscDisplayAVTerminal_AVT_Text_SelectAV"];

			//Set NO CONNECTION texts to upper
			_control = _display displayctrl 1024;
			_control ctrlSetText (toUpper (ctrlText _control));

			_control = _display displayctrl 1025;
			_control ctrlSetText (toUpper (ctrlText _control));

			//--- Hide hint
			if !(isNil {missionNamespace getVariable "BIS_fnc_advHint_HPressedCtrl"}) then {
				with missionnamespace do {
					BIS_fnc_advHint_silentClosure = true;
					BIS_fnc_advHint_HPressed = true;
					BIS_fnc_advHint_RefreshCtrl = true;
					[true] call BIS_fnc_AdvHintCall;
				};
			};

			_ctrlHintGroup = _display displayctrl IDC_RSCADVANCEDHINT_HINTGROUP;
			_ctrlHintGroup ctrlShow false;
			_ctrlHintGroup ctrlEnable false;
			[1600,1601,1602,2103,201142] apply {
				(_display displayctrl _x) ctrlEnable false
			};
			(_display displayctrl 20116) ctrlSetPositionH 0;
		  (_display displayctrl 20116) ctrlCommit 0;

			(_display displayctrl 2107) lbSetCurSel (uiNameSpace getVariable ["BCE_Current_TaskType",0]);

			//-CAS Layout
			[_display,0,true] call BCE_fnc_ListSwitch;

			//-Set UI Game Plan UI BNTs
			{
				(_display displayctrl (20110 + (_x # 0))) ctrlSetStructuredText parseText ((localize (_x # 1)) call BCE_fnc_formatLanguage)
			} count [
				[0,"STR_BCE_ControlType_BNT"],
				[1,"STR_BCE_AttackType_BNT"],
				[3,"STR_BCE_OrdnanceREQ_BNT"]
			];

			("RscAdvancedHint" call bis_fnc_rsclayer) cuttext ["","plain"];

			_control = _display displayctrl 1700;
			_control ctrladdeventhandler ["LBSelChanged",_fnc_onLBSelChanged];

			_selected = player getvariable ["TGP_View_Selected_Vehicle",objNull];

			_UnitList = vehicles Select {
			  (_x isKindOf "Air") && (isEngineOn _x) && (playerSide == side _x)
			};

			//-Exit Task Builder if Nil {_vehicle}
			if (_selected isEqualTo objNull) then {
				uiNameSpace setVariable ["BCE_CAS_ListSwtich", false];
				[(_display displayctrl 1600), true] call BCE_fnc_clearTaskInfo;
				[_display,1,true] call BCE_fnc_ListSwitch;
				(_display displayCtrl 2103) ctrlEnable false;
			};

			{
			  _vehicle = _x;
			  _cfg = configOf _vehicle;

				_lbAdd = _control lbAdd format ["%1   %2",Name _vehicle,gettext (_cfg >> "displayName")];
				_control lbSetData [_lbAdd, str _vehicle];
			} foreach _UnitList;

			//- Memory
			for "_i" from 0 to ((lbsize _control) - 1) do {
				if ((_control lbdata _i) == str _selected) exitwith {
					_control lbSetCurSel _i;
				};
			};

			//-Widgets

			[
				[0,"BCE_Terminal_WP"],
				[1,"BCE_Terminal_Veh"],
				[2,"BCE_Terminal_Targeting"],
				[3,"BCE_Terminal_SelColor",[0,1,0.3,0.8],[1,1,0.3,0.8]]
			] apply {
				_x params ["_idc","_var",["_cor0",[1,0,0,0.5]],["_cor1",[1,1,1,1]]];
				(_display displayctrl (1606 + _idc)) ctrlSetTextColor ([_cor0,_cor1] select (uinamespace getVariable [_var,true]));
			};

			private _map = _display displayctrl 51;
			if (uinamespace getVariable ['BCE_Map_BGColor',true]) then {
				(_display displayctrl 1610) ctrlSetTextColor [0.969,0.957,0.949,0.8];
				_map ctrlSetBackgroundColor (getArray (configfile >> 'RscMapControl' >> 'colorBackground'));
			} else {
				(_display displayctrl 1610) ctrlSetTextColor [0,1,0,0.8];
				_map ctrlSetBackgroundColor [0.075,0.075,0.075,0.5];
			};
		};

		//-Turret Control UI
		if (missionNamespace getVariable ["TGP_View_Terminal_canUseTurret",false]) then {
			(_display displayctrl 1601) ctrlShow true;
			(_display displayctrl 1600) ctrlSetPosition [
				0.3 * (safezoneW / 64) + (safezoneX),
				0.71 * safezoneH + safezoneY,
				13.2 * (safezoneW / 64),
				0.8 * (safezoneH / 40)
			];
		} else {
			(_display displayctrl 1601) ctrlShow false;
			(_display displayctrl 1600) ctrlSetPosition [
				0.3 * (safezoneW / 64) + (safezoneX),
				0.695 * safezoneH + safezoneY,
				13.2 * (safezoneW / 64),
				1 * (safezoneH / 40)
			];
		};
		(_display displayctrl 1600) ctrlCommit 0;
		(_display displayctrl 1601) ctrlCommit 0;

		//-EHs
		_control = _display displayctrl 1600;
		_control ctrladdeventhandler ["ButtonClick",{
			if !(player getVariable ["TGP_View_Selected_Vehicle",objNull] isEqualTo objNull) then {
				(player getVariable "TGP_View_Selected_Vehicle") call BCE_fnc_TGP_Select_Confirm;
			};
		}];
		_control = _display displayctrl 1601;
		_control ctrlAddEventHandler ["ButtonClick",{
			private _vehicle = player getVariable ["TGP_View_Selected_Vehicle",objNull];
			if !(isnull _vehicle) then {
			  [_vehicle,cameraview] call BCE_fnc_onButtonClick_Gunner;
				_vehicle call BCE_fnc_TGP_Select_Confirm;
			};
		}];

		//Switch to driver/gunner after click on PIP (picture doesn't have buttonClick event, using MouseButtonUp instead).
		_control = _display displayctrl IDC_IGUI_AVT_PIP1;
		_control ctrladdeventhandler ["MouseButtonUp","with uinamespace do {['pipClicked',_this,''] call RscDisplayAVTerminal_script};"];
		_control = _display displayctrl IDC_IGUI_AVT_PIP2;
		_control ctrladdeventhandler ["MouseButtonUp","with uinamespace do {['pipClicked',_this,''] call RscDisplayAVTerminal_script};"];

		//-Apply Map Background
		if (uinamespace getVariable ['BCE_Map_BGColor',true]) then {
			(_display displayCtrl 1610) ctrlSetTextColor [0.969,0.957,0.949,0.8];
			_map ctrlSetBackgroundColor _Map_color;
		} else {
			(_display displayCtrl 1610) ctrlSetTextColor [0,1,0,0.8];
			_map ctrlSetBackgroundColor [0.075,0.075,0.075,0.5];
		};
	};
	case "pipClicked":
	{
		_control = _params # 0;
		_display = ctrlParent _control;

		switch (ctrlIDC _control) do
		{
			case 105:
			{
				ctrlActivate(_display displayctrl IDC_IGUI_AVT_TAKE_CONTROL_DRIVER);
			};

			case 106:
			{
				ctrlActivate(_display displayctrl IDC_IGUI_AVT_TAKE_CONTROL_GUNNER);
			};
		};
	};
};
