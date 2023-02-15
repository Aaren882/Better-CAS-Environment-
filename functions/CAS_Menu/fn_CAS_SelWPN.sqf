params ["_control", "_lbCurSel"];

_deisplay = ctrlParent _control;
_ctrlMode = _deisplay displayCtrl 2021;
_ctrlCount = _deisplay displayCtrl 2023;
lbClear _ctrlMode;

_data = call compile (_control lbdata _lbCurSel);
_data params ["_WeapName","_class","_modes","_turret","_Count","_muzzle"];

if ((_class isKindOf ["CannonCore", configFile >> "CfgWeapons"]) or (_class isKindOf ["MGunCore", configFile >> "CfgWeapons"])) then {
  _ctrlCount ctrlShow false;
} else {
  _ctrlCount ctrlShow true;
};

//-Modes Combo List
{
  private _weapon_name = getText (configFile >> "CfgWeapons" >> _class >> "displayName");
  private _mode_name = getText (configFile >> "CfgWeapons" >> _class >> _x >> "displayName");
  private _mode = if ((count _modes > 1)&& (_x != "this") && (_mode_name != _weapon_name)) then {
    if (_mode_name == "") then {
      _mode = _x
    } else {
      _mode_name
    };
  } else {
    "Default"
  };

  //-Add LB
  private _index = _ctrlMode lbAdd _mode;
  _ctrlMode lbSetData [_index, str [_WeapName,_mode,_class,_x,_turret,_Count,_muzzle]];
} forEach _modes;

_ctrlMode lbSetCurSel 0;
