params ["_vehicle",["_IP_POS",[]],"_FAD_POS","_posTarget","_EGRS","_weaponInfo","_taskVar","_type"];
_weaponInfo params ["_WPNclass","_WPN_Mode","_WPN_turret","_WPN_count","_muzzle","_ATK_range"];

if (
  !canMove _vehicle or
  !alive driver _vehicle or
  fuel _vehicle == 0 or
  unitIsUAV _vehicle
) exitWith {};

if ((_vehicle getVariable ["BCE_Task_Receiver", []]) isNotEqualTo []) exitWith {
  hint str "This Aircraft is Unavailable for a New Task";
};
hint "Data Sent.";

if ((isMultiplayer) && (isplayer _vehicle)) then {
  [["BCE", "Task_Received"],15,"",35,"",false,false,true] remoteExec ["BIS_fnc_advHint",_vehicle,true];
};

//-GunShip
if (typeof _vehicle in ["B_T_VTOL_01_armed_F","USAF_AC130U"]) exitWith {
  [_vehicle,_posTarget,_ATK_range] call BCE_fnc_GunShip_Loiter;
};

//-have IP/BP
_has_IP = !(_IP_POS isEqualTo []);

if (isplayer _vehicle) exitWith {
  _remarks = switch _type do {
    case 5: {_taskVar # 4};
    case 9:{_taskVar # 10};
  };
  //-Fix FAD/H if there's nothing
  if (((_remarks # 0) == "NA") && !(_has_IP)) then {
    _HDG = round(_posTarget getDirVisual _FAD_POS);
    _To_Dir = [_HDG - 180,360 + (_HDG - 180)] select ((_HDG - 180) < 0);
    _text = format ["“%1” to “%2”",_HDG call BCE_fnc_getAzimuth,_To_Dir call BCE_fnc_getAzimuth];

    _remarks set [0,_text];
    _remarks set [1,_HDG];
  };
  private _task_info = [player,group player,_type,_taskVar];
  _vehicle setVariable ["BCE_Task_Receiver", _task_info, true];
};

if ((_vehicle isKindOf "Helicopter") or !(BCE_AI_CAS_Support_fn)) exitWith {};

_vehicle disableAI "TARGET";
_vehicle disableAI "AUTOTARGET";

private _grp = group _vehicle;

//-Clear Waypoints
for "_i" from count waypoints _grp - 1 to 1 step -1 do {
  deleteWaypoint [_grp, _i];
};

if (_has_IP && (_IP_POS isNotEqualTo _FAD_POS)) then {
  private _wp = _grp addWaypoint [_IP_POS, 0];
};

_IP = [_FAD_POS,_IP_POS] select _has_IP;

//-Set Waypoints
if ((_vehicle distance2D _posTarget) <= (_vehicle distance2D _IP)) then {
  _ActWP = [4,5] select _has_IP;
  for "_i" from 1 to 5 do {
    switch _i do {
      //-Get around TG POS
      case 1:{
        private _TG_dir = _FAD_POS getDirVisual _posTarget;
        private _pos = [90,-90] apply {_posTarget getPos [4000, _TG_dir + _x]};
        private _pos = _pos select ((_vehicle distance2D (_pos # 0)) > (_vehicle distance2D (_pos # 1)));
        if ((_vehicle distance2D _IP_POS) <= (_vehicle distance2D _pos)) then {
          _ActWP = _ActWP - 1;
          _vehicle flyInHeight 2000;
          continue;
        };
        _pos set [2, (getpos _vehicle) # 2];
        private _wp = _grp addWaypoint [_pos, 0];
        _wp setWaypointStatements ["true", "vehicle this flyInHeight 2000;"];
      };
      //-Get a line
      case 2:{
        //-Last WP
        private _TG_dir = _FAD_POS getDirVisual _posTarget;
        private _LastWP = [90,-90] apply {_posTarget getPos [5000, _TG_dir + _x]};
        private _LastWP = [-10,10] select ((_vehicle distance (_LastWP # 0)) > (_vehicle distance (_LastWP # 1)));

        private _IP_dir = _posTarget getDirVisual _FAD_POS;
        private _pos = _posTarget getPos [((_posTarget distance2D _FAD_POS) + 2000) max 4000, _IP_dir+_LastWP];

        _pos set [2, (getpos _vehicle) # 2];
        private _wp = _grp addWaypoint [_pos, 0];
      };
      case 3:{
        private _IP_dir = _posTarget getDirVisual _FAD_POS;
        private _pos = _posTarget getPos [((_posTarget distance2D _FAD_POS) + 1000) max 3000, _IP_dir];

        _pos set [2, (getpos _vehicle) # 2];
        private _wp = _grp addWaypoint [_pos, 0];
      };
      //-IP
      case 4:{
        private _IP_dir = _posTarget getDirVisual _FAD_POS;
        private _pos = _posTarget getPos [2500, _IP_dir];
        _pos set [2, (getpos _vehicle) # 2];

        private _wp = _grp addWaypoint [_pos, 0];

        if !(_vehicle getVariable ["Module_CAS_Sound",false]) then {
          //Sound Handler
          _vehicle setVariable ["Module_CAS_Sound",true,true];

          [{
              params ["_ActWP","_grp","_vehicle"];

              ((currentWaypoint _grp) > _ActWP) or !(alive _vehicle) or (isplayer _vehicle)
            }, {
              params ["_ActWP","_grp","_vehicle"];

              //Call Event
              if ((alive _vehicle) && !(isplayer _vehicle)) then {
                _this call BCE_fnc_CAS_Action;
              };
            }, [_ActWP,_grp]+_this
          ] call CBA_fnc_waitUntilAndExecute;
        };
      };
      //-TG
      case 5:{
        private _wp = _grp addWaypoint [_posTarget, 0];
      };
    };
  };
} else {
  _ActWP = [3,4] select _has_IP;
  for "_i" from 1 to 4 do {
    switch _i do {
      //-Get a line
      case 1:{
        //-Last WP
        private _TG_dir = _FAD_POS getDirVisual _posTarget;
        private _LastWP = [90,-90] apply {_posTarget getPos [5000, _TG_dir + _x]};
        private _LastWP = [-10,10] select ((_vehicle distance (_LastWP # 0)) < (_vehicle distance (_LastWP # 1)));

        private _IP_dir = _posTarget getDirVisual _FAD_POS;
        private _pos = _posTarget getPos [((_posTarget distance2D _FAD_POS) + 2000) max 4000, _IP_dir+_LastWP];

        _pos set [2, (getpos _vehicle) # 2];
        private _wp = _grp addWaypoint [_pos, 0];
        _wp setWaypointStatements ["true", "vehicle this flyInHeight 2000;"];
      };
      case 2:{
        private _IP_dir = _posTarget getDirVisual _FAD_POS;
        private _pos = _posTarget getPos [((_posTarget distance2D _FAD_POS) + 1000) max 3000, _IP_dir];

        _pos set [2, (getpos _vehicle) # 2];
        private _wp = _grp addWaypoint [_pos, 0];
      };
      //-IP
      case 3:{
        private _IP_dir = _posTarget getDirVisual _FAD_POS;
        private _pos = _posTarget getPos [2500, _IP_dir];
        _pos set [2, (getpos _vehicle) # 2];

        private _wp = _grp addWaypoint [_pos, 0];

        if !(_vehicle getVariable ["Module_CAS_Sound",false]) then {
          //Sound Handler
          _vehicle setVariable ["Module_CAS_Sound",true,true];

          [{
              params ["_ActWP","_grp","_vehicle"];

              ((currentWaypoint _grp) > _ActWP) or !(alive _vehicle) or (isplayer _vehicle)
            }, {
              params ["_ActWP","_grp","_vehicle"];

              //Call Event
              if ((alive _vehicle) && !(isplayer _vehicle)) then {
                _this call BCE_fnc_CAS_Action;
              };
            }, [_ActWP,_grp]+_this
          ] call CBA_fnc_waitUntilAndExecute;
        };
      };
      //-TG
      case 4:{
        private _wp = _grp addWaypoint [_posTarget, 0];
      };
    };
  };
};
