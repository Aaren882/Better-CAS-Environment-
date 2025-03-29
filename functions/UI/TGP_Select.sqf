#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"
#include "\A3\ui_f\hpp\defineCommonGrids.inc"

params ["_mode", "_params"];

//-Fix for using UI part (or local variable cant be defined)
_fnc_onConfirm = {
	params ["_ctrl"];

	_display = ctrlParent _ctrl;
	_ctrlValue = _display displayctrl IDC_RSCATTRIBUTECAS_VALUE;
	_vehicle = objNull;

	_vehicle_str = _ctrlValue lnbdata [lnbcurselrow _ctrlValue,0];
	{
		if (_vehicle_str == str _x) exitWith {_vehicle = _x};
	} count (call BCE_fnc_getCompatibleAVs);
	if !(isnull _vehicle) then {
		_Selected_Optic = player getVariable ["TGP_View_Selected_Optic",[[],objNull]];

		//-Setup Connected Turret
		if (((player getVariable ["TGP_View_Selected_Optic",[]]) isEqualTo []) || (_vehicle isNotEqualTo (_Selected_Optic # 1))) then {
			private _Optic_LODs = [_vehicle,0] call BCE_fnc_Check_Optics;
			player setVariable ["TGP_View_Selected_Optic",[(_Optic_LODs # 0),_vehicle],true];
		};

		[_vehicle] call BCE_fnc_set_TaskCurUnit;
		_vehicle call BCE_fnc_TGP_Select_Confirm;
	};
};
//-Init
_display = _params # 0;
_ctrlValue = _display displayctrl IDC_RSCATTRIBUTECAS_VALUE;

_UnitList = call BCE_fnc_getCompatibleAVs;

switch _mode do {
	case "onLoad": {
		_ctrlValue ctrlsetfontheight GUI_GRID_H;
		_selected = [] call BCE_fnc_get_TaskCurUnit;

		_ctrlButtonOK = _display displayCtrl 1;
		_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];

		{
			private ["_vehicle","_cfg","_lnbAdd"];
			_vehicle = _x;
			_cfg = configOf _vehicle;

			_lnbAdd = if (_selected isEqualTo _vehicle) then {
				_ctrlValue lnbaddrow ["","",format ["* %1		 %2",Name _vehicle,gettext (_cfg >> "displayName")]];
			} else {
				_ctrlValue lnbaddrow ["","",format ["%1		 %2",Name _vehicle,gettext (_cfg >> "displayName")]];
			};
			_ctrlValue lnbsetdata [[_lnbAdd,0],str _vehicle];
			_ctrlValue lnbsetpicture [[_lnbAdd,0],gettext (configfile >> "cfgfactionclasses" >> gettext (_cfg >> "faction") >> "icon")];
			_ctrlValue lnbsetpicture [[_lnbAdd,1],gettext (_cfg >> "picture")];
		} foreach _UnitList;

		_ctrlValue lnbsort [2,false];

		for "_i" from 0 to ((lnbsize _ctrlValue # 0) - 1) do {
			if ((_ctrlValue lnbdata [_i,0]) == "") exitwith {_ctrlValue lnbsetcurselrow _i;};
		};
		if (lnbcurselrow _ctrlValue < 0) then {
			_ctrlValue lnbsetcurselrow 0;
		};
	};
	case "onUnload": {
		if (!isnil "RscAttributePostProcess_default") then {
			[nil,0,false] call bis_fnc_setPPeffectTemplate;
		};
		RscAttributePostProcess_default = nil;
	};
};
