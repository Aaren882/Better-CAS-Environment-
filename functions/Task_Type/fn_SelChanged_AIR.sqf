//- Check if it's last line (Remarks)
private _remarks = (count _taskVar) - 1;

switch _curLine do {
  //-EGRS [Toolbox, EditBox, output, Toolbox(Azimuth), Marker(combo)]
  case 9:{
    _shownCtrls params ["_ctrl1","_ctrl2","_ctrl3","_ctrl4","_ctrl5"];

    if (_selectedIndex == 0) exitWith {
      _ctrl4 ctrlShow true;

      _ctrl2 ctrlShow false;
      _ctrl5 ctrlShow false;
    };
    if (_selectedIndex == 1) exitWith {
      _ctrl2 ctrlShow true;
      _ctrl4 ctrlShow false;
      _ctrl5 ctrlShow false;
    };
    //-Map Markers
    if (_selectedIndex == 2) exitWith {
      _ctrl5 ctrlShow true;
      _ctrl5 call BCE_fnc_IPMarkers;

      _ctrl2 ctrlShow false;
      _ctrl4 ctrlShow false;
    };
    if (_selectedIndex == 3) exitWith {
      _ctrl2 ctrlShow false;
      _ctrl4 ctrlShow false;
      _ctrl5 ctrlShow false;
    };
  };
  //-FAD/H [Toolbox, EditBox, output, Toolbox(Azimuth)]
  case _remarks:{
    _shownCtrls params ["_ctrl1","_ctrl2","_ctrl3","_ctrl4"];

    if (_selectedIndex == 0) exitWith {
      _ctrl2 ctrlShow false;
      _ctrl4 ctrlShow true;
    };
    if (_selectedIndex == 1) exitWith {
      _ctrl2 ctrlShow true;
      _ctrl4 ctrlShow false;
    };
    if (_selectedIndex == 2) exitWith {
      _ctrl2 ctrlShow false;
      _ctrl4 ctrlShow false;
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