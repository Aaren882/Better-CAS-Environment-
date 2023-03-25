params ["_control", "_selectedIndex"];

_display = ctrlParent _control;
_Task_Type = _display displayCtrl 2107;

_TaskList = switch (_Task_Type lbValue (lbCurSel _Task_Type)) do {
  //-5 line
  case 1: {_display displayCtrl 2005};
  //-9 line
  default {_display displayCtrl 2002};
};

_curLine = lbCurSel _taskList;

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

switch _curLine do {
  //-EGRS [Toolbox, EditBox, output, Toolbox(Azimuth), Marker(combo)]
  case 9:{
    _shownCtrls params ["_ctrl1","_ctrl2","_ctrl3","_ctrl4","_ctrl5"];

    if (_selectedIndex == 0) then {
      _ctrl4 ctrlShow true;

      _ctrl2 ctrlShow false;
      _ctrl5 ctrlShow false;
    } else {
      //-Map Markers
      if (_selectedIndex == 2) then {
        _ctrl5 ctrlShow true;
        _ctrl5 call BCE_fnc_IPMarkers;

        _ctrl2 ctrlShow false;
        _ctrl4 ctrlShow false;
      } else {
        if (_selectedIndex == 3) then {
          _ctrl2 ctrlShow false;
          _ctrl4 ctrlShow false;
          _ctrl5 ctrlShow false;
        } else {
          _ctrl2 ctrlShow true;
          _ctrl4 ctrlShow false;
          _ctrl5 ctrlShow false;
        };
      };
    };
  };
  //-FAD/H [Toolbox, EditBox, output, Toolbox(Azimuth)]
  case 10:{
    _shownCtrls params ["_ctrl1","_ctrl2","_ctrl3","_ctrl4"];

    if (_selectedIndex == 2) then {
      _ctrl4 ctrlShow false;
      _ctrl2 ctrlShow false;
    } else {
      //-FA D/H
      if (_selectedIndex == 0) then {
        _ctrl2 ctrlShow false;
        _ctrl4 ctrlShow true;
      } else {
        _ctrl2 ctrlShow true;
        _ctrl4 ctrlShow false;
      };
    };
  };
  default {
    if (_selectedIndex == 0) then {
      _shownCtrls params ["_toolBox","_combo"];
      _combo ctrlShow true;
      _combo call BCE_fnc_IPMarkers;
    } else {
      _shownCtrls params ["_toolBox","_combo","_textBox"];
      _combo ctrlShow false;
    };
  };
};
