params ["_control", "_curLine","_IDCs","_IDC_offset",["_type_changed",false]];

_display = ctrlParent _control;
_curType = uiNameSpace getVariable ["BCE_Current_TaskType",0];

_title = _display displayCtrl (_IDC_offset + 2003);
_abort = _display displayCtrl (_IDC_offset + 21050);

_titlePOS = ctrlPosition _title;
_title ctrlSetText (_control lbtext _curLine);

//-Task Expressions
_shownCtrls = [_display,_curLine,1,_type_changed] call BCE_fnc_Show_CurTaskCtrls;

// - ["_9line","_5line"]
_TaskList = _display displayCtrl (_IDCs # _curType);
_taskVar = switch _curType do {
  //-5 line
  case 1: {
    _taskVar = uiNamespace getVariable ["BCE_CAS_5Line_Var", [["NA",0],["NA","",[],[0,0],""],["NA","111222"],["NA","--",""],["NA",-1,[]]]];
    call BCE_fnc_cTab_5_TaskChanged;
    _taskVar
  };
  //-9 line
  default {
    _taskVar = uiNamespace getVariable ["BCE_CAS_9Line_Var", [["NA",0],["NA","",[],[0,0]],["NA",180],["NA",200],["NA",15],["NA","--"],["NA","",[],[0,0],[]],["NA","1111"],["NA","",[],[0,0],""],["NA",0,[],nil,nil],["NA",-1,[]]]];
    call BCE_fnc_cTab_9_TaskChanged;
    _taskVar
  };
};

//-Write down Description
_description = _display displayctrl (_IDC_offset + 2004);
_description ctrlSetStructuredText parseText ((_TaskList lbData _curLine) call BCE_fnc_formatLanguage);

//-hide "Clear" + "Abort Mission" + "Enter" buttons
{(_display displayCtrl (_IDC_offset + _x)) ctrlshow (count _shownCtrls > 0)} forEach [2106,21050,21051];
(_display displayCtrl (_IDC_offset + 2106)) ctrlSetBackgroundColor ([[1,0,0,0.5],[0,0,0,0.8]] select ((_taskVar # _curLine # 0) == "NA"));
