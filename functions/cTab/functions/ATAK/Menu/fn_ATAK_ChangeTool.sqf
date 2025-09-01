/*
  NAME : BCE_fnc_ATAK_ChangeTool
  
  When Click on ATAK Tools (Message, Mission...)
*/
params [["_ctrl",controlNull],"_page","_curLine",["_subList",false]];

private _displayName = "cTab_Android_dlg";
private _display = uiNamespace getVariable [_displayName,displayNull];

if (isnull _display) exitWith {};

private _setting = [_displayName, "showMenu"] call cTab_fnc_getSettings;
private _subInfos = _setting param [2,[]];

//- Check if is "BCE_fnc_ATAK_toggleSubListMenu" SUB MENU
switch (true) do {
  case _subList: {
    private _PgComponents = _setting param [3, createHashMap];
    private _PG_data = _PgComponents getOrDefault [_page, []];

    //- Update subList data
      _PG_data set [0, _curLine];
      _PgComponents set [_page, _PG_data];
      _setting set [3, _PgComponents];
  };

  //- if "_ctrl" NOT Null (Switching APP)
  case !(isnull _ctrl): {
    private _page = ctrlClassName _ctrl;
    (_page call BCE_fnc_ATAK_getAPPs_props) params ["","_function"];

    //- catch empty "Opened function" (only to APPs)
      if (_function == "") exitWith {
        ["“Opened function” of this page is not exist"] call BIS_fnc_error;
      };

    _setting set [0, _page];
  };
  
  //- Mission Lines
  case !(isnil{_curLine}): {
    //- Set Sub Infos
      _subInfos set [0,_page];
      _subInfos set [1,_curLine];

    _setting set [2, _subInfos];
  };
};

//- Pass POS for Animation Tramsformation
  if (!isNull _ctrl && 1 > (_setting # 2) param [1, -1]) then {
    private _background = _display displayCtrl 4660;
    _background setVariable ["Anim_SwitchTool", true];
  };

//- UpdateInterface
  [_displayName,[["showMenu",_setting]],true,true] call cTab_fnc_setSettings;