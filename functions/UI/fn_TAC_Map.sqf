private _ctrl = _this # 0;

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
} forEach (vehicles select {!(_x getVariable "TGP_View_Available_Optics" isEqualTo []) && (isEngineOn _x) && !(unitIsUAV _x) && (playerSide == side _x)});
