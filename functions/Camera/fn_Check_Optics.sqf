params ["_vehicle"];

//Available Optics
if (_vehicle isKindOf "Air") then {
  if ((_vehicle getVariable ["TGP_View_Available_Optics",[]]) isEqualTo []) then {
    _Optics_Array = [];
    _config_path = configOf _vehicle;

    _pilot_cam_LOD = if (
      (isClass (_config_path >> "pilotCamera")) &&
      (getNumber (_config_path >> "pilotCamera" >> "controllable") == 1)
    ) then {
      [getText (_config_path >> "memoryPointDriverOptics"),[-1],true]
    } else {
      ["",[]]
    };

    _allTurrets = allTurrets _vehicle;
    _Turrets_Optics = if (count _allTurrets > 0) then {
      _allTurrets apply {
        _text = getText ([_vehicle, _x] call BIS_fnc_turretConfig >> "memoryPointGunnerOptics");
        _is_Detached = (getNumber ([_vehicle, _x] call BIS_fnc_turretConfig >> "Detached_Optic")) == 1;
        if !((_vehicle selectionPosition _text) isEqualTo [0,0,0]) then {
          [_text,_x,_is_Detached]
        } else {
          ["",[]]
        };
      };
    } else {
      [["",[]]]
    };

    _Turrets_Optics pushBack _pilot_cam_LOD;
    _Optics_Array = _Turrets_Optics;

    //Filter
    _Optic_LODs = _Optics_Array select {
      !(_x isEqualTo ["",[]]) or !(_x isEqualTo ["",[]])
    };

    _vehicle setVariable ["TGP_View_Available_Optics",_Optic_LODs,true];
  };

  //-FOV handler
  if ((count (allTurrets _vehicle) > 0) or (hasPilotCamera _vehicle)) then {

    //-Apply default Turret FOV
    (allTurrets _vehicle + [[[],[-1]] select (hasPilotCamera _vehicle)]) apply {

      private _crew = _vehicle turretUnit _x;
      if ((_crew getVariable ["BCE_Cam_FOV_Angle",-1]) == -1) then {
        private ["_config","_class","_fov"];
        //-if is a pilot Cam (TGP)
        _config = [
          [_vehicle, _x] call BIS_fnc_turretConfig,
          configOf _vehicle >> "PilotCamera"
        ] select ((_x # 0) == -1);

        //-init camera FOV
        _class = (("true" configClasses (_config >> "OpticsIn")) # 0) >> "initFov";
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
                player setVariable ["BCE_Cam_FOV_Angle",deg (getObjectFOV _vehicle),true];
              };
          } else {
            removeUserActionEventHandler ["zoomIn", "Analog", BCE_FOV_actEHs # 0];
            removeUserActionEventHandler ["zoomOut", "Analog", BCE_FOV_actEHs # 1];
            BCE_FOV_actEHs = nil;
            player setVariable ["BCE_Cam_FOV_Angle",-1,true];
          };
        }];
      };
    };
  };
};

//-IR Laser
if !((_vehicle getvariable ["IR_LaserLight_has_gunner",[false,["","",""],false,1]]) # 2) then {

  _turrets = allTurrets _vehicle;
  _turret_Weapons = flatten (
    _turrets apply {
      getArray (([_vehicle, _x] call BIS_fnc_turretConfig) >> "Weapons")
  });

  _has_gunner = true in (_turret_Weapons apply {(tolower "Laserdesignator") in tolower _x});

  //Get memory point
  if (_has_gunner) then {

    {
      _config = [_vehicle, _x] call BIS_fnc_turretConfig;
      _weapons = getArray (_config >> "Weapons");

      if (true in (_weapons apply {(tolower "Laserdesignator") in tolower _x})) then {

        _turret_pos_mem = getText (_config >> "memoryPointGunnerOptics");
        _turret_gunBeg_mem = getText (_config >> "gunBeg");
        _turret_gunEnd_mem = getText (_config >> "gunEnd");

        _vehicle setvariable ["IR_LaserLight_has_gunner",[true,[_turret_pos_mem,_turret_gunBeg_mem,_turret_gunEnd_mem],true,_forEachIndex],true];
      };
    } forEach _turrets;
  };
};
