params ["_control", "_curLine"];

_display = ctrlParent _control;
_Task_Type = _display displayCtrl 2107;
_sel_TaskType = _Task_Type lbValue (lbCurSel _Task_Type);
_list_result = switch _sel_TaskType do {
  //-5 line
  case 1: {
    _TaskList = _display displayCtrl 2005;
    _taskVar = uiNamespace getVariable ["BCE_CAS_5Line_Var", [["NA",0],["NA","",[],[0,0],""],["NA","111222"],["NA","--",""],["NA",[]]]];
    [_TaskList,_taskVar]
  };
  //-9 line
  default {
    _TaskList = _display displayCtrl 2002;
    _taskVar = uiNamespace getVariable ["BCE_CAS_9Line_Var", [["NA",0],["NA","",[],[0,0]],["NA",180],["NA",200],["NA",15],["NA","desc"],["NA","",[],[0,0],[]],["NA","1111"],["NA","",[],[0,0],""],["NA",0,[],nil,nil],["NA",[]]]];
    [_TaskList,_taskVar]
  };
};
_list_result params ["_TaskList","_taskVar"];

_title = _display displayctrl 2003;
_description = _display displayctrl 2004;
_sendData = _display displayCtrl 2105;
_clearbut = _display displayCtrl 2106;
_TaskList ctrlshow false;
_checklist = _display displayCtrl 2100;

//-Write down description
_desc = format ["Description : <br/>%1", _TaskList lbData _curLine];
_description ctrlSetStructuredText parseText _desc;
_sendData ctrlSetText "Enter";

_descriptionPOS = ctrlPosition _description;
_TaskListPOS = ctrlPosition _TaskList;
_titlePOS = ctrlPosition _title;

_title ctrlSetText (_control lbtext _curLine);

//-check current Control
_Expression_Ctrls = ("true" configClasses (
    configFile >> "RscDisplayAVTerminal" >> "controls" >> ctrlClassName _TaskList >>"items"
  ) apply {
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

//-Show Needed Controls
{_x ctrlshow true} forEach ([_title,_description] + _shownCtrls);

switch _sel_TaskType do {
  //-5 line
  case 1: {
    call BCE_fnc_DblClick5line;
  };
  //-9 line
  default {
    call BCE_fnc_DblClick9line;
  };
};
_description ctrlCommit 0;
