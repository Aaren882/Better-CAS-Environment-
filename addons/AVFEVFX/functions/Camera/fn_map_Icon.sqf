allMapMarkers apply {
  private _Channel = markerChannel _x;
  private _class = getMarkerType _x;
  private _path = configFile >> "CfgMarkers" >> _class;

  //-Exclude Polylines
  if (
      (getNumber(_path >> "Size") != 0) &&
      ("ICON" == MarkerShape _x) &&
      (
        [_Channel < 0, _Channel > -1] select isMultiplayer
      )
    ) then {

    //-Color
    private _color = (getArray (configFile >> "CfgMarkerColors" >> (markerColor _x) >> "Color")) apply {
      if (_x isEqualType "") then {
        call compile _x
      } else {
        _x
      };
    };

    drawIcon3D [
      getText (_path >> "icon"),
      _color,
      getMarkerPos _x,
      1,
      1,
      0,
      markerText _x,
      1,
      0.04,
      "PuristaMedium",
      "",
      false
    ];
  };
};
