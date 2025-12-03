(["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings) params ["_page","","",["_PgComponents",createHashMap]];

private _data = _PgComponents getorDefault [_page, []];
private _line = _data param [0, 0];

//- "_line" ("0": Main-Menu) ("1": Sub-Menu)
_line = parseNumber (_line < 1); //- parseNumber BOOL -> 0/1
[nil,_page,_line,true] call BCE_fnc_ATAK_ChangeTool;
