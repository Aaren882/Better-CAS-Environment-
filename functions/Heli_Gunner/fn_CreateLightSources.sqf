params ["_veh","_mode","_unit"];
_Optics = _veh getVariable "TGP_View_Available_Optics";

(_Optics select {(_veh unitTurret _unit) isEqualTo (_x # 1)}) apply {
  private _lod = _x # 0;
  private _turret = _x # 1;

  //Beg ,End for resetting direction
  _config = [typeOf _veh, _turret] call BIS_fnc_turretConfig;

  private _Light_Offset = if (isArray(_config >> "SpotLight_Offset")) then {getArray(_config >> "SpotLight_Offset") vectorAdd [0,0.5,-0.35]} else {[0,0,0]};

  private _offset = if (getNumber(_config >> "LightFromLOD")==1) then {_Light_Offset} else {[0,0.5,-0.35] vectorAdd _Light_Offset};

  private _Laser_lod = getText (_config >> "gunEnd");
  private _Laser_Offset = if (isArray (_config >> "Laser_Offset")) then {getArray(_config >> "Laser_Offset")} else {[0,0,0]};

  switch (_mode) do
  {
    //Lights
    case "Light": {
      _lightL = "Reflector_Cone_01_spotlight_F" createVehicle [0,0,0];
      _object_search = createSimpleObject ["A3\data_f\VolumeLightFlashlight.p3d",[0,0,0]];
      _lightL attachTo [_veh, _offset, _lod, true];
      _object_search attachTo [_veh, _offset, _lod, true];
      _object_search setObjectScale 4;

      _unit setVariable ["BCE_turret_Gunner_Lights",[[_lightL,_object_search],_mode,_veh],true];
    };
    case "LightIR" : {
      _lightL = "Reflector_Cone_01_spotlight_IR_F" createVehicle [0,0,0];
      _lightL attachTo [_veh, _offset, _lod, true];

      _unit setVariable ["BCE_turret_Gunner_Lights",[[_lightL],_mode,_veh],true];
    };
    //Lasers
    case "LaserR": {
      _lightL = createSimpleObject ["A3\data_f\VolumeLightFlashlight.p3d",[0,0,0]];
      _lightL attachTo [_veh, [0,0,0], _lod, true];
      hideObject _lightL;

      _unit setVariable ["BCE_turret_Gunner_Laser",[[_lightL],[_Laser_lod,_Laser_Offset],[1000,0,0],_veh],true];
    };
    case "LaserG": {
      _lightL = createSimpleObject ["A3\data_f\VolumeLightFlashlight.p3d",[0,0,0]];
      _lightL attachTo [_veh, [0,0,0], _lod, true];
      hideObject _lightL;

      _unit setVariable ["BCE_turret_Gunner_Laser",[[_lightL],[_Laser_lod,_Laser_Offset],[0,1000,0],_veh],true];
    };
    case "LaserIR": {
      _lightL = createSimpleObject ["A3\data_f\VolumeLightFlashlight.p3d",[0,0,0]];
      _lightL attachTo [_veh, [0,0,0], _lod, true];
      hideObject _lightL;

      _unit setVariable ["BCE_turret_Gunner_Laser",[[_lightL],[_Laser_lod,_Laser_Offset],[1000,1000,1000],_veh],true];
    };
  };
};
