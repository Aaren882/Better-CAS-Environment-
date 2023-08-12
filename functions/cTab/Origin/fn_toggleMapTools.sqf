params ["_displayName",["_id","mapTools"]];

_currentMapTools = [_displayName,_id] call cTab_fnc_getSettings;
_newMapTools = !_currentMapTools;
[_displayName,[[_id,_newMapTools]]] call cTab_fnc_setSettings;
_newMapTools
