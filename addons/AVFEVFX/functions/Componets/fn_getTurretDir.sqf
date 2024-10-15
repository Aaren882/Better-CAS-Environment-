params["_vehicle","_turret",["_opticMode",false]];
private ["_turretConfig","_result"];
_turretConfig = [_vehicle, _turret] call BIS_fnc_turretConfig;

if (_opticMode) exitWith {
  (_vehicle selectionVectorDirAndUp [getText (_turretConfig >> "memoryPointGunnerOptics"), "Memory"]) # 0
};

_result = if (
    (_vehicle == cameraon) &&
    (cameraView == "GUNNER") &&
    (
      ((_vehicle unitTurret player) isEqualTo _turret) or
      (unitIsUAV _vehicle)
    )
  ) then {
  (AGLToASL (positionCameraToWorld [0,0,0])) vectorFromTo (AGLToASL (positionCameraToWorld [0,0,1]))
} else {
  private ["_gunBeg","_gunEnd","_config"];
  _gunBeg = _vehicle selectionPosition getText(_turretConfig >> "gunBeg");
  _gunEnd = _vehicle selectionPosition getText(_turretConfig >> "gunEnd");


  if (_gunEnd isEqualTo _gunBeg) then {
    _config = configOf _vehicle;
    if (((getNumber (_config >> "isUAV")) == 1) && (_turret isEqualto [0])) then {
      _gunBeg = _vehicle selectionPosition getText (_config >> "uavCameraGunnerDir");
      _gunEnd = _vehicle selectionPosition getText (_config >> "uavCameraGunnerPos");
    };
  };

  //-Return
  [
    (_vehicle modelToWorldWorld _gunEnd) vectorFromTo (_vehicle modelToWorldWorld _gunBeg),
    vectorNormalized (_vehicle weaponDirection ((_vehicle weaponsTurret _turret) # 0))
  ] select (getNumber (_turretConfig >> "primaryGunner") == 1);
};

_result
