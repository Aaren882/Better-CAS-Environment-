params ["_control",["_Veh_Changed",false]];

_display = ctrlparent _control;
_description = _display displayctrl 2004;
_Task_Type = _display displayCtrl 2107;

_sel_TaskType = _Task_Type lbValue (lbCurSel _Task_Type);
_list_result = switch _sel_TaskType do {
  //-5 line
  case 1: {
    _TaskList = _display displayCtrl 2005;
    _default = [["NA",0],["NA","",[],[0,0],""],["NA","111222"],["NA","--",""],["NA",[]]];
    _taskVar = uiNamespace getVariable ["BCE_CAS_5Line_Var", _default];
    [_TaskList,_taskVar]
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

_curLine = if ((_Veh_Changed) && (_sel_TaskType == 0)) then {
  10
} else {
  lbCurSel _taskList
};

//-check current Controls
_Expression_class = "true" configClasses (configFile >> "RscDisplayAVTerminal" >> "controls" >> ctrlClassName _TaskList >>"items");

_Expression_TextR = _Expression_class apply {
  getText (_x >> "textRight")
};

_Expression_Ctrls = (_Expression_class apply {
    getArray (_x >> "Expression_idc")
  }) apply {
  if !(_x isEqualTo []) then {
    _x apply {
      _display displayctrl _x
    };
  } else {
    []
  };
};

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
