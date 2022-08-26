#include "\A3\ui_f\hpp\defineResincl.inc"
#include "\A3\ui_f\hpp\defineResinclDesign.inc"

params["_mode","_params","_class"];

_fnc_onLBSelChanged = {
	params ["_ctrlValue", "_selectedIndex"];
	_display = ctrlParent _ctrlValue;
	_Selected = player getvariable ["TGP_View_Selected_Vehicle",objNull];

	_vehicle_str = _ctrlValue lbdata _selectedIndex;

	if (_vehicle_str == "") exitwith {
		[1501,1502,1503,1504,1505,1506,1507] apply {
			(_display displayCtrl _x) ctrlSetText "-";
		};
		player setVariable ["TGP_View_Selected_Vehicle",objNull];
	};

	_vehicle = (vehicles Select {!(_x getVariable "TGP_View_Available_Optics" isEqualTo []) && (isEngineOn _x)}) apply {
		if (_vehicle_str  == str _x) exitwith {_x};
	};

	_Optic_LODs = _vehicle getVariable ["TGP_View_Available_Optics",[]];

	if (player getVariable ["TGP_View_Selected_Optic",[]] isEqualTo []) then {
	  player setVariable ["TGP_View_Selected_Optic",[(_Optic_LODs # 0),_vehicle]];
	};

	if !(_vehicle isEqualTo ((player getVariable "TGP_View_Selected_Optic") # 1)) then {
	  player setVariable ["TGP_View_Selected_Optic",[(_Optic_LODs # 0),_vehicle]];
	};

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

			(_display displayCtrl 1501) ctrlSetText _pilot;
			(_display displayCtrl 1502) ctrlSetText _gunner;

			if (_vehicle isEqualTo objNull) then {
				(_display displayCtrl 1503) ctrlSetText "-";
				(_display displayCtrl 1504) ctrlSetText "-";
				(_display displayCtrl 1505) ctrlSetText "-";
				(_display displayCtrl 1506) ctrlSetText "-";
				(_display displayCtrl 1507) ctrlSetText "-";
			} else {
				(_display displayCtrl 1503) ctrlSetText format ["%1%2",round ((fuel _vehicle) * 100) , "%"];
				(_display displayCtrl 1504) ctrlSetText format ["%1 %2",localize "$str_a3_rscdisplayartillery_artillerygridtext",mapGridPosition _vehicle];
				(_display displayCtrl 1505) ctrlSetText format ["%1°",round (getdir _vehicle)];
				(_display displayCtrl 1506) ctrlSetText format ["%1 km/h",round (speed _vehicle)];
				(_display displayCtrl 1507) ctrlSetText format ["%1 m",round ((getPosASL _vehicle) # 2)];
			};
		};

		((lbCurSel _ctrlValue < 0) or !(_vehicle_New isEqualTo _vehicle) or !(alive player))
	}, {

		}, [_display,_ctrlValue,_Selected,_vehicle]
	] call CBA_fnc_waitUntilAndExecute;

	player setVariable ["TGP_View_Selected_Vehicle",_vehicle];
};

_fnc_onButtonClick = {
	if !(player getVariable ["TGP_View_Selected_Vehicle",objNull] isEqualTo objNull) then {
		(player getVariable "TGP_View_Selected_Vehicle") call BCE_fnc_TGP_Select_Confirm;
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

		_control = _display displayctrl 1600;
		_control ctrladdeventhandler ["ButtonClick",_fnc_onButtonClick];

		//Switch to driver/gunner after click on PIP (picture doesn't have buttonClick event, using MouseButtonUp instead).
		_control = _display displayctrl IDC_IGUI_AVT_PIP1;
		_control ctrladdeventhandler ["MouseButtonUp","with uinamespace do {['pipClicked',_this,''] call RscDisplayAVTerminal_script};"];
		_control = _display displayctrl IDC_IGUI_AVT_PIP2;
		_control ctrladdeventhandler ["MouseButtonUp","with uinamespace do {['pipClicked',_this,''] call RscDisplayAVTerminal_script};"];
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
