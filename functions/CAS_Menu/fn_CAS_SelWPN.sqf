params ["_control", "_lbCurSel",["_IDC_offset",0]];

_deisplay = ctrlParent _control;
_ctrlMode = _deisplay displayCtrl (_IDC_offset + 2021);
_ctrlCount = _deisplay displayCtrl (_IDC_offset + 2023);
lbClear _ctrlMode;

_data = call compile (_control lbdata _lbCurSel);
_data params ["_WeapName","_class","_modes","_turret","_Count","_muzzle"];

_ctrlCount ctrlShow !((_class isKindOf ["CannonCore", configFile >> "CfgWeapons"]) or (_class isKindOf ["MGunCore", configFile >> "CfgWeapons"]));

//-Modes Combo List
_modes apply {
	private ["_weapon_name","_mode_name","_mode","_index"];
	_weapon_name = getText (configFile >> "CfgWeapons" >> _class >> "displayName");
	_mode_name = getText (configFile >> "CfgWeapons" >> _class >> _x >> "displayName");
	_mode = if ((count _modes > 1) && (_x != "this") && (_mode_name != _weapon_name)) then {
		[_mode_name,_x] select (_mode_name == "");
	} else {
		localize "STR_BCE_Default"
	};

	//-Add LB
	_index = _ctrlMode lbAdd _mode;
	_ctrlMode lbSetData [_index, str [_WeapName,_mode,_class,_x,_turret,_Count,_muzzle]];
};

_ctrlMode lbSetCurSel 0;
