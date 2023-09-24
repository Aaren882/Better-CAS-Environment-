params ["_combo"];

lbclear _combo;
private _index = _combo lbAdd (localize "STR_BCE_SelectMarker");
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
    private ["_text","_color_c","_color","_index"];
    _text = markerText _x;
    _color_c = markerColor _x;

    //-Color
    _color = (getArray (configFile >> "CfgMarkerColors" >> _color_c >> "Color")) apply {
      if (_x isEqualType "") then {
        call compile _x
      } else {
        _x
      };
    };

    //-Set Control Contents
    _text = [_text, "N/A"] select (_text == "");
    _index = _combo lbAdd _text;
    _combo lbSetData [_index, str (getMarkerPos _x)];

    _combo lbSetPicture [_index, getText (_path >> "icon")];
    _combo lbSetPictureColor [_index, _color];
  };
} foreach allMapMarkers;
