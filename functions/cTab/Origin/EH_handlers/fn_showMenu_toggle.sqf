params ["_displayName"];
private ["_displayName","_showMenu","_showMenu"];

//- Toggle App menu
_showMenu = [_displayName,"showMenu"] call cTab_fnc_getSettings;
_showMenu set [1,!(_showMenu # 1)];
[_displayName,[["showMenu",_showMenu]],true,true] call cTab_fnc_setSettings;
true
