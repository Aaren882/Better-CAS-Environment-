#include "\A3\ui_f\hpp\defineResincl.inc"
#include "\A3\ui_f\hpp\defineResinclDesign.inc"

params["_mode","_params","_class"];

_fnc_onLBSelChanged = {
	params ["_ctrlValue","_selectedIndex"];

	_display = ctrlParent _ctrlValue;
	_checklist = _display displayCtrl 2100;
	_Selected = player getvariable ["TGP_View_Selected_Vehicle",objNull];

	_vehicle_str = _ctrlValue lbdata _selectedIndex;

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
		if (_vehicle_str  == str _x) exitwith {_x};
	};

	if !(_vehicle isEqualTo (player getVariable "TGP_View_Selected_Vehicle")) then {
	  uiNameSpace setVariable ["BCE_CAS_ListSwtich", false];
		[(_display displayctrl 1600), true] call BCE_fnc_clearTaskInfo;
	};

	_Optic_LODs = _vehicle getVariable ["TGP_View_Available_Optics",[]];

	[_display,1,true,_vehicle] call BCE_fnc_ListSwitch;
	_createTask ctrlEnable true;

	//-Button Enable
	(_display displayctrl 1600) ctrlEnable !(_Optic_LODs isEqualTo []);
	(_display displayctrl 1602) ctrlEnable (count _Optic_LODs > 1);

	if (player getVariable ["TGP_View_Selected_Optic",[]] isEqualTo []) then {
	  player setVariable ["TGP_View_Selected_Optic",[(_Optic_LODs # 0),_vehicle],true];
	};

	if !(_vehicle isEqualTo ((player getVariable "TGP_View_Selected_Optic") # 1)) then {
	  player setVariable ["TGP_View_Selected_Optic",[(_Optic_LODs # 0),_vehicle],true];
	};

	[{
		params ["_display","_ctrlValue","_Selected","_vehicle_New"];

		_vehicle = player getvariable ["TGP_View_Selected_Vehicle",objNull];

		if (!(_vehicle isEqualTo objNull) or (ctrlShown (_display displayCtrl 1700))) then {

			_Selected_Optic = player getVariable "TGP_View_Selected_Optic";
			_current_turret = (_Selected_Optic # 0) param [1,[0]];

			_turret_Unit = _vehicle turretUnit _current_turret;

			_gunner = [name _turret_Unit,"-"] select ((_turret_Unit isEqualTo objNull) or (_turret_Unit isEqualTo (driver _vehicle)));
			_pilot = [name (driver _vehicle),"-"] select ((driver _vehicle) isEqualTo objNull);

			_Cant_CtrlVeh = ({!((_x getVariable ["TGP_View_Turret_Control", []]) isEqualTo [])} count (crew _vehicle)) > 0;

			// - Disable Unavailable Turret
			if (
				 _Cant_CtrlVeh or
				(_gunner == "-") or
				(_turret_Unit in (missionNamespace getVariable ["TGP_View_Turret_List",[]])) or
				((vehicle _turret_Unit) in (missionNamespace getVariable ["TGP_View_Turret_List",[]])) or
			  ((getText ([_vehicle, _current_turret] call BIS_fnc_turretConfig >> "turretInfoType")) in ["","RscWeaponZeroing"])
			) then {
			  (_display displayctrl 1601) ctrlEnable false;
			} else {
				(_display displayctrl 1601) ctrlEnable true;
			};

			(_display displayCtrl 1501) ctrlSetText _pilot;
			(_display displayCtrl 1502) ctrlSetText _gunner;

			if (_vehicle isEqualTo objNull) then {
				(_display displayCtrl 1503) ctrlSetText "-";
				(_display displayCtrl 1504) ctrlSetText "-";
				(_display displayCtrl 1505) ctrlSetText "-";
				(_display displayCtrl 1506) ctrlSetText "-";
				(_display displayCtrl 1507) ctrlSetText "-";
				(_display displayCtrl 1508) ctrlSetText "-";
			} else {
				_weapon = if (isNil {_current_turret}) then {
				  getText (configFile >> "CfgWeapons" >> currentWeapon _vehicle >> "DisplayName")
				} else {
					if (_current_turret isEqualTo []) then {
						if (getText (configFile >> "CfgWeapons" >> currentWeapon _vehicle >> "DisplayName") != "") then {
						  getText (configFile >> "CfgWeapons" >> currentWeapon _vehicle >> "DisplayName")
						} else {
							"-"
						};
					} else {
						if (getText (configFile >> "CfgWeapons" >> _vehicle currentWeaponTurret _current_turret >> "DisplayName") != "") then {
						  getText (configFile >> "CfgWeapons" >> _vehicle currentWeaponTurret _current_turret >> "DisplayName")
						} else {
							"-"
						};
					};
				};

				(_display displayCtrl 1503) ctrlSetText format ["%1",_weapon];
				(_display displayCtrl 1504) ctrlSetText format ["%1%2",round ((fuel _vehicle) * 100) , "%"];
				(_display displayCtrl 1505) ctrlSetText format ["%1 %2",localize "$str_a3_rscdisplayartillery_artillerygridtext",mapGridPosition _vehicle];
				(_display displayCtrl 1506) ctrlSetText format ["%1°",round (getdir _vehicle)];
				(_display displayCtrl 1507) ctrlSetText format ["%1 km/h",round (speed _vehicle)];
				(_display displayCtrl 1508) ctrlSetText format ["%1 m",round ((getPosASL _vehicle) # 2)];
			};
		};

		((lbCurSel _ctrlValue < 0) or !(_vehicle_New isEqualTo _vehicle) or !(alive player))
	}, {

		}, [_display,_ctrlValue,_Selected,_vehicle]
	] call CBA_fnc_waitUntilAndExecute;

	player setVariable ["TGP_View_Selected_Vehicle",_vehicle];
};

_fnc_onButtonClick_Connect = {
	if !(player getVariable ["TGP_View_Selected_Vehicle",objNull] isEqualTo objNull) then {
		(player getVariable "TGP_View_Selected_Vehicle") call BCE_fnc_TGP_Select_Confirm;
	};
};

_fnc_onButtonClick_Switch = {
	params ["_control"];

	private _vehicle = player getVariable ["TGP_View_Selected_Vehicle",objNull];
	if !(_vehicle isEqualTo objNull) then {
		(call BCE_fnc_getTurret) params ["_cam","_vehicle","_Optic_LODs","_current_turret"];

		if (count _Optic_LODs == 1) exitWith {};
		_current_turret = if (_current_turret < 1) then {
			(count _Optic_LODs) - 1
		} else {
			_current_turret - 1
		};

		_turret_select = _Optic_LODs # _current_turret;
		player setVariable ["TGP_View_Selected_Optic",[_turret_select,_vehicle],true];
		_squad_list = (ctrlParent _control) displayctrl 20116;

		if (ctrlshown _squad_list) then {
		 	_squad_list lbSetCurSel ([(_current_turret + 1) min (count _Optic_LODs),_current_turret] select (-1 in (flatten _Optic_LODs)));
		};
	};
};

switch _mode do
{
	case "onLoad":
	{
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
			(_display displayctrl 1600) ctrlEnable false;
			(_display displayctrl 1601) ctrlEnable false;
			(_display displayctrl 1602) ctrlEnable false;
			(_display displayctrl 2103) ctrlEnable false;

			(_display displayctrl 2107) lbSetCurSel (uiNameSpace getVariable ["BCE_Current_TaskType",0]);

			//-CAS Layout
			[_display,0,true] call BCE_fnc_ListSwitch;

			("RscAdvancedHint" call bis_fnc_rsclayer) cuttext ["","plain"];

			_control = _display displayctrl 1700;
			_control ctrladdeventhandler ["LBSelChanged",_fnc_onLBSelChanged];

			_selected = player getvariable ["TGP_View_Selected_Vehicle",objNull];

			_UnitList = vehicles Select {
			  !(_x getVariable "TGP_View_Available_Optics" isEqualTo []) && (_x isKindOf "Air") && (isEngineOn _x) && (playerSide == side _x)
			};

			//-Exit Task Builder if Nil {_vehicle}
			if (_selected isEqualTo objNull) then {
				uiNameSpace setVariable ["BCE_CAS_ListSwtich", false];
				[(_display displayctrl 1600), true] call BCE_fnc_clearTaskInfo;
			};

			{
			  _vehicle = _x;
			  _cfg = configfile >> "cfgvehicles" >> typeOf _vehicle;

				_lbAdd = _control lbAdd format ["%1   %2",Name _vehicle,gettext (_cfg >> "displayName")];
				_control lbSetData [_lbAdd, str _vehicle];
			} foreach _UnitList;

			//(_display displayctrl 2013) call BCE_fnc_IPMarkers;
			//- Memory
			for "_i" from 0 to ((lbsize _control) - 1) do {
				if ((_control lbdata _i) == str _selected) exitwith {
					_control lbSetCurSel _i;
				};
			};

			//-Widgets
			if (uinamespace getVariable ['BCE_Terminal_WP',true]) then {
				(_display displayctrl 1606) ctrlSetTextColor [1, 1, 1, 1];
			} else {
				(_display displayctrl 1606) ctrlSetTextColor [1, 0, 0, 0.5];
			};
			if (uinamespace getVariable ['BCE_Terminal_Veh',true]) then {
				(_display displayctrl 1607) ctrlSetTextColor [1, 1, 1, 1];
			} else {
				(_display displayctrl 1607) ctrlSetTextColor [1, 0, 0, 0.5];
			};
			if (uinamespace getVariable ['BCE_Terminal_Targeting',true]) then {
				(_display displayctrl 1608) ctrlSetTextColor [1, 1, 1, 1];
			} else {
				(_display displayctrl 1608) ctrlSetTextColor [1, 0, 0, 0.5];
			};
			if (uinamespace getVariable ['BCE_Terminal_SelColor',true]) then {
				(_display displayctrl 1609) ctrlSetTextColor [1,1,0.3,0.8];
			} else {
				(_display displayctrl 1609) ctrlSetTextColor [0,1,0.3,0.8];
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
		_control ctrladdeventhandler ["ButtonClick",_fnc_onButtonClick_Connect];
		_control = _display displayctrl 1601;
		_control ctrlAddEventHandler ["ButtonClick",{
			private _vehicle = player getVariable ["TGP_View_Selected_Vehicle",objNull];
			if !(_vehicle isEqualTo objNull) then {
			  [_vehicle,cameraview] call BCE_fnc_onButtonClick_Gunner;
				_vehicle call BCE_fnc_TGP_Select_Confirm;
			};
		}];
		_control = _display displayctrl 1602;
		_control ctrladdeventhandler ["ButtonClick",_fnc_onButtonClick_Switch];

		//Switch to driver/gunner after click on PIP (picture doesn't have buttonClick event, using MouseButtonUp instead).
		_control = _display displayctrl IDC_IGUI_AVT_PIP1;
		_control ctrladdeventhandler ["MouseButtonUp","with uinamespace do {['pipClicked',_this,''] call RscDisplayAVTerminal_script};"];
		_control = _display displayctrl IDC_IGUI_AVT_PIP2;
		_control ctrladdeventhandler ["MouseButtonUp","with uinamespace do {['pipClicked',_this,''] call RscDisplayAVTerminal_script};"];

		//-Draw vehicle Icons
		/* private _map = _display displayCtrl 51;
		private _Map_color = getArray (configfile >> 'RscMapControl' >> 'colorBackground');
		_EHid = _map ctrlAddEventHandler ["Draw", {
			call BCE_fnc_TAC_Map;
		}]; */

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
