(["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings) params ["_page","","_line"];

//- "_line" ("0": Main-Menu) ("1": Sub-Menu)
_line = [0,1] select (_line < 1);
[_page,_line] call BCE_fnc_ATAK_ChangeTool;