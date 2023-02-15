params ["_ctrl"];

//- CAS
private _vehicle = vehicle cameraOn;
private _taskVar = _vehicle getVariable ["BCE_Task_Receiver",[]];
if (_taskVar isNotEqualto []) then {
  private _pos = getPosASLVisual _vehicle;
  private _dir = getDirVisual _vehicle;
  //-Aircraft
  _ctrl drawIcon [
    "\a3\ui_f\data\Map\VehicleIcons\iconManVirtual_ca.paa",
    [1,1,1,1],
    _pos,
    25,
    25,
    _dir,
    "",
    1,
    0.05
  ];

  _taskVar params ["_caller","_callerGrp","_type","_taskVar"];

  switch _type do {
    case 5: {
      private _FRD = _taskVar # 1;
      private _Target = _taskVar # 2;
      private _desc = _taskVar # 3;

      //-Draw Target
      if ((_Target # 0) != "NA") then {

        //-Vehicle to TG line
        _ctrl drawArrow [
          _pos,
          _Target # 2,
          [1,0,0,1]
        ];

        //-Icon
        private _Icon = if ((_Target # 1) == "GRID") then {
          "\a3\ui_f\data\GUI\Cfg\Cursors\hc_overenemy_gs.paa"
        } else {
          "\a3\ui_f\data\IGUI\Cfg\Targeting\Empty_ca.paa"
        };

        _ctrl drawIcon [
          _Icon,
          [1,0,0,1],
          _Target # 2,
          30,
          30,
          0,
          format ["%1 - %2 with: [%3]", _Target # 0, trim(_desc # 1), trim(_desc # 2)],
          1,
          0.05,
          "TahomaB",
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
        private _Icon = if ((_FRD # 1) == "GRID") then {
          "\a3\ui_f\data\Map\Markers\NATO\b_inf.paa"
        } else {
          "\a3\ui_f\data\IGUI\Cfg\Targeting\Empty_ca.paa"
        };

        _ctrl drawIcon [
          _Icon,
          [0,0.5,1,1],
          _FRD # 2,
          30,
          30,
          0,
          _FRD # 0,
          1,
          0.05,
          "TahomaB",
          "right"
        ];
      };
    };
    case 9: {
      private _IPBP = _taskVar # 1;
      private _Target = _taskVar # 6;
      private _FRD = _taskVar # 8;
      private _EGRS = _taskVar # 9;

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
          0.05,
          "TahomaB",
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
            _pos,
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
            0.065,
            "TahomaB",
            "right"
          ];

        } else {
          //-Plane to IP/BP
          _ctrl drawArrow [
            _pos,
            _Target # 2,
            [1,0,0,1]
          ];
        };

        //-Icon
        private _Icon = if ((_Target # 1) == "GRID") then {
          "\a3\ui_f\data\GUI\Cfg\Cursors\hc_overenemy_gs.paa"
        } else {
          "\a3\ui_f\data\IGUI\Cfg\Targeting\Empty_ca.paa"
        };

        _ctrl drawIcon [
          _Icon,
          [1,0,0,1],
          _Target # 2,
          30,
          30,
          0,
          _Target # 0,
          1,
          0.05,
          "TahomaB",
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
        private _Icon = if ((_FRD # 1) == "GRID") then {
          "\a3\ui_f\data\Map\Markers\NATO\b_inf.paa"
        } else {
          "\a3\ui_f\data\IGUI\Cfg\Targeting\Empty_ca.paa"
        };

        _ctrl drawIcon [
          _Icon,
          [0,0.5,1,1],
          _FRD # 2,
          30,
          30,
          0,
          _FRD # 0,
          1,
          0.05,
          "TahomaB",
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
          0.065,
          "TahomaB",
          "left"
        ];
      };
    };
  };
};
