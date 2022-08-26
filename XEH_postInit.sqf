if (!hasInterface) exitWith {};
IR_LaserLight_UnitList = [];
TGP_View_Unit_List = [];
IR_LaserLight_UnitList_LastUpdate = 0;

["BCE_Init",BCE_fnc_init] call CBA_fnc_addEventHandler;

["BCE_Init",[]] call CBA_fnc_localEvent;

#define IsTGP_CAM_ON !((player getVariable ["TGP_View_Camera", []]) isEqualTo [])
#define getTurret (call BCE_fnc_getTurret)

//- Optic Mode
[
  "TGP Cam Settings","OpticMode",
  "Optic Mode",
  {
    if (IsTGP_CAM_ON) then {
      _n_counts = player getVariable ["TGP_View_Optic_Mode", 2];
      if (_n_counts == 5) then {
        _n_counts = 2;
        player setVariable ["TGP_View_Optic_Mode", 2];
      } else {
        _n_counts = _n_counts + 1;
        player setVariable ["TGP_View_Optic_Mode", _n_counts];
      };
      [_n_counts] call BCE_fnc_OpticMode;
    };
  },
  "",
  [0x31, [false, false, false]]
] call cba_fnc_addKeybind;

//- Exit
[
  "TGP Cam Settings","Exit",
  "Exit Camera",
  {
    if (IsTGP_CAM_ON) then {
      camUseNVG false;
      call BCE_fnc_Cam_Delete;
      [2] call BCE_fnc_OpticMode;
    };
  },
  "",
  [0x39, [false, false, false]]
] call cba_fnc_addKeybind;

//- Zoom
[
  "TGP Cam Settings","ZoomIn",
  "Zoom In",
  {
    if (IsTGP_CAM_ON) then {
      _cam = (player getVariable "TGP_View_Camera") # 0;
      _FOV = player getVariable "TGP_View_Camera_FOV";
      if (_FOV > 0.1) then {
        _FOV = _FOV - 0.05;
        _cam camSetFov _FOV;
        player setVariable ["TGP_View_Camera_FOV", _FOV];
      };
    };
  },
  "",
  [0x4E, [false, false, false]],
  true
] call cba_fnc_addKeybind;

[
  "TGP Cam Settings","ZoomOut",
  "Zoom Out",
  {
    if (IsTGP_CAM_ON) then {
      _cam = (player getVariable "TGP_View_Camera") # 0;
      _FOV = player getVariable "TGP_View_Camera_FOV";
      if (_FOV < 0.75) then {
    		_FOV = _FOV + 0.05;
        _cam camSetFov _FOV;
        player setVariable ["TGP_View_Camera_FOV", _FOV];
    	};
    };
  },
  "",
  [0x4A, [false, false, false]],
  true
] call cba_fnc_addKeybind;

//- Swich Turret
[
  "TGP Cam Settings","SwichView_L",
  "Swich View Left",
  {
    if (IsTGP_CAM_ON) then {
      getTurret params ["_cam","_vehicle","_Optic_LODs","_current_turret"];

      if (count _Optic_LODs == 1) exitWith {};
      _current_turret = if (_current_turret < 1) then {
        (count _Optic_LODs) - 1
      } else {
        _current_turret - 1
      };

      _turret_select = _Optic_LODs # _current_turret;

      if (_turret_select # 2) then {
        _cam attachTo [_vehicle, [0,0,0],_turret_select # 0];
      } else {
        _cam attachTo [_vehicle, [0,0,0],_turret_select # 0,true];
      };

      player setVariable ["TGP_View_Selected_Optic",[_turret_select,_vehicle]];

      //UI
      _turret_Unit = _vehicle turretUnit _turret_select # 1;

      _gunner = if (_turret_Unit isEqualTo objNull) then {
        "None"
      } else {
        name _turret_Unit
      };
      ((uiNameSpace getVariable "BCE_TGP") displayCtrl 1029) ctrlSetText (format ["Gunner: %1", _gunner]);
    };
  },
  "",
  [0xCB, [false, false, false]],
  true
] call cba_fnc_addKeybind;

[
  "TGP Cam Settings","SwichView_R",
  "Swich View Right",
  {
    if (IsTGP_CAM_ON) then {
      getTurret params ["_cam","_vehicle","_Optic_LODs","_current_turret"];

      if (count _Optic_LODs == 1) exitWith {};
      _current_turret = if (_current_turret >= ((count _Optic_LODs) - 1)) then {
        0
      } else {
        _current_turret + 1
      };

      _turret_select = _Optic_LODs # _current_turret;

      if (_turret_select # 2) then {
        _cam attachTo [_vehicle, [0,0,0],_turret_select # 0];
      } else {
        _cam attachTo [_vehicle, [0,0,0],_turret_select # 0,true];
      };

      player setVariable ["TGP_View_Selected_Optic",[_turret_select,_vehicle]];

      //UI
      _turret_Unit = _vehicle turretUnit _turret_select # 1;

      _gunner = if (_turret_Unit isEqualTo objNull) then {
        "None"
      } else {
        name _turret_Unit
      };
      ((uiNameSpace getVariable "BCE_TGP") displayCtrl 1029) ctrlSetText (format ["Gunner: %1", _gunner]);
    };
  },
  "",
  [0xCD, [false, false, false]],
  true
] call cba_fnc_addKeybind;

//Optional
[
  "TGP Cam Settings","Unit_Tracker_Box",
  "Toggle Unit Tracker Box",
  {
    if (IsTGP_CAM_ON) then {
      if (player getVariable ["TGP_view_Unit_Tracker_Box",true]) then {
        player setVariable ["TGP_view_Unit_Tracker_Box",false];
      } else {
        player setVariable ["TGP_view_Unit_Tracker_Box",true];
      };
    };
  },
  "",
  [0x16, [false, false, false]]
] call cba_fnc_addKeybind;

[
  "TGP Cam Settings","Unit_Tracker",
  "Toggle Unit Tracker",
  {
    if (IsTGP_CAM_ON) then {
      if (player getVariable ["TGP_view_Unit_Tracker",true]) then {
        player setVariable ["TGP_view_Unit_Tracker",false];
      } else {
        player setVariable ["TGP_view_Unit_Tracker",true];
      };
    };
  },
  "",
  [0x24, [false, false, false]]
] call cba_fnc_addKeybind;

[
  "TGP Cam Settings","Compass",
  "Toggle 3D Compass",
  {
    if (IsTGP_CAM_ON) then {
      if (player getVariable ["TGP_view_3D_Compass",true]) then {
        player setVariable ["TGP_view_3D_Compass",false];
      } else {
        player setVariable ["TGP_view_3D_Compass",true];
      };
    };
  },
  "",
  [0x25, [false, false, false]]
] call cba_fnc_addKeybind;

[
  "TGP Cam Settings","Unit_MapIcon",
  "Toggle Map Icons",
  {
    if (IsTGP_CAM_ON) then {
      if (player getVariable ["TGP_view_Map_Icon",true]) then {
        player setVariable ["TGP_view_Map_Icon",false];
      } else {
        player setVariable ["TGP_view_Map_Icon",true];
      };
    };
  },
  "",
  [0x26, [false, false, false]]
] call cba_fnc_addKeybind;
