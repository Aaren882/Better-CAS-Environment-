params ["_vehicle",["_IP_POS",[]],"_posTarget","_EGRS","_weaponInfo","_taskVar","_type"];
_weaponInfo params ["_WPNclass","_WPN_Mode","_WPN_turret","_WPN_count","_muzzle","_ATK_range"];

if (
  !canMove _vehicle or
  !alive driver _vehicle or
  fuel _vehicle == 0 or
  getNumber (configFile >> "CfgVehicles" >> typeOf _vehicle >> "isUav") > 0
) exitWith {};

if ((_vehicle getVariable ["BCE_Task_Receiver", []]) isNotEqualTo []) exitWith {
  hint str "This Aircraft is Unavailable for a New Task";
};
hint "Data Sent.";

if ((isMultiplayer) && (isplayer _vehicle)) then {
  [["BCE", "Task_Received"]] remoteExec ["BIS_fnc_advHint",_vehicle,true];
};

//-GunShip
if (typeof _vehicle in ["B_T_VTOL_01_armed_F"]) exitWith {
  [_vehicle,_posTarget,_ATK_range] call BCE_fnc_GunShip_Loiter;
};

if (isplayer _vehicle) exitWith {
  private _task_info = [player,group player,_type,_taskVar];
  _vehicle setVariable ["BCE_Task_Receiver", _task_info, true];
};

if ((_vehicle isKindOf "Helicopter") or !(BCE_AI_CAS_Support_fn)) exitWith {};

_vehicle disableAI "TARGET";
_vehicle disableAI "AUTOTARGET";

//-have IP/BP
if (_IP_POS isEqualTo []) then {

} else {
  private _grp = group _vehicle;

  //-Clear Waypoints
  for "_i" from count waypoints _grp - 1 to 1 step -1 do {
  	deleteWaypoint [_grp, _i];
  };

  //-Set Waypoints
  if ((_vehicle distance2D _posTarget) <= (_vehicle distance2D _IP_POS)) then {
    for "_i" from 1 to 5 do {
      switch _i do {
        //-Get around TG POS
        case 1:{
          private _TG_dir = _IP_POS getDir _posTarget;
          private _pos = [90,-90] apply {_posTarget getPos [4000, _TG_dir + _x]};
          private _pos = if ((_vehicle distance (_pos # 0)) < (_vehicle distance (_pos # 1))) then {
            (_pos # 0)
          } else {
            (_pos # 1)
          };
          _pos set [2, (getpos _vehicle) # 2];
          private _wp = _grp addWaypoint [_pos, 0, _i];
          _wp setWaypointStatements ["true", "vehicle this flyInHeight 2000;"];
        };
        //-Get a line
        case 2:{
          //-Last WP
          private _TG_dir = _IP_POS getDir _posTarget;
          private _LastWP = [90,-90] apply {_posTarget getPos [2000, _TG_dir + _x]};
          private _LastWP = if ((_vehicle distance (_LastWP # 0)) < (_vehicle distance (_LastWP # 1))) then
          {-10} else {10};

          private _IP_dir = _posTarget getDir _IP_POS;
          private _pos = _posTarget getPos [((_posTarget distance2D _IP_POS) + 2000) max 4000, _IP_dir+_LastWP];

          _pos set [2, (getpos _vehicle) # 2];
          private _wp = _grp addWaypoint [_pos, 0, _i];
        };
        case 3:{
          private _IP_dir = _posTarget getDir _IP_POS;
          private _pos = _posTarget getPos [((_posTarget distance2D _IP_POS) + 1000) max 3000, _IP_dir];

          _pos set [2, (getpos _vehicle) # 2];
          private _wp = _grp addWaypoint [_pos, 0, _i];
        };
        //-IP
        case 4:{
          private _IP_dir = _posTarget getDir _IP_POS;
          private _pos = _posTarget getPos [2500, _IP_dir];
          _pos set [2, (getpos _vehicle) # 2];

          private _wp = _grp addWaypoint [_pos, 0, _i];

          if !(_vehicle getVariable ["Module_CAS_Sound",false]) then {
            //Sound Handler
            _vehicle setVariable ["Module_CAS_Sound",true,true];

            [{
                params ["_grp","_vehicle"];

                ((currentWaypoint _grp) > 4) or !(alive _vehicle) or (isplayer _vehicle)
              }, {
                params ["_grp","_vehicle"];

                //Call Event
                if ((alive _vehicle) && !(isplayer _vehicle)) then {
                  _this call BCE_fnc_CAS_Action;
                };
              }, [_grp]+_this
            ] call CBA_fnc_waitUntilAndExecute;
          };
        };
        //-TG
        case 5:{
          private _wp = _grp addWaypoint [_posTarget, 0, _i];
        };
      };
    };
  } else {
    for "_i" from 1 to 5 do {
      switch (_i) do {
        //-Get a line
        case 1:{
          //-Last WP
          private _TG_dir = _IP_POS getDir _posTarget;
          private _LastWP = [90,-90] apply {_posTarget getPos [2000, _TG_dir + _x]};
          private _LastWP = if ((_vehicle distance (_LastWP # 0)) < (_vehicle distance (_LastWP # 1))) then
          {-10} else {10};

          private _IP_dir = _posTarget getDir _IP_POS;
          private _pos = _posTarget getPos [((_posTarget distance2D _IP_POS) + 3000) max 5000, _IP_dir+_LastWP];

          _pos set [2, (getpos _vehicle) # 2];
          private _wp = _grp addWaypoint [_pos, 0, _i];
          _wp setWaypointStatements ["true", "vehicle this flyInHeight 2000;"];
        };
        case 2:{
          //-Last WP
          private _TG_dir = _IP_POS getDir _posTarget;
          private _LastWP = [90,-90] apply {_posTarget getPos [2000, _TG_dir + _x]};
          private _LastWP = if ((_vehicle distance (_LastWP # 0)) < (_vehicle distance (_LastWP # 1))) then
          {-10} else {10};

          private _IP_dir = _posTarget getDir _IP_POS;
          private _pos = _posTarget getPos [((_posTarget distance2D _IP_POS) + 2000) max 4000, _IP_dir+_LastWP];

          _pos set [2, (getpos _vehicle) # 2];
          private _wp = _grp addWaypoint [_pos, 0, _i];
        };
        case 3:{
          private _IP_dir = _posTarget getDir _IP_POS;
          private _pos = _posTarget getPos [((_posTarget distance2D _IP_POS) + 1000) max 3000, _IP_dir];

          _pos set [2, (getpos _vehicle) # 2];
          private _wp = _grp addWaypoint [_pos, 0, _i];
        };
        //-IP
        case 4:{
          private _IP_dir = _posTarget getDir _IP_POS;
          private _pos = _posTarget getPos [2500, _IP_dir];
          _pos set [2, (getpos _vehicle) # 2];

          private _wp = _grp addWaypoint [_pos, 0, _i];

          if !(_vehicle getVariable ["Module_CAS_Sound",false]) then {
            //Sound Handler
            _vehicle setVariable ["Module_CAS_Sound",true,true];

            [{
                params ["_grp","_vehicle"];

                ((currentWaypoint _grp) > 4) or !(alive _vehicle) or (isplayer _vehicle)
              }, {
                params ["_grp","_vehicle"];

                //Call Event
                if ((alive _vehicle) && !(isplayer _vehicle)) then {
                  _this call BCE_fnc_CAS_Action;
                };
              }, [_grp]+_this
            ] call CBA_fnc_waitUntilAndExecute;
          };
        };
        //-TG
        case 5:{
          private _wp = _grp addWaypoint [_posTarget, 0, _i];
        };
      };
    };
  };
};
