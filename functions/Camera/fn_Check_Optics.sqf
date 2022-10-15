params ["_vehicle"];

//Available Optics
if ((_vehicle getVariable ["TGP_View_Available_Optics",[]]) isEqualTo []) then {

  _Optics_Array = [];
  _config_path = configFile >> "CfgVehicles" >> typeOf _vehicle;

  _pilot_cam_LOD = if (
    (isClass (_config_path >> "pilotCamera")) &&
    (getNumber (_config_path >> "pilotCamera" >> "controllable") == 1)
  ) then {
    [getText (_config_path >> "memoryPointDriverOptics"),[],getNumber(_config_path >> "Detached_Optic") == 1]
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
