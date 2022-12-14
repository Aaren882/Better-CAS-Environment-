{
  _x params ["_letter", "_color", "_offset1", "_offset2"];

  _FOV = round (call BCE_fnc_trueZoom * 10) / 10;
  _FOV_POS = [0,0,15];

  if (_FOV >= 2) then {
    _FOV_POS = [0,0,30];
  };
  if (_FOV >= 5) then {
    _FOV_POS = [0,0,80];
  };
  if (_FOV >= 10) then {
    _FOV_POS = [0,0,120];
  };
  if (_FOV >= 20) then {
    _FOV_POS = [0,0,150];
  };

  _center = positionCameraToWorld _FOV_POS;

  //AGL
  _POS1 = _center vectorAdd _offset1;
  _POS2 = _center vectorAdd _offset2;

  //AGL
  _AGL_POS1 = _POS1 # 2;
  _AGL_POS2 = _POS2 # 2;

  //ASL
  _ASL_Center = AGLToASL _center;
  _ASL_POS1 = AGLToASL _POS1;
  _ASL_POS2 = AGLToASL _POS2;

  _Center_H = _ASL_Center # 2;
  _POS1_H = _ASL_POS1 # 2;
  _POS2_H = _ASL_POS2 # 2;

  //POS1
  _POS1_ANS = _Center_H - _POS1_H;

  //POS2
  _POS2_ANS = _Center_H - _POS2_H;

  //////////////Final Z(Vector)////////////////
  _POS1_FZ = _AGL_POS1 + _POS1_ANS;
  _POS2_FZ = _AGL_POS2 + _POS2_ANS;


  drawIcon3D [
    "",
    _color,
    [_POS1 # 0, _POS1 # 1,_POS1_FZ],
    0,
    0,
    0,
    _letter,
    2,
    0.05,
    "PuristaMedium"
  ];
  drawIcon3D [
    "",
    _color,
    [_POS2 # 0, _POS2 # 1,_POS2_FZ],
    0,
    0,
    0,
    ".",
    2,
    0.05,
    "PuristaMedium"
  ];
} count [
  ["N",[1,0,0,0.7],[0,1,0],[0,0.5,0]],
  ["S",[1,1,1,0.5],[0,-1,0],[0,-0.5,0]],
  ["E",[1,1,1,0.5],[1,0,0],[0.5,0,0]],
  ["W",[1,1,1,0.5],[-1,0,0],[-0.5,0,0]]
];
