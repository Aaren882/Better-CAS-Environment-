params ["_unit"];

(({_unit isLaserOn _x} count (allTurrets _unit)) > 0) or (isLaserOn _unit)

/* params [["_vehicle", objNull, [objNull]], ["_turret", [-1], [[]]], ["_relativeToModel", false, [false]]];

private _turretConfig = [_vehicle, _turret] call CBA_fnc_getTurret;

private _gunBeg = _vehicle selectionPosition getText (_turretConfig >> "gunBeg");
private _gunEnd = _vehicle selectionPosition getText (_turretConfig >> "gunEnd");

if (_gunEnd isEqualTo _gunBeg) then {
    if ((getNumber (_turretConfig >> "primaryObserver")) == 1) exitWith {
        _gunBeg = _gunEnd vectorAdd (_vehicle vectorWorldToModel eyeDirection _vehicle);
    };
    private _vehicleConfig = configOf _vehicle;
    if (((getNumber (_vehicleConfig >> "isUAV")) == 1) && {_turret isEqualto [0]}) then {
        _gunBeg = _vehicle selectionPosition getText (_vehicleConfig >> "uavCameraGunnerDir");
        _gunEnd = _vehicle selectionPosition getText (_vehicleConfig >> "uavCameraGunnerPos");
    } else {
        format ['[%1] (%2) %3: %4', toUpper 'cba', 'common', 'WARNING', format["Vehicle %1 has invalid gun configs on turret %2", configName _vehicleConfig, _turret]] call CBA_fnc_log;
    };
};

if !(_relativeToModel) then {
    _gunBeg = _vehicle modelToWorldWorld _gunBeg;
    _gunEnd = _vehicle modelToWorldWorld _gunEnd;
};

private _turretDir = _gunEnd vectorFromTo _gunBeg;

_turretDir params ["_dirX", "_dirY", "_dirZ"];

private _azimuth = _dirX atan2 _dirY;

if (_azimuth < 0) then {
    _azimuth = (_azimuth) + (360);
};

private _inclination = asin _dirZ;

[_azimuth, _inclination] */
