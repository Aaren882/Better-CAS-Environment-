params ["_ctrl"];

//- CAS
private _vehicle = vehicle cameraOn;
private _taskVar = _vehicle getVariable ["BCE_Task_Receiver",[]];
private _veh_POS = getPosASLVisual _vehicle;

//- Angle of View https://www.sr-research.com/eye-tracking-blog/background/visual-angle/
if (_vehicle isKindOf "Air") then {
  //-draw FOV for every turrets (except FFV)
  (_vehicle getVariable "TGP_View_Available_Optics") apply {
    private _turret = _x # 1;
    private _isPilot = (_turret # 0) == -1;

    //-tell what pos for the turret
    //--Get pilot cam info if vehicle is local (Faster and no Net traffic needed)
    private _FocusPos = if ((local _vehicle) && _isPilot) then {
      private _info = getPilotCameraTarget _vehicle;
      [nil,_info # 1] select (_info # 0);
    } else {
      if (_isPilot) then {
        private _var = _vehicle getVariable ["BCE_Camera_Info_Air",[false,[]]];
        [nil,_var # 1] select (_var # 0);
      } else {
        [_vehicle,_turret] call BCE_fnc_Turret_InterSurface;
      };
    };

    private _crew = _vehicle turretUnit _turret;

    //-Draw
    if (!(isnil {_FocusPos}) && !(isNull _crew)) then {
      private ["_dis","_turretName","_text"];

      _dis = _vehicle distance _FocusPos;

      _turretName = [
        getText ([_vehicle, _turret] call BIS_fnc_turretConfig >> "gunnerName"),
        localize "STR_DRIVER"
      ] select _isPilot;

      _text = trim format [
        " %1 : %2 km [%3]",
        _turretName,
        round(_dis/100) / 10,
        getText(configFile >> "CfgWeapons" >> (_vehicle currentWeaponTurret _turret) >> "DisplayName")
      ];
      [_vehicle,_ctrl,_FocusPos,_turret,[1,1,1,1],_text] call BCE_fnc_DrawFOV;
    };
  };
};

if (_taskVar isNotEqualto []) then {
  private _dir = getDirVisual _vehicle;

  //-Aircraft
  _ctrl drawIcon [
    "\a3\ui_f\data\Map\VehicleIcons\iconManVirtual_ca.paa",
    [1,1,1,1],
    _veh_POS,
    25,
    25,
    _dir,
    "",
    1,
    0.075
  ];

  _taskVar params ["_caller","_callerGrp","_type","_taskVar"];

  switch _type do {
    case 5: {
      private _FRD = _taskVar # 1;
      private _Target = _taskVar # 2;
      private _desc = _taskVar # 3;
      private _remarks = _taskVar # 4;

      //-Draw Target
      if ((_Target # 0) != "NA") then {

        //-Vehicle to TG line
        _ctrl drawArrow [
          _veh_POS,
          _Target # 2,
          [1,0,0,1]
        ];

        //-Icon
        private _Icon = [
          "\a3\ui_f\data\IGUI\Cfg\Targeting\Empty_ca.paa",
          "\a3\ui_f\data\GUI\Cfg\Cursors\hc_overenemy_gs.paa"
        ] select ((_Target # 1) == "GRID");

        _ctrl drawIcon [
          _Icon,
          [1,0,0,1],
          _Target # 2,
          30,
          30,
          0,
          format ["%1 - %2 with: [%3]", _Target # 0, trim(_desc # 1), trim(_desc # 2)],
          1,
          0.075,
          "EtelkaNarrowMediumPro",
          "right"
        ];

        //-FAD/H to TG line
        if ((_remarks # 0) != "NA") then {
          private _HDG = _remarks # 1;
          private _relPOS = (_Target # 2) getPos [1000, _HDG];
          private _posDiff = ((_Target # 2) vectorDiff _relPOS) vectorMultiply 0.9;

          _ctrl drawArrow [
            _relPOS,
            _relPOS vectorAdd _posDiff,
            [0.6,1,0.37,1]
          ];

          _ctrl drawIcon [
            "\a3\ui_f\data\IGUI\Cfg\Targeting\Empty_ca.paa",
            [0.6,1,0.37,1],
            _relPOS,
            30,
            30,
            0,
            _remarks # 0,
            1,
            0.075,
            "EtelkaNarrowMediumPro",
            ["right","left"] select (_HDG > 180)
          ];
        };
      };

      //-Friendly
      if ((_FRD # 0) != "NA") then {

        //-Draw Arrow
        if ((_Target # 0) != "NA") then {
          private _posDiff = ((_FRD # 2) vectorDiff (_Target # 2)) vectorMultiply 0.9;
          _ctrl drawArrow [
            (_Target # 2),
            (_Target # 2) vectorAdd _posDiff,
            [0,0.5,1,1]
          ];
        };

        //-Icon
        private _Icon = [
          "\a3\ui_f\data\IGUI\Cfg\Targeting\Empty_ca.paa",
          "\a3\ui_f\data\Map\Markers\NATO\b_inf.paa"
        ] select ((_FRD # 1) == "GRID");

        _ctrl drawIcon [
          _Icon,
          [0,0.5,1,1],
          _FRD # 2,
          30,
          30,
          0,
          _FRD # 0,
          1,
          0.075,
          "EtelkaNarrowMediumPro",
          "right"
        ];
      };
    };
    case 9: {
      private _IPBP = _taskVar # 1;
      private _Target = _taskVar # 6;
      private _FRD = _taskVar # 8;
      private _EGRS = _taskVar # 9;
      private _remarks = _taskVar # 10;

      //-Draw IP/BP
      if (((_IPBP # 0) != "NA") && !("Marker" in (_IPBP # 0))) then {
        _ctrl drawIcon [
          "\a3\ui_f\data\GUI\Cfg\Cursors\hc_overfriendly_gs.paa",
          [1,1,0,1],
          _IPBP # 2,
          40,
          40,
          0,
          _IPBP # 0,
          1,
          0.075,
          "EtelkaNarrowMediumPro",
          "right"
        ];
      };

      //-Draw Target
      if ((_Target # 0) != "NA") then {

        //-IP to TG line
        if ((_IPBP # 0) != "NA") then {
          private _posDiff = ((_Target # 2) vectorDiff (_IPBP # 2)) vectorMultiply 0.95;
          _ctrl drawArrow [
        		_IPBP # 2,
            (_IPBP # 2) vectorAdd _posDiff,
            [1,1,0,1]
        	];
          //-Plane to IP/BP
          _ctrl drawArrow [
            _veh_POS,
            _IPBP # 2,
            [1,1,0,1]
          ];

          //-Distance between IP/BP and TG (2D)
          private _posDiff = ((_Target # 2) vectorDiff (_IPBP # 2)) vectorMultiply 0.5;

          _ctrl drawIcon [
            "\a3\ui_f\data\IGUI\Cfg\Targeting\Empty_ca.paa",
            [1,1,0,1],
            (_IPBP # 2) vectorAdd _posDiff,
            30,
            30,
            0,
            _taskVar # 3 # 0,
            1,
            0.075,
            "EtelkaNarrowMediumPro",
            "right"
          ];

        } else {
          //-Plane to IP/BP
          _ctrl drawArrow [
            _veh_POS,
            _Target # 2,
            [1,0,0,1]
          ];
        };

        //-FAD/H to TG line
        if ((_remarks # 0) != "NA") then {
          private _HDG = _remarks # 1;
          private _relPOS = (_Target # 2) getPos [1000, _HDG];
          private _posDiff = ((_Target # 2) vectorDiff _relPOS) vectorMultiply 0.9;

          _ctrl drawArrow [
            _relPOS,
            _relPOS vectorAdd _posDiff,
            [0.6,1,0.37,1]
          ];

          _ctrl drawIcon [
            "\a3\ui_f\data\IGUI\Cfg\Targeting\Empty_ca.paa",
            [0.6,1,0.37,1],
            _relPOS,
            30,
            30,
            0,
            _remarks # 0,
            1,
            0.075,
            "EtelkaNarrowMediumPro",
            ["right","left"] select (_HDG > 180)
          ];
        };

        //-Target Icon
        private _Icon = [
          "\a3\ui_f\data\IGUI\Cfg\Targeting\Empty_ca.paa",
          "\a3\ui_f\data\GUI\Cfg\Cursors\hc_overenemy_gs.paa"
        ] select ((_Target # 1) == "GRID");

        _ctrl drawIcon [
          _Icon,
          [1,0,0,1],
          _Target # 2,
          30,
          30,
          0,
          _Target # 0,
          1,
          0.075,
          "EtelkaNarrowMediumPro",
          "right"
        ];
      };

      //-Friendly
      if ((_FRD # 0) != "NA") then {

        //-Draw Arrow
        if ((_Target # 0) != "NA") then {
          private _posDiff = ((_FRD # 2) vectorDiff (_Target # 2)) vectorMultiply 0.9;
          _ctrl drawArrow [
            (_Target # 2),
            (_Target # 2) vectorAdd _posDiff,
            [0,0.5,1,1]
          ];
        };

        //-Icon
        private _Icon = [
          "\a3\ui_f\data\IGUI\Cfg\Targeting\Empty_ca.paa",
          "\a3\ui_f\data\Map\Markers\NATO\b_inf.paa"
        ] select ((_FRD # 1) == "GRID");

        _ctrl drawIcon [
          _Icon,
          [0,0.5,1,1],
          _FRD # 2,
          30,
          30,
          0,
          _FRD # 0,
          1,
          0.075,
          "EtelkaNarrowMediumPro",
          "right"
        ];
      };

      //-EGRS
      if (
        ((_EGRS # 0) != "NA") && ((_Target # 0) != "NA")
      ) then {

        private _HDG = _EGRS # 1;
        private _relPOS = if (isnil{_EGRS # 3}) then {
          (_Target # 2) getPos [500, _HDG];
        } else {
          //_EGRS # 3
          (_Target # 2) vectorAdd (((_EGRS # 3) vectorDiff (_Target # 2)) vectorMultiply 0.95)
        };
        _ctrl drawArrow [
          (_Target # 2),
          _relPOS,
          [1,1,1,1]
        ];

        _ctrl drawIcon [
          "\a3\ui_f\data\IGUI\Cfg\Targeting\Empty_ca.paa",
          [1,1,1,1],
          _relPOS,
          30,
          30,
          0,
          _EGRS # 0,
          1,
          0.075,
          "EtelkaNarrowMediumPro",
          "left"
        ];
      };
    };
  };
};
