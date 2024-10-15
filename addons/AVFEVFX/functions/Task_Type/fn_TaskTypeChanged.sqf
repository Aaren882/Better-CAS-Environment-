params [
  "_control",
  "_lbCurSel",
  ["_IDC_offset",0]
];

_display = ctrlParent _control;
_NotAVT = _IDC_offset != 0;
_IDCs = [2002,2005] apply {_x + _IDC_offset};
_vehicle = player getVariable ["TGP_View_Selected_Vehicle",objNull];
uiNameSpace setVariable ["BCE_Current_TaskType",_lbCurSel];

// - ["_9line","_5line"]
//- Output all + hide them all
_ctrls = _IDCs apply {
  private _ctrl = _display displayctrl _x;
  _ctrl ctrlShow false;
  _ctrl
};

_TaskList = _ctrls # _lbCurSel;

// - for other mods
if (_NotAVT) then {
  [_TaskList,lbCurSel _TaskList,_IDCs,_IDC_offset,true] call BCE_fnc_TaskList_Changed;

  if (_lbCurSel == 1) then {
    _TaskList lbSetText [0, format ["1: “%1”/“%2” :", groupId group _vehicle, groupId group player]];
  };

  {
    _x ctrlshow (_TaskList isEqualTo _x);
  } forEach _ctrls;
} else {
  if (ctrlShown _TaskList) then {
    _TaskList ctrlShow false;
  };
};
