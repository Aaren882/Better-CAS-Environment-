params ["_displayName","_index"];

_toggle = [_displayName,"MarkerDropper"] call cTab_fnc_getSettings;

_val = switch (_index) do {
  case 0: {
    !(_toggle # 0)
  };
  case 1: {
    private _mode = _toggle # 1;
    _mode = _mode + 1;
    if (_mode > 2) then {_mode = 0};
    _mode
  };
};
_toggle set [_index, _val];
[_displayName,[["MarkerDropper",_toggle]],true,true] call cTab_fnc_setSettings;
_toggle
