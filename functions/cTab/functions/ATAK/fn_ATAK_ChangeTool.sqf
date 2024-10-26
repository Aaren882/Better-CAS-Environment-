params [["_ctrl",controlNull],"_page","_curLine"];


private _displayName = "cTab_Android_dlg";
private _setting = [_displayName, "showMenu"] call cTab_fnc_getSettings;
_setting set [0,_page];

if !(isnil{_curLine}) then {
  _setting set [2,_curLine];
};

//- Pass POS for Animation Tramsformation
  if (!isNull _ctrl && 1 > _setting # 2) then {
    private _display = ctrlParent _ctrl;
    private _background = _display displayCtrl 4660;
    _background setVariable ["Anim_SwitchTool", true];
  };

//- UpdateInterface
  [_displayName,[["showMenu",_setting]],true,true] call cTab_fnc_setSettings;