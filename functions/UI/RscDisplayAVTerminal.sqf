#include "\A3\ui_f\hpp\defineResincl.inc"
#include "\A3\ui_f\hpp\defineResinclDesign.inc"

params["_mode","_params","_class"];

_fnc_onLBSelChanged = {
	params ["_ctrlValue", "_selectedIndex", "_lbSelection"];

	_display = ctrlParent _ctrlValue;
	_Selected = player getvariable ["TGP_View_Selected_Vehicle",objNull];

	_vehicle_str = _ctrlValue lbdata _selectedIndex;

	if (_vehicle_str == "") exitwith {
		[1501,1502,1503,1504,1505,1506,1507] apply {
			(_display displayCtrl _x) ctrlSetText "-";
		};
		player setVariable ["TGP_View_Selected_Vehicle",objNull];
		player setVariable ["TGP_View_Selected_Optic",[],true];
		(_display displayctrl 1600) ctrlEnable false;
		(_display displayctrl 1602) ctrlEnable false;
	};
	(_display displayctrl 1600) ctrlEnable true;
	(_display displayctrl 1602) ctrlEnable true;

	_vehicle = (vehicles Select {!(_x getVariable "TGP_View_Available_Optics" isEqualTo []) && (isEngineOn _x)}) apply {
		if (_vehicle_str  == str _x) exitwith {_x};
	};

	_Optic_LODs = _vehicle getVariable ["TGP_View_Available_Optics",[]];

	if (player getVariable ["TGP_View_Selected_Optic",[]] isEqualTo []) then {
	  player setVariable ["TGP_View_Selected_Optic",[(_Optic_LODs # 0),_vehicle],true];
	};

	if !(_vehicle isEqualTo ((player getVariable "TGP_View_Selected_Optic") # 1)) then {
	  player setVariable ["TGP_View_Selected_Optic",[(_Optic_LODs # 0),_vehicle],true];
	};

	//-Create Directional object
	call BCE_fnc_createTurret_DirObject;

	[{
		params ["_display","_ctrlValue","_Selected","_vehicle_New"];

		_vehicle = player getvariable ["TGP_View_Selected_Vehicle",objNull];

		if (!(_vehicle isEqualTo objNull) or (ctrlShown (_display displayCtrl 1700))) then {
			_pilot = if ((driver _vehicle) isEqualTo objNull) then {
				"-"
			} else {
				name (driver _vehicle)
			};

			_Selected_Optic = player getVariable "TGP_View_Selected_Optic";
			_current_turret = (_Selected_Optic # 0) # 1;

			_turret_Unit = _vehicle turretUnit _current_turret;
			_gunner = if (_turret_Unit isEqualTo objNull) then {
				"-"
			} else {
				name _turret_Unit
			};

			// - Disable Unavailable Turret
			if (
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
				_weapon = if (_current_turret isEqualTo []) then {
					if (getText (configFile >> "CfgWeapons" >> currentWeapon _vehicle >> "DisplayName") != "") then {
					  format ["%1", getText (configFile >> "CfgWeapons" >> currentWeapon _vehicle >> "DisplayName")]
					} else {
						"-"
					};
				} else {
					if (getText (configFile >> "CfgWeapons" >> _vehicle currentWeaponTurret _current_turret >> "DisplayName") != "") then {
					  format ["%1", getText (configFile >> "CfgWeapons" >> _vehicle currentWeaponTurret _current_turret >> "DisplayName")]
					} else {
						"-"
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

		//-Reset Directional Object
		private _dir_object = missionNamespace getVariable ["BCE_Directional_object_AV",objNull];
		if !(_dir_object isEqualTo objNull) then {
			_dir_object attachTo [_vehicle, [0,100,0],_turret_select # 0,true];
		};

		//UI
		_turret_Unit = _vehicle turretUnit _turret_select # 1;

		_gunner = if (_turret_Unit isEqualTo objNull) then {
			"None"
		} else {
			name _turret_Unit
		};
		((uiNameSpace getVariable "BCE_TGP") displayCtrl 1029) ctrlSetText (format ["Gunner: %1", _gunner]);
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
			_ctrlHintGroup ctrlshow false;
			_ctrlHintGroup ctrlenable false;
			(_display displayctrl 1600) ctrlEnable false;
			(_display displayctrl 1601) ctrlEnable false;
			(_display displayctrl 1602) ctrlEnable false;
			("RscAdvancedHint" call bis_fnc_rsclayer) cuttext ["","plain"];

			_control = _display displayctrl 1700;
			_control ctrladdeventhandler ["LBSelChanged",_fnc_onLBSelChanged];

			_selected = player getvariable ["TGP_View_Selected_Vehicle",objNull];

			_BluFriendly = [playerSide, West] call BIS_fnc_sideIsFriendly;
			_RedFriendly = [playerSide, east] call BIS_fnc_sideIsFriendly;
			_GreFriendly = [playerSide, resistance] call BIS_fnc_sideIsFriendly;

			_UnitList = vehicles Select {
			  !(_x getVariable "TGP_View_Available_Optics" isEqualTo []) && (isEngineOn _x)
			};

			{
			  _vehicle = _x;
			  _class = typeOf _vehicle;
			  _cfg = configfile >> "cfgvehicles" >> _class;
			  _vehicleSide = side _vehicle;

			  _west = if (_BluFriendly) then {_vehicleSide == West} else {false};
			  _east = if (_RedFriendly) then {_vehicleSide == east} else {false};
			  _green = if (_GreFriendly) then {_vehicleSide == resistance} else {false};

			  if (_west or _east or _green) then {
			    _lbAdd = _control lbAdd format ["%1   %2",Name _vehicle,gettext (_cfg >> "displayName")];
			    _control lbSetData [_lbAdd, str _vehicle];
			  };
			} foreach _UnitList;

			//- Memory
			for "_i" from 0 to ((lbsize _control) - 1) do {
				if ((_control lbdata _i) == str _selected) exitwith {
					_control lbSetCurSel _i;
				};
			};
		};

		//-Turret Control UI
		if (missionNamespace getVariable ["TGP_View_Terminal_canUseTurre",false]) then {
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
		_control ctrladdeventhandler ["ButtonClick",{
			private _vehicle = player getVariable ["TGP_View_Selected_Vehicle",objNull];
			if !(_vehicle isEqualTo objNull) then {
				_cameraview = cameraview;
			  [_vehicle,_cameraview] call BCE_fnc_onButtonClick_Gunner;
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

		//-Create Directional object
		call BCE_fnc_createTurret_DirObject;

		//-Draw vehicle Icons
		private _map = _display displayCtrl 51;
		private _Map_color = getArray (configfile >> 'RscMapControl' >> 'colorBackground');
		_map ctrlAddEventHandler ["Draw", {
			call BCE_fnc_TAC_Map;
		}];

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
