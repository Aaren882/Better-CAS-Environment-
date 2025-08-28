params [["_ctrl",controlNull],"_page","_curLine",["_subList",false]];

private _displayName = "cTab_Android_dlg";
private _setting = [_displayName, "showMenu"] call cTab_fnc_getSettings;

//- Check if is "BCE_fnc_ATAK_toggleSubListMenu"
if (_subList) then {
  private _PgComponents = _setting param [3, createHashMap];
  private _PG_data = _PgComponents getOrDefault [_page, []];

  //- Update subList data
    _PG_data set [0, _curLine];
    _PgComponents set [_page, _PG_data];
    _setting set [3, _PgComponents];
} else {

  //- if "_ctrl" is Null (Switching APP)
  if !(isnull _ctrl) then {
    private _page = ctrlClassName _ctrl;
    private _APPs_Map = localNamespace getVariable ["BCE_ATAK_APPs_HashMap", createHashMap];
    (_APPs_Map get _page) params ["","_function"];

    //- catch empty "Opened function" (only to APPs)
      if (_function == "") exitWith {
        ["“Opened function” of this page is not exist"] call BIS_fnc_error;
      };

    _setting set [0, _page];
  };

  if !(isnil{_curLine}) then {
    _setting set [2,[_page,_curLine]];
  };
};

//- Pass POS for Animation Tramsformation
  if (!isNull _ctrl && 1 > (_setting # 2) param [1, -1]) then {
    private _display = ctrlParent _ctrl;
    private _background = _display displayCtrl 4660;
    _background setVariable ["Anim_SwitchTool", true];
  };

//- UpdateInterface
  [_displayName,[["showMenu",_setting]],true,true] call cTab_fnc_setSettings;