params ["_control", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];
_display = ctrlparent _control;
_ctrlCombo = _display displayctrl 2013;
_type = _display displayctrl 2012;

if ((_shift) && !(ctrlshown _ctrlCombo) && (ctrlshown _type)) then {
  private _POS = _control ctrlMapScreenToWorld [_xPos, _yPos];
  private _marker = createMarkerLocal ["BCE_ClickPOS_Marker", _POS];

  //-Marker Hint
  _marker setMarkerColorLocal "ColorYellow";
  _marker setMarkerTypeLocal "mil_end";
  _marker setMarkerPosLocal _POS;
  [{
    params ["_marker","_time"];

    _size = _time-time;
    _marker setMarkerSizeLocal [_size*0.8, _size*0.8];

    (time >= _time)
  },{
    params ["_marker","_time"];
    deleteMarkerLocal _marker;

    }, [_marker,time+1]
  ] call CBA_fnc_waitUntilAndExecute;
  uinamespace setVariable ["BCE_MAP_ClickPOS", _POS];
};
