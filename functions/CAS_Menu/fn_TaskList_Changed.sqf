params ["_control", "_curLine","_IDCs",["_type_changed",false]];

_display = ctrlParent _control;
_curType = uiNameSpace getVariable ["BCE_Current_TaskType",0];

_title = _display displayCtrl (17000 + 2003);
_title ctrlSetText (_control lbtext _curLine);
_titlePOS = ctrlPosition _title;

//-Task Expressions
_shownCtrls = [_display,_curLine,1,_type_changed] call BCE_fnc_Show_CurTaskCtrls;

// - ["_9line","_5line"]
_TaskList = _display displayCtrl (_IDCs # _curType);

_taskVar = switch _curType do {
  //-5 line
  case 1: {
    call BCE_fnc_cTab_5_TaskChanged;
    uiNamespace getVariable ["BCE_CAS_5Line_Var", [["NA",0],["NA","",[],[0,0],""],["NA","111222"],["NA","--",""],["NA",-1,[]]]];
  };
  //-9 line
  default {
    call BCE_fnc_cTab_9_TaskChanged;
    uiNamespace getVariable ["BCE_CAS_9Line_Var", [["NA",0],["NA","",[],[0,0]],["NA",180],["NA",200],["NA",15],["NA","desc"],["NA","",[],[0,0],[]],["NA","1111"],["NA","",[],[0,0],""],["NA",0,[],nil,nil],["NA",-1,[]]]];
  };
};

//-Write down Description
_description = _display displayctrl (17000 + 2004);
_description ctrlSetStructuredText parseText (_Tasklist lbdata _curLine);
