params ["_displayName"];

_Weather = [_displayName,"Weather_Condition"] call cTab_fnc_getSettings;

_Weather set [0, !(_Weather # 0)];
[_displayName,[["Weather_Condition",_Weather]],true,true] call cTab_fnc_setSettings;
_Weather
