params ["_displayName"];

_toggle = [_displayName,"MarkerWidget"] call cTab_fnc_getSettings;

_toggle set [4, [0,1] select ((_toggle # 4) == 0)];
[_displayName,[["MarkerWidget",_toggle]],true,true] call cTab_fnc_setSettings;
_toggle