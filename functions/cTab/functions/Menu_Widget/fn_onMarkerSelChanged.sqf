params ["_ctrl","_lbCurSel",["_index", 2]];

private _displayName = cTabIfOpen # 1;
private _toggle = [_displayName,"MarkerWidget"] call cTab_fnc_getSettings;
if (_index == 2) then {
  private _t = _toggle # 2;
  _t set [_toggle # 4,_lbCurSel];
  _lbCurSel = _t;
};

_toggle set [_index, _lbCurSel];
[_displayName,[["MarkerWidget",_toggle]],false,true] call cTab_fnc_setSettings;