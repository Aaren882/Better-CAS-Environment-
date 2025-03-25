switch _curLine do {
  //- Control Method  [Toolbox, EditBox, output, ETA(StructuredText)]
  case 4:{
    _shownCtrls params ["_ctrl1","_ctrl2","_ctrl3","_ctrl4"];

    call {
      if (_selectedIndex == 1) exitWith {
        _ctrl2 ctrlShow true;
      };
      _ctrl2 ctrlShow false;
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