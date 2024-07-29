(["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings) params ["_page","_show","_line"];


//- "_line" ("0": Message List) ("1": Contactors)
_line = [0,1] select (_line < 1);
['cTab_Android_dlg',[['showMenu',[_page,true,_line]]]] call cTab_fnc_setSettings;