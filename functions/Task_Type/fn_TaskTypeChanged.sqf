params ["_control", "_lbCurSel"];

_display = ctrlParent _control;
uiNameSpace setVariable ["BCE_Current_TaskType",_lbCurSel];
switch _lbCurSel do {
  case 1: {
    _TaskList = _display displayCtrl 2002;
    if (ctrlShown _TaskList) then {
      _TaskList ctrlShow false;
    };
  };
  default {
    _TaskList = _display displayCtrl 2005;
    if (ctrlShown _TaskList or ctrlEnabled _TaskList) then {
      _TaskList ctrlShow false;
    };
  };
};
