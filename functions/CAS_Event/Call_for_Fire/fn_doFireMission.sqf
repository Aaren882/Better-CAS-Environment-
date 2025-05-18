/*
  NAME : BCE_fnc_doFireMission
*/
params ["","",["_delay",2]];

[
  {
    params ["_bestCharge","_taskUnit",["_delay",2]];
    hint str [_bestCharge,_taskUnit,_delay,time];

    private _gunner = gunner _taskUnit;
    private _turretPath = (assignedVehicleRole _gunner) # 1;
    private _weapon = _taskUnit currentWeaponTurret _turretPath;

    _taskUnit setWeaponReloadingTime [_gunner, currentMuzzle _gunner, 0];
    _taskUnit fire [_weapon, _bestCharge];
  }, _this, _delay
] call CBA_fnc_waitAndExecute;