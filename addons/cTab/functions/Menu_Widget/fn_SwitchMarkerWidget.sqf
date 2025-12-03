params ["_displayName"];

_toggle = [_displayName,"MarkerWidget"] call cTab_fnc_getSettings;

_toggle set [4, parseNumber ((_toggle # 4) == 0)]; //- parseNumber BOOL -> 0/1
[_displayName,[["MarkerWidget",_toggle]],true,true] call cTab_fnc_setSettings;
_toggle
