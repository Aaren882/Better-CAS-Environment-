TGP_View_Unit_List apply {
  _unit = _x;
  _unitPos = getPos _unit;

  _unit_side_own = side (group _player);
  _unit_side = side (group _unit);

  if ([objNull, "VIEW"] checkVisibility [getPosASL _cam, AGLToASL _unitPos] > 0.5) then {
    if ((_unit_side_own == _unit_side) && (_player getVariable ["TGP_view_Unit_Tracker",true]) && _friendlyActive) then {
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
      _visionmode = if ((_player getVariable ["TGP_View_EHs", -1]) != -1) then {
        _player getVariable ["TGP_View_Optic_Mode", 2];
      } else {
        if (count (allTurrets _vehicle) > 0) then {
          (_vehicle currentVisionMode (_vehicle unitTurret _player)) # 0;
        } else {
          currentVisionMode _vehicle;
        };
      };

      _condition = if (isclass(configFile >> "CfgPatches" >> "A3TI")) then {
        if ((_player getVariable ["TGP_View_EHs", -1]) != -1) then {
          (
            (_player getVariable ["TGP_view_Unit_Tracker_Box",true]) &&
            (
              (
                (
                  (_visionmode != 2) && (_visionmode != 3)
                ) or
                  !(isnil{call A3TI_fnc_getA3TIVision})// && (_visionmode != 3)
              )
            )
          )
        } else {
          (
            (_player getVariable ["TGP_view_Unit_Tracker_Box",true]) &&
            (
              (
                (
                  ((_visionmode != 0) && (_visionmode != 1))
                ) or
                  !(isnil{call A3TI_fnc_getA3TIVision})// && (_visionmode != 1)
              )
            )
          )
        };
      } else {
        if ((_player getVariable ["TGP_View_EHs", -1]) != -1) then {
          (
            (_player getVariable ["TGP_view_Unit_Tracker_Box",true]) &&
            (
              ((_visionmode != 2) && (_visionmode != 3))
            )
          )
        } else {
          (
            (_player getVariable ["TGP_view_Unit_Tracker_Box",true]) &&
            (
              ((_visionmode != 0) && (_visionmode != 1))
            )
          )
        };
      };
      if (_condition && _boxActive) then {
        _UnitBbox = boundingbox _unit;
        _UnitBboxZ = (abs((_UnitBbox # 0) # 2) + abs((_UnitBbox # 1) # 2)) / 2;

        _UnitSize =
          abs((_UnitBbox # 0) # 0) + abs((_UnitBbox # 1) # 0)
          max
          abs((_UnitBbox # 0) # 1) + abs((_UnitBbox # 1) # 1)
          max
          abs((_UnitBbox # 0) # 2) + abs((_UnitBbox # 1) # 2);

        _UnitDis = (_cam distance _unit) / 100;

        //_Size = (_UnitSize / _UnitDis) max 1;
        private _Size = 0.3 max ((_UnitSize / _UnitDis * (call BCE_fnc_trueZoom) * 1.5) min (_UnitSize * _UnitDis * (call BCE_fnc_trueZoom) * 1.5));

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
};
