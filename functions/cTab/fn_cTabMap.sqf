params["_display","_ctrl"];

private _veh = player getvariable ["TGP_View_Selected_Vehicle",objNull];

if !(isnull _veh) then {
  private _color = [1,1,0.3,0.8];
  private _pos = getPosASLVisual _veh;

  _ctrl drawIcon [
    "\a3\ui_f\data\IGUI\Cfg\Targeting\MarkedTarget_ca.paa",
    _color,
    _pos,
    50,
    50,
    0,
    format ["%1 || ASL: %2m Speed: %3km/h",name (driver _veh),round(_pos # 2), round(Speed _veh)],
    1,
    0.06,
    "EtelkaNarrowMediumPro",
    "right"
  ];

  //-Waypoints
  private _current_WP = currentWaypoint group _veh;
  private _WPpos = getWPPos [_veh,_current_WP];
  if !(_WPpos isEqualTo [0,0,0]) then {
    _ctrl drawArrow [_pos, _WPpos, _color];
  };
  private _waypoints = (waypoints _veh) select {waypointType _x == "MOVE"};

  {
    _x params ["_group","_index"];

    if (_index >= _current_WP) then {
      private _WP_index = [
        _x,
        _waypoints # (_forEachIndex + 1)
      ] select (_forEachIndex < (count _waypoints - 1));

      private _WPpos = getWPPos _x;
      private _WPposNext = getWPPos _WP_index;

      if (!(_WPpos isEqualTo [0,0,0]) && !(_WPposNext isEqualTo [0,0,0])) then {
        _ctrl drawArrow [_WPpos, _WPposNext, _color];
      };
    };
  } forEach _waypoints;
};

//- CAS
private _Task_Type = _display displayCtrl 2107;
private _sel_TaskType = _Task_Type lbValue (lbCurSel _Task_Type);
private _taskVars = switch _sel_TaskType do {
  //-5 line
  case 1: {
    private _taskVar = uiNamespace getVariable ["BCE_CAS_5Line_Var", [["NA",0],["NA","",[],[0,0],""],["NA","111222"],["NA","--",""],["NA",-1,[]]]];
    private _FRD = _taskVar # 1;
    private _Target = _taskVar # 2;
    private _remarks = _taskVar # 4;
    [["NA",[]],_Target,_FRD,["NA",[]],_remarks]
  };
  //-9 line
  default {
    private _taskVar = uiNamespace getVariable ["BCE_CAS_9Line_Var", [["NA",0],["NA","",[],[0,0]],["NA",180],["NA",200],["NA",15],["NA","desc"],["NA","",[],[0,0],[]],["NA","1111"],["NA","",[],[0,0],""],["NA",0,[],nil,nil],["NA",-1,[]]]];
    private _IPBP = _taskVar # 1;
    private _Target = _taskVar # 6;
    private _FRD = _taskVar # 8;
    private _EGRS = _taskVar # 9;
    private _remarks = _taskVar # 10;
    [_IPBP,_Target,_FRD,_EGRS,_remarks]
  };
};
_taskVars params ["_IPBP","_Target","_FRD","_EGRS","_remarks"];

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
  };

  //-FAD/H to TG line
  if ((_remarks # 1) != -1) then {
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
