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
  0.075
];

(player getVariable ["TGP_View_Selected_Optic",[[],objNull]]) params ["_connected_Optic","_veh"];

(vehicles select {(_x isKindOf "Air") && (isEngineOn _x) && (playerSide == side _x)}) apply {
  private _icon = getText (configof _x >> "icon");
  private _isSelected = _veh isEqualTo _x;
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
    "RobotoCondensed_BCE",
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
      format ["%1 || ASL: %2m Speed: %3km/h",name (driver _x),round(_pos # 2), round(Speed _x)],
      1,
      0.06,
      "RobotoCondensed_BCE",
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

    //-Camera Info
    if (!(_connected_Optic isEqualTo []) && (uinamespace getVariable ['BCE_Terminal_Targeting',true])) then {
      private _current_turret = _connected_Optic # 1;
      private _isPilot = (_current_turret # 0) == -1;

      //-tell what pos for the turret
      private _FocusPos = if ((local _x) && _isPilot) then {
        private _info = getPilotCameraTarget _x;
        [nil,_info # 1] select (_info # 0);
      } else {
        if (_isPilot) then {
          private _var = _x getVariable ["BCE_Camera_Info_Air",[[false,[]],[]]];
          [nil,_var # 0 # 1] select (_var # 0 # 0);
        } else {
          [_x,_current_turret] call BCE_fnc_Turret_InterSurface;
        };
      };

      //-draw FOV for curret connected turret (except FFV)
      if (!(isnil {_FocusPos}) && !(isNull (_veh turretUnit _current_turret))) then {
        private ["_dis","_turretName","_text"];

        _dis = _veh distance _FocusPos;

        _turretName = [
          getText ([_veh, _current_turret] call BIS_fnc_turretConfig >> "gunnerName"),
          localize "STR_DRIVER"
        ] select _isPilot;

        _text = trim format [
          " %1 : %2 km [%3]",
          _turretName,
          round(_dis/100) / 10,
          getText(configFile >> "CfgWeapons" >> (_veh currentWeaponTurret _current_turret) >> "DisplayName")
        ];

        [_x,_ctrl,_FocusPos,_current_turret,_color,_text,uinamespace getVariable ['BCE_Terminal_Targeting',true]] call BCE_fnc_DrawFOV;
      };
    };
  };
};

//- CAS
_sel_TaskType = uiNameSpace getVariable ["BCE_Current_TaskType",0];
_taskVars = switch _sel_TaskType do {
  //-5 line
  case 1: {
    _taskVar = uiNamespace getVariable ["BCE_CAS_5Line_Var", [["NA",0],["NA","",[],[0,0],""],["NA","111222"],["NA","--",""],["NA",-1,[]]]];
    _FRD = _taskVar # 1;
    _Target = _taskVar # 2;
    _remarks = _taskVar # 4;
    [["NA",[]],_Target,_FRD,["NA",[]],_remarks]
  };
  //-9 line
  default {
    _taskVar = uiNamespace getVariable ["BCE_CAS_9Line_Var", [["NA",0],["NA","",[],[0,0]],["NA",180],["NA",200],["NA",15],["NA","--"],["NA","",[],[0,0],[]],["NA","1111"],["NA","",[],[0,0],""],["NA",0,[],nil,nil],["NA",-1,[]]]];
    _IPBP = _taskVar # 1;
    _Target = _taskVar # 6;
    _FRD = _taskVar # 8;
    _EGRS = _taskVar # 9;
    _remarks = _taskVar # 10;
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
    "RobotoCondensed_BCE",
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
    private _HDG = (_remarks # 1) + 180;
    private _relPOS = (_Target # 2) getPos [1000, _HDG];
    private _posDiff = ((_Target # 2) vectorDiff _relPOS) vectorMultiply 0.9;
    _ctrl drawArrow [
      _relPOS vectorAdd _posDiff,
      _relPOS,
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
      "RobotoCondensed_BCE",
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
    "RobotoCondensed_BCE",
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
    "RobotoCondensed_BCE",
    "right"
  ];
};

//-EGRS
if (
  ((_EGRS # 0) != "NA") && ((_Target # 0) != "NA")
) then {
  private _HDG = _EGRS # 1;
  private _relPOS = [
    (_Target # 2) vectorAdd (((_EGRS # 3) vectorDiff (_Target # 2)) vectorMultiply 0.95),
    (_Target # 2) getPos [500, _HDG]
  ] select (isnil{_EGRS # 3});

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
    format ["EGRS: %1",_EGRS # 0],
    1,
    0.075,
    "RobotoCondensed_BCE",
    "left"
  ];
};
