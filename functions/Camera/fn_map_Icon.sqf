{
  _ColorWEST = [0,0.3,0.6,1];
  _ColorEAST = [0.5,0,0,1];
  _ColorGUER = [0,0.5,0,1];
  _ColorCIV = [0.4,0,0.5,1];
  _ColorUNKNOWN = [0.7,0.6,0,1];

  _Marker = _x;
  _markerPOS = getMarkerPos _Marker;
  _markerColorRaw = MarkerColor _Marker;
  _markerType = getMarkerType _Marker;
  _markerText = markerText _Marker;
  _markerIcon = getText (configFile >> "CfgMarkers" >> _markerType >> "icon");
  _markerColor = getArray (configFile >> "CfgMarkerColors" >> _markerColorRaw >> "Color");

  if (_markerColor isEqualTo []) then {
    _markerColor = [1,1,1,1];
  };

  if ((_markerColorRaw == "ColorWEST") or (_markerColorRaw == "colorBLUFOR")) then {
      _markerColor = _ColorWEST;
  };
  if ((_markerColorRaw == "ColorEAST") or (_markerColorRaw == "colorOPFOR")) then {
    _markerColor = _ColorEAST;
  };
  if ((_markerColorRaw == "ColorGUER") or (_markerColorRaw == "colorIndependent")) then {
    _markerColor = _ColorGUER;
  };
  if ((_markerColorRaw == "ColorCIV") or (_markerColorRaw == "ColorCivilian")) then {
    _markerColor = _ColorCIV;
  };
  if (_markerColorRaw == "ColorUNKNOWN") then {
    _markerColor = _ColorUNKNOWN;
  };

  drawIcon3D [
    _markerIcon,
    [_markerColor # 0,_markerColor # 1,_markerColor # 2,_alpha],
    _markerPOS,
    1,
    1,
    0,
    _markerText,
    1,
    0.04,
    "PuristaMedium",
    "",
    false
  ];
} foreach allMapMarkers;
