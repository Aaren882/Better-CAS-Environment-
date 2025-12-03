params ["_displayName"];
_showMenu = [_displayName,"uavInfo"] call cTab_fnc_getSettings;
[_displayName,[["uavInfo",!_showMenu]]] call cTab_fnc_setSettings;
true
