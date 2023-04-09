params ["_control"];

_display = ctrlParent _control;
_Task_Type = _display displayCtrl 2107;

_sel_TaskType = _Task_Type lbValue (lbCurSel _Task_Type);
_list_result = switch _sel_TaskType do {
  //-5 line
  case 1: {
    _TaskList = _display displayCtrl 2005;
    _taskVar = uiNamespace getVariable ["BCE_CAS_5Line_Var", [["NA",0],["NA","",[],[0,0],""],["NA","111222"],["NA","--",""],["NA",-1,[]]]];
    [_TaskList,_taskVar]
  };
  //-9 line
  default {
    _TaskList = _display displayCtrl 2002;
    _taskVar = uiNamespace getVariable ["BCE_CAS_9Line_Var", [["NA",0],["NA","",[],[0,0]],["NA",180],["NA",200],["NA",15],["NA","desc"],["NA","",[],[0,0],[]],["NA","1111"],["NA","",[],[0,0],""],["NA",0,[],nil,nil],["NA",-1,[]]]];
    [_TaskList,_taskVar]
  };
};
_list_result params ["_TaskList","_taskVar"];
_curLine = lbCurSel _taskList;
_vehicle = player getVariable ['TGP_View_Selected_Vehicle',objNull];

//-Send Data
if (ctrlshown _TaskList) exitWith {
  call BCE_fnc_SendTaskData;
};

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

switch _sel_TaskType do {
  //-5 line
  case 1: {
    call BCE_fnc_DataReceive5line;
  };
  //-9 line
  default {
    call BCE_fnc_DataReceive9line;
  };
};
