BCE_LandMarks apply {
  _x params ["_tex","_color","_pos","_text","_size"];
  private _obj = [cameraon,TGP_View_Camera # 0] select ((player getVariable ["TGP_View_EHs", -1]) != -1);
  if ((_obj distance _pos) <= (viewDistance - 1000)) then {
    drawIcon3D [
      _tex,
      _color,
      _pos,
      0.8,
      0.8,
      0,
      _text,
      2,
      _size,
      "PuristaMedium",
      "center",
      false
    ];
  };
};
