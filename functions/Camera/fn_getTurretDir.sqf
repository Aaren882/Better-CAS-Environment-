params["_vehicle","_turret",["_opticMode",false]];

if (_opticMode) exitWith {
  (_vehicle selectionVectorDirAndUp [getText ([_vehicle, _turret] call BIS_fnc_turretConfig >> "gun"), "Memory"]) # 0
};
_turretConfig = [_vehicle, _turret] call BIS_fnc_turretConfig;
_gunBeg = _vehicle selectionPosition getText(_turretConfig >> "gunBeg");
_gunEnd = _vehicle selectionPosition getText(_turretConfig >> "gunEnd");

if (_gunEnd isEqualTo _gunBeg) then {
    if ((getNumber (_turretConfig >> "primaryObserver")) == 1) exitWith {
        _gunBeg = _gunEnd vectorAdd (_vehicle vectorWorldToModel eyeDirection _vehicle);
    };
    _config = configOf _vehicle;
    if (((getNumber (_config >> "isUAV")) == 1) && (_turret isEqualto [0])) then {
      _gunBeg = _vehicle selectionPosition getText (_config >> "uavCameraGunnerDir");
      _gunEnd = _vehicle selectionPosition getText (_config >> "uavCameraGunnerPos");
    };
};

(_vehicle modelToWorldWorld _gunEnd) vectorFromTo (_vehicle modelToWorldWorld _gunBeg)
