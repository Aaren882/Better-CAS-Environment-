params ["_control",["_Veh_Changed",false]];

_display = ctrlparent _control;
_config = configFile >> "RscDisplayAVTerminal" >> "controls";

_clearAction = {
  _description = _display displayctrl 2004;
  _Task_Type = _display displayCtrl 2107;

  _sel_TaskType = _Task_Type lbValue (lbCurSel _Task_Type);

  _list_result = switch _sel_TaskType do {
    //-5 line
    case 1: {
      _TaskList = _display displayCtrl 2005;
      _default = [["NA",0],["NA","",[],[0,0],""],["NA","111222"],["NA","--",""],["NA",-1,[]]];
      _taskVar = uiNamespace getVariable ["BCE_CAS_5Line_Var", _default];

      [_TaskList,_taskVar,_default]
    };
    //-9 line
    default {
      _TaskList = _display displayCtrl 2002;
      _default = [["NA",0],["NA","",[],[0,0]],["NA",180],["NA",200],["NA",15],["NA","desc"],["NA","",[],[0,0],[]],["NA","1111"],["NA","",[],[0,0],""],["NA",0,[],nil,nil],["NA",-1,[]]];
      _taskVar = uiNamespace getVariable ["BCE_CAS_9Line_Var", _default];
      [_TaskList,_taskVar,_default]
    };
  };
  _list_result params ["_TaskList","_taskVar","_default"];

  //-check current Controls
  _Expression_class = "true" configClasses (configFile >> "RscDisplayAVTerminal" >> "controls" >> ctrlClassName _TaskList >>"items");

  _Expression_TextR = _Expression_class apply {
    getText (_x >> "textRight")
  };

  _Expression_Ctrls = (_Expression_class apply {
      getArray (_x >> "Expression_idc")
    }) apply {
    [
      _x apply {_display displayctrl _x},[]
    ] select (_x isEqualTo []);
  };

  _curLine = [lbCurSel _taskList,0] select _Veh_Changed;
  _shownCtrls = _Expression_Ctrls # _curLine;

  switch _sel_TaskType do {
    //-5 line
    case 1: {
      call BCE_fnc_clearTask5line;
    };
    //-9 line
    default {
      call BCE_fnc_clearTask9line;
    };
  };
};

_MenuChanged = {
  private ["_curStateText","_desc","_code_list","_page","_lastPage","_text_list","_text"];
  _curStateText = ctrlText _control;
  _desc = _display displayCtrl 2004;
  _code_list = getArray (_config >> ctrlClassName _desc >> "Brevity_Code");
  _page = false;

  _lastPage = _curStateText == "<";

  if (_lastPage) then {
    reverse _code_list;
  };

  //filter out next page
  _text_list = _code_list apply {
    if (_x isEqualTo "-") then {
      _page = true;
    };
    [nil,_x] select _page;
  } select {!((isnil {_x}) or (_x isEqualTo "-"))};

  if (_lastPage) then {
    reverse _text_list;
    _control ctrlSetText ">";
  } else {
    _control ctrlSetText "<";
  };

  _text = _text_list apply {
    _x params [["_title",""],["_sub",""]];
    [
      format ["<t size='1.1' align='center' font='PuristaSemibold'>%1</t>",_title],
      format ["<t size='1.1' font='RobotoCondensedBold'>%1</t> : <t size='1.1' color='#FFD9D9D9'>%2</t>",_title,_sub]
    ] select (_x isEqualType []);
  };
  _desc ctrlSetStructuredText parseText (_text joinString "<br/>");
};

_ismenu = lbCurSel (_display displayCtrl 2102) == 1;

if (_ismenu) then {
  call _MenuChanged;
} else {
  call _clearAction;
};
