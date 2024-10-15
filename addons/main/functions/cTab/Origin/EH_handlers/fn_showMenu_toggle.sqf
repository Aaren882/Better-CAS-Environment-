params ["_displayName"];
private ["_displayName","_showMenu","_showMenu"];

//-Turn off App menu
if ([_displayName,"showModeMenu"] call cTab_fnc_getSettings) then {
	[_displayName,[["showModeMenu",false]]] call cTab_fnc_setSettings;
};

_showMenu = [_displayName,"showMenu"] call cTab_fnc_getSettings;
_showMenu set [1,!(_showMenu # 1)];
[_displayName,[["showMenu",_showMenu]],true,true] call cTab_fnc_setSettings;
true
