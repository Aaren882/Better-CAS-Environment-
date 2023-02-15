params ["_combo"];

lbclear _combo;
private _index = _combo lbAdd "Select Marker";
_combo lbSetData [_index, "[]"];

{
  private _Channel = markerChannel _x;
  private _class = getMarkerType _x;
  private _path = configFile >> "CfgMarkers" >> _class;

  private _MP_Compat = if (isMultiplayer) then {
    _Channel >= 0
    //currentChannel == _Channel
  } else {
    _Channel == -1
  };
  //-Exclude Polylines
  if (
      (getNumber(_path >> "Size") != 0) &&
      ((markerPolyline _x) isEqualTo []) &&
      (
        _MP_Compat
      )
    ) then {
    private _text = markerText _x;
    private _color_c = markerColor _x;

    //-Color
    private _color = (getArray (configFile >> "CfgMarkerColors" >> _color_c >> "Color")) apply {
      if (_x isEqualType "") then {
        call compile _x
      } else {
        _x
      };
    };

    /* allmapmarkers apply {
      (getArray (configFile >> "CfgMarkerColors" >> (markerColor _x) >> "Color")) apply {
        if (_x isEqualType "") then {
          call compile _x
        } else {
          _x
        };
      };
    }; */

    //-Set Control Contents
    _text = if (_text == "") then {"N/A"} else {_text};
    private _index = _combo lbAdd _text;
    _combo lbSetData [_index, str (getMarkerPos _x)];

    _combo lbSetPicture [_index, getText (_path >> "icon")];
    _combo lbSetPictureColor [_index, _color];
  };
} foreach allMapMarkers;
