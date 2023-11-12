params ["_display","_curLine","_curInterface",["_type_changed",false],["_skip",false],["_getTextR",false]];
private ["_Info_list","_curType","_IDCs_list","_TypeCtrls","_shownCtrls","_return"];

_Info_list = switch _curInterface do {
  //-AVT
  case 0: {missionNamespace getVariable "AVT_Task_TaskItems"};
  //-cTab Rugged Tablet
  case 1: {missionNamespace getVariable "cTab_Task_TaskItems"};
};

_curType = uiNameSpace getVariable ["BCE_Current_TaskType",0];

_IDCs_list = _Info_list # 0;
_TypeCtrls = (_IDCs_list # _curType) apply {
  _x apply {_display displayctrl _x}
};

_shownCtrls = _TypeCtrls # _curLine;

if !(_skip) then {
  if (_type_changed) then {
    (flatten _IDCs_list) apply {
      (_display displayctrl _x) ctrlshow false;
    };
  } else {
    (flatten _TypeCtrls) apply {
      _x ctrlshow false;
    };
  };

  //-Show ctrls from selected task list
  _shownCtrls apply {
    _x ctrlshow true;
  };
};

_return = [
  _shownCtrls,
  [_shownCtrls,_Info_list # 1 # _curType]
] select _getTextR;

_return
