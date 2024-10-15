params ["_page","_curLine"];
private _setting = ["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings;
_setting set [0,_page];

if !(isnil{_curLine}) then {
  _setting set [2,_curLine];
};

["cTab_Android_dlg",[["showMenu",_setting]],true,true] call cTab_fnc_setSettings;