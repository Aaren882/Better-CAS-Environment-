params ["_ctrl"];

_display = ctrlparent _ctrl;

//-Controller
_ctrl drawIcon [
  "\a3\ui_f\data\Map\VehicleIcons\iconManVirtual_ca.paa",
  [1,1,1,1],
  getPosASLVisual cameraOn,
  25,
  25,
  getDirVisual cameraOn,
  "",
  1,
  0.05
];

{
  private _config = configFile >> "CfgVehicles" >> typeOf _x;
  private _icon = getText (_config >> "icon");
  private _isSelected = (player getvariable ["TGP_View_Selected_Vehicle",objNull]) isEqualTo _x;
  private _pos = getPosASLVisual _x;

  private _color = if (_isSelected) then {
    [[0,1,0.3,0.8],[1,1,0.3,0.8]] select (uinamespace getVariable ['BCE_Terminal_SelColor',true])
  } else {
    if (uinamespace getVariable ['BCE_Terminal_Veh',true]) then {
      if (playerSide == blufor) then {
        [profilenamespace getvariable ['Map_BLUFOR_R',0],profilenamespace getvariable ['Map_BLUFOR_G',1],profilenamespace getvariable ['Map_BLUFOR_B',1],profilenamespace getvariable ['Map_BLUFOR_A',0.8]]
      } else {
        if (playerSide == opfor) then {
          [profilenamespace getvariable ['Map_OPFOR_R',0],profilenamespace getvariable ['Map_OPFOR_G',1],profilenamespace getvariable ['Map_OPFOR_B',1],profilenamespace getvariable ['Map_OPFOR_A',0.8]]
        } else {
          [profilenamespace getvariable ['Map_Independent_R',0],profilenamespace getvariable ['Map_Independent_G',1],profilenamespace getvariable ['Map_Independent_B',1],profilenamespace getvariable ['Map_Independent_A',0.8]]
        };
      };
    } else {
      [0,0,0,0]
    };
  };

  //-Connectable Vehicles
  _ctrl drawIcon [
    _icon,
    _color,
    _pos,
    24,
    24,
    getDirVisual _x,
    "",
    1,
    0.03,
    "TahomaB",
    "right"
  ];

  //-Current Connected Vehicle
  if (_isSelected) then {
    _ctrl drawIcon [
      "\a3\ui_f\data\IGUI\Cfg\Targeting\MarkedTarget_ca.paa",
      _color,
      _pos,
      50,
      50,
      0,
      format ["%1 || ASL: %2m Speed: %3km/h",name (driver _x),round((getPosASL _x) # 2), round(Speed _x)],
      1,
      0.06,
      "TahomaB",
      "right"
    ];

    //-Waypoints
    if (uinamespace getVariable ['BCE_Terminal_WP',true]) then {
      private _current_WP = currentWaypoint group _x;
      private _WPpos = getWPPos [_x,_current_WP];
      if !(_WPpos isEqualTo [0,0,0]) then {
        _ctrl drawArrow [_pos, _WPpos, _color];
      };
      private _waypoints = (waypoints _x) select {waypointType _x == "MOVE"};

      {
        _x params ["_group","_index"];

        if (_index >= _current_WP) then {
          private _WP_index = if (_forEachIndex < (count _waypoints - 1)) then {
            _waypoints # (_forEachIndex + 1)
          } else {
            _x
          };

          private _WPpos = getWPPos _x;
          private _WPposNext = getWPPos _WP_index;

          if (!(_WPpos isEqualTo [0,0,0]) && !(_WPposNext isEqualTo [0,0,0])) then {
            _ctrl drawArrow [_WPpos, _WPposNext, _color];
          };
        };
      } forEach _waypoints;
    };

    //-Camera Info
    private _connected_Optic = player getVariable ["TGP_View_Selected_Optic",[]];
    if (!(_connected_Optic isEqualTo []) && (uinamespace getVariable ['BCE_Terminal_Targeting',true])) then {
      private _current_turret = _connected_Optic # 0 # 1;
      //-is Pilot Camera
      private _FocusPos = if (_current_turret isEqualTo []) then {
        ((_x getVariable ["BCE_Camera_Info_Air",[]]) # 0) params [["_pilotCamTracking",false], ["_FocusPos",[0,0,0]], ["_pilotCamTarget",objNull]];
        if (_pilotCamTracking) then {
          _FocusPos
        } else {
          nil
        };
      } else {
        private _dir_simp = missionNamespace getVariable ["BCE_Directional_object_AV",objNull];
        if !(_dir_simp isEqualTo objNull) then {
          private _lod = getText([_x, _current_turret] call BIS_fnc_turretConfig >> "memoryPointGunnerOptics");
          private _startLODPos = _x modelToWorldVisual (_x selectionPosition _lod);

          private _dir = vectorDir _dir_simp;
          private _dirNorm = vectorNormalized _dir;
          private _dirDist = _dirNorm vectorMultiply ((getObjectViewDistance # 0)*2);
          private _startPos = (_dirNorm vectorMultiply 1.5) vectorAdd _startLODPos;
          private _dirPoint = _startPos vectorAdd _dirDist;
          private _FocusPos = ((lineIntersectsSurfaces [_startPos, _dirPoint, _x, objNull, true, -1, "VIEW"]) # 0) # 0;
          _FocusPos
        } else {
          nil
        };
      };

      if !(isNil {_FocusPos}) then {
        _ctrl drawLine [_pos,_FocusPos,_color];
        _ctrl drawIcon [
          "\a3\ui_f\data\GUI\Cfg\Cursors\hc_overfriendly_gs.paa",
          _color,
          _FocusPos,
          40,
          40,
          0,
          format ["GRID: %1",mapGridPosition _FocusPos],
          1,
          0.05,
          "TahomaB",
          "right"
        ];
      };
    };
  };
} forEach (vehicles select {(_x isKindOf "Air") && (isEngineOn _x) && !(unitIsUAV _x) && (playerSide == side _x)});

//- CAS
_Task_Type = _display displayCtrl 2107;
_sel_TaskType = _Task_Type lbValue (lbCurSel _Task_Type);
_taskVars = switch _sel_TaskType do {
  //-5 line
  case 1: {
    _taskVar = uiNamespace getVariable ["BCE_CAS_5Line_Var", [["NA",0],["NA","",[],[0,0],""],["NA","111222"],["NA","--",""],["NA",[]]]];
    _FRD = _taskVar # 1;
    _Target = _taskVar # 2;

    [["NA",[]],_Target,_FRD,["NA",[]]]
  };
  //-9 line
  default {
    _taskVar = uiNamespace getVariable ["BCE_CAS_9Line_Var", [["NA",0],["NA","",[],[0,0]],["NA",180],["NA",200],["NA",15],["NA","desc"],["NA","",[],[0,0],[]],["NA","1111"],["NA","",[],[0,0],""],["NA",0,[],nil,nil],["NA",[]]]];
    _IPBP = _taskVar # 1;
    _Target = _taskVar # 6;
    _FRD = _taskVar # 8;
    _EGRS = _taskVar # 9;
    [_IPBP,_Target,_FRD,_EGRS]
  };
};
_taskVars params ["_IPBP","_Target","_FRD","_EGRS"];

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