params ["_vehicle",["_mode",-1]];
private ["_class_veh","_allTurrets","_config_path","_pilot_cam_LOD","_Turrets_Optics","_Optic_LODs","_turret_Weapons"];

//-exit if _vehicle is not Vehicle
if !(_vehicle in vehicles) exitWith {[]};

_class_veh = typeOf _vehicle;
_allTurrets = allTurrets _vehicle;
_config_path = configOf _vehicle;

//-Check caches
if (isnil "BCE_Camera_Cache") then {
  BCE_Camera_Cache = createHashMap;
};
if (isnil "BCE_IRLaser_Cache") then {
  BCE_IRLaser_Cache = createHashMap;
};

//-Exit with Return
if ((_mode > -1) && (_class_veh in ([BCE_Camera_Cache, BCE_IRLaser_Cache] # _mode))) exitWith {
  private _result = ([BCE_Camera_Cache, BCE_IRLaser_Cache] # _mode) get _class_veh;
  [_result, []] select (isNil {_result});
};

//-IR Laser
_turret_Weapons = ([[-1]] + _allTurrets apply {
  [
    [_x, flatten getArray ([_vehicle, _x] call BIS_fnc_turretConfig >> "Weapons")],
    [_x, getArray (_config_path >> "Weapons")]
  ] select ((_x # 0) < 0);
}) select {
  {"laserdesignator" in tolower _x} count (_x # 1) > 0
};

if ((_mode == 1) && ((_class_veh in BCE_IRLaser_Cache) or (count _turret_Weapons < 1))) exitWith {};

//-Available Optics
_pilot_cam_LOD = if (
  (isClass (_config_path >> "pilotCamera")) &&
  (getNumber (_config_path >> "pilotCamera" >> "controllable") == 1) &&
  !(unitIsUAV _vehicle)
) then {
  [getText (_config_path >> "memoryPointDriverOptics"),[-1],true]
} else {
  ["",[]]
};

_Turrets_Optics = if (count _allTurrets > 0) then {
  _allTurrets apply {
    private ["_cfg","_text","_is_Detached"];
    _cfg = [_vehicle, _x] call BIS_fnc_turretConfig;
    _text = getText (_cfg >> "memoryPointGunnerOptics");
    _is_Detached = (getNumber (_cfg >> "Detached_Optic")) == 1;
    [
      [_text,_x,_is_Detached],
      ["",[]]
    ] select ((_vehicle selectionPosition _text) isEqualTo [0,0,0]);
  };
} else {
  []
};

_Turrets_Optics = [_pilot_cam_LOD] + _Turrets_Optics;

//--Filter
_Optic_LODs = _Turrets_Optics select {
  !(_x isEqualTo ["",[]])
};

if (count _Optic_LODs > 0) then {
  BCE_Camera_Cache set [_class_veh, _Optic_LODs];
};

//-FOV handler
if (((count _allTurrets > 0) or (hasPilotCamera _vehicle)) && (_vehicle isKindOf "Air")) then {

  //-Apply default Turret FOV
  (BCE_Camera_Cache get _class_veh) apply {

    private _turret = _x # 1;
    private _crew = _vehicle turretUnit _turret;

    if ((_crew getVariable ["BCE_Cam_FOV_Angle",-1]) == -1) then {
      private ["_config","_optic","_class","_fov"];
      //-if is a pilot Cam (TGP)
      _config = [
        [_vehicle, _turret] call BIS_fnc_turretConfig,
        _config_path >> "PilotCamera"
      ] select ((_turret # 0) == -1);

      _class = ([
        [_config >> "ViewOptics"],
        "true" configClasses (_config >> "OpticsIn")
      ] select isclass (_config >> "OpticsIn")) # 0;

      //-init camera FOV
      _class = _class >> "initFov";
      _fov = [
        getNumber _class,
        call compile (getText _class)
      ] select (isText _class);

      //-Set FOV
      _crew setVariable ["BCE_Cam_FOV_Angle",deg _fov,true];
    };
  };

  if (isnil "BCE_FOV_actEHs") then {
    BCE_FOV_actEHs = ["zoomIn","zoomOut"] apply {
      addUserActionEventHandler [_x, "Analog", {
        //-Get FOV is all turrets and TGP (if curretly in an Aircraft)
        private _vehicle = cameraOn;
        if (
          (_vehicle isKindOf "Air") &&
          (
            (count (allTurrets _vehicle) > 0) or
            (hasPilotCamera _vehicle)
          )
        ) then {
          if (cameraview == "GUNNER") then {
            //-is an UAV
            _unit = [player, getConnectedUAVUnit player] select (unitIsUAV cameraOn);
            _unit setVariable ["BCE_Cam_FOV_Angle",deg (getObjectFOV _vehicle),true];
          };
        } else {
          {
            removeUserActionEventHandler [_x, "Analog", BCE_FOV_actEHs # _forEachIndex];
          } forEach ["zoomIn","zoomOut"];

          BCE_FOV_actEHs = nil;
          player setVariable ["BCE_Cam_FOV_Angle",-1,true];
        };
      }];
    };
  };
};

//Get memory point
if (count _turret_Weapons > 0) then {

  private _result = _turret_Weapons apply {
    _x params ["_turret"];
    private ["_is_turret","_config","_turret_pos_mem","_offset"];

    _is_turret = (_turret # 0) >= 0;
    if (_is_turret) then {
      _config = [_vehicle, _turret] call BIS_fnc_turretConfig;
      _turret_pos_mem = getText (_config >> "memoryPointGunnerOptics");
    } else {
      _config = _config_path;
      _turret_pos_mem = getText (_config >> "memoryPointDriverOptics");
    };

    _offset = [
      [0,0,0],
      getArray (_config >> "LaserDesignator_Offset")
    ] select (isArray (_config >> "LaserDesignator_Offset"));

    [_is_turret,[_turret_pos_mem,_offset,_turret]]
  };

  if (count _result > 0) then {
    BCE_IRLaser_Cache set [_class_veh, _result];
  };
};

//-Return
[
  [],
  ([BCE_Camera_Cache, BCE_IRLaser_Cache] # _mode) get _class_veh
] select (_mode > -1);
