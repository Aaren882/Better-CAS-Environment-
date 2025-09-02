(["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings) params ["_page","","",["_PgComponents",createHashMap]];

private _data = _PgComponents getorDefault [_page, []];
private _line = _data param [0, 0];

//- "_line" ("0": Main-Menu) ("1": Sub-Menu)
_line = [0,1] select (_line < 1);
[nil,_page,_line,true] call BCE_fnc_ATAK_ChangeTool;