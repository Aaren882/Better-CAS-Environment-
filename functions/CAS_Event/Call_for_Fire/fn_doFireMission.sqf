/*
  NAME : BCE_fnc_doFireMission
*/
params ["","_taskUnit","_delay"];

if (isnil{_delay}) then {
  private _gunner = gunner _taskUnit;
  private _turret = _taskUnit unitTurret _gunner;
  private _weapon = _taskUnit currentWeaponTurret _turret;
  private _weaponCfg = configFile >> "CfgWeapons" >> _weapon;

  // - Get Reload time from CfgWeapons
  _delay = [
    _weaponCfg >> currentWeaponMode _gunner,
    "reloadTime",
    getNumber (_weaponCfg >> "reloadTime")
  ] call BIS_fnc_returnConfigEntry;

	//- #NOTE - Save Reload time
	["RELOAD", _delay, _taskUnit] call BCE_fnc_set_CFF_Value;
};

[
  {
    params ["_chargeInfo","_taskUnit",["_delay",2]];

    //- Check MSN
    if ("" == (["CFF_MSN","",_taskUnit] call BCE_fnc_get_CFF_Value)) exitWith {};

    _chargeInfo params ["_charge", "_angleA", "_ETA", "_pos"];

    private _gunner = gunner _taskUnit;
    private _turretPath = _taskUnit unitTurret _gunner;
    private _weapon = _taskUnit currentWeaponTurret _turretPath;

    _taskUnit setWeaponReloadingTime [_gunner,currentMuzzle _gunner, 0];
    _gunner forceWeaponFire [_weapon, _charge];
    // _taskUnit fire [_weapon, _charge];
  }, _this, _delay
] call CBA_fnc_waitAndExecute;