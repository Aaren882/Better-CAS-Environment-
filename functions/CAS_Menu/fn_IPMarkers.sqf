params ["_combo"];

lbclear _combo;
private _index = _combo lbAdd "Select Marker";
_combo lbSetData [_index, "[]"];

{
  private ["_Channel","_class","_path","_MP_Compat"];
  _Channel = markerChannel _x;
  _class = getMarkerType _x;
  _path = configFile >> "CfgMarkers" >> _class;

  _MP_Compat = [_Channel == -1,_Channel >= 0] select isMultiplayer;
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
      [_x, call compile _x] select (_x isEqualType "");
    };

    //-Set Control Contents
    _text = if (_text == "") then {"N/A"} else {_text};
    private _index = _combo lbAdd _text;
    _combo lbSetData [_index, str (getMarkerPos _x)];

    _combo lbSetPicture [_index, getText (_path >> "icon")];
    _combo lbSetPictureColor [_index, _color];
  };
} foreach allMapMarkers;
