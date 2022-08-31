{
  _unit = _x;
  _unitPos = getPos _unit;

  _unit_side_own = side (group player);
  _unit_side = side (group _unit);

  if ([objNull, "VIEW"] checkVisibility [getPosASL _cam, AGLToASL _unitPos] > 0.5) then {
    if ((_unit_side_own == _unit_side) && (player getVariable ["TGP_view_Unit_Tracker",true])) then {
      _unit_texture = if (isFormationLeader _unit) then {
        "\a3\ui_f\data\Map\Markers\NATO\b_unknown.paa"
      } else {
        "\a3\ui_f\data\Map\Markers\Military\dot_CA.paa"
      };

      drawIcon3D [
        _unit_texture,
        [0,68,255,0.6],
        _unitPos vectoradd [0,0,1],
        0.5,
        0.5,
        0,
        name _unit,
        1.5,
        0.03,
        "PuristaMedium",
        "",
        false
      ];
    } else {
      _visionmode = player getVariable ["TGP_View_Optic_Mode", 2];
      if ((player getVariable ["TGP_view_Unit_Tracker_Box",true]) && ((_visionmode != 2) && (_visionmode != 5))) then {
        _UnitBbox = boundingbox _unit;
        _UnitBboxZ = (abs((_UnitBbox # 0) # 2) + abs((_UnitBbox # 1) # 2)) / 2;

        _UnitSize =
          abs((_UnitBbox # 0) # 0) + abs((_UnitBbox # 1) # 0)
          max
          abs((_UnitBbox # 0) # 1) + abs((_UnitBbox # 1) # 1)
          max
          abs((_UnitBbox # 0) # 2) + abs((_UnitBbox # 1) # 2);

        _UnitDis = _cam distance _unit;

        private _Size = (_UnitSize / _UnitDis) max 1;

        drawIcon3D
        [
          "\a3\ui_f\data\IGUI\Cfg\Cursors\known_target_ca.paa",
          [1,1,1,0.3],
          _unitPos vectoradd [0,0,0.8],
          _Size * 3/4,
          _Size,
          0,
          "",
          1,
          0.05
        ];
      };
    };
  };
} forEach TGP_View_Unit_List;
