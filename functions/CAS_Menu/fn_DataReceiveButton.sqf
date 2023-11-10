params ["_control",["_IDC_offset",0],["_updateList",false],["_overwrite",-1]];

_display = ctrlParent _control;
_button_text = ctrlText _control;
_NotAVT = _IDC_offset != 0;

_sel_TaskType = uiNameSpace getVariable ["BCE_Current_TaskType",0];
_list_result = switch _sel_TaskType do {
  //-5 line
  case 1: {
    _TaskList = _display displayCtrl (_IDC_offset + 2005);
    _taskVar = uiNamespace getVariable ["BCE_CAS_5Line_Var", [["NA",0],["NA","",[],[0,0],""],["NA","111222"],["NA","--",""],["NA",-1,[]]]];
    [_TaskList,_taskVar]
  };
  //-9 line
  default {
    _TaskList = _display displayCtrl (_IDC_offset + 2002);
    _taskVar = uiNamespace getVariable ["BCE_CAS_9Line_Var", [["NA",0],["NA","",[],[0,0]],["NA",180],["NA",200],["NA",15],["NA","--"],["NA","",[],[0,0],[]],["NA","1111"],["NA","",[],[0,0],""],["NA",0,[],nil,nil],["NA",-1,[]]]];
    [_TaskList,_taskVar]
  };
};

_list_result params ["_TaskList","_taskVar"];
_isOverwrite = _overwrite > -1;
_curLine = [lbCurSel _taskList,_overwrite] select _isOverwrite;

_vehicle = player getVariable ['TGP_View_Selected_Vehicle',objNull];

//-Send Data
if ((tolower _button_text) == localize "STR_BCE_SendData") exitWith {
  call BCE_fnc_SendTaskData;

  if !(_NotAVT) then {
    _control ctrlSetText localize "STR_BCE_Abort_Task";
  };

  //-Abort button
  (_display displayCtrl (_IDC_offset + 21050)) ctrlEnable ((_vehicle getVariable ["BCE_Task_Receiver",[]]) isNotEqualTo []);
};

//-Abort Mission
if ((localize "STR_BCE_Abort_Task") in (tolower _button_text)) exitWith {
  _vehicle setVariable ["BCE_Task_Receiver", [], true];

  //-Clear Waypoints
  _grp = group _vehicle;
  for "_i" from count waypoints _grp to 0 step -1 do {
    deleteWaypoint [_grp, _i];
  };
  _grp addWaypoint [getpos _vehicle, 0];

  //-Abort button
  switch _IDC_offset do {
    case 0: {
      _control ctrlSetText localize "STR_BCE_SendData";
    };
    case 17000: {
      (_display displayCtrl (_IDC_offset + 21050)) ctrlEnable false;
    };
  };
};

//-Task Expressions
([_display,_curLine,[0,1] select _NotAVT,false,true,true] call BCE_fnc_Show_CurTaskCtrls) params ["_shownCtrls","_TextR"];

_condition = [[],[0]] select (isNull _vehicle);

if !(_curLine in _condition) then {
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
};

//-Update List
if (_updateList) then {
  private _writeDown = (_TextR # _curLine) param [1,""];;
  _TaskList lbSetTextRight [_curLine, [_taskVar # _curLine # 0, _writeDown] select (_writeDown != "")];
};

//-Set Clear button color (except AV Terminal)
if (_NotAVT) then {
  //-cTab
  if (_IDC_offset == 17000) then {
    private _msg = switch true do {
      case (_curLine in _condition): {
        "STR_BCE_Error_InputVal"
      };
      case (_taskVar # _curLine # 0 == "NA"): {
        "STR_BCE_Error_Vehicle"
      };
    };
    if (_msg isEqualType "") then {
      ["Task_Builder",localize _msg,5] call cTab_fnc_addNotification;
    };
  };
  (_display displayCtrl (_IDC_offset + 2106)) ctrlSetBackgroundColor ([[1,0,0,0.5],[0,0,0,0.8]] select ((_taskVar # _curLine # 0) == "NA"));
};
