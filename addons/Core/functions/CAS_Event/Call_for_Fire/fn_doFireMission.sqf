/*
  NAME : BCE_fnc_doFireMission

	Must under suspend environment (Spawn)
*/
params ["_chargeInfo","_taskUnit",["_delay",-1]];

if (_delay < 0) then {
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

// diag_log "--------------------------";
// diag_log format ["doFireMission : DELAY = %1", _delay];

sleep _delay; //- Reload Delay

//- Check MSN exist + Permission state
	if (
		"" == (["CFF_MSN","",_taskUnit] call BCE_fnc_get_CFF_Value) ||
		!(["CFF_STATE",false,_taskUnit] call BCE_fnc_get_CFF_Value)
	) exitWith {};

	_chargeInfo params ["_charge"];

	private _gunner = gunner _taskUnit;
	private _turretPath = _taskUnit unitTurret _gunner;
	private _weapon = _taskUnit currentWeaponTurret _turretPath;
	// diag_log format ["UNIT : _taskUnit = %1, _turretPath = %2", _taskUnit, _turretPath];
	
	_taskUnit setWeaponReloadingTime [_gunner,currentMuzzle _gunner, 0];
	// diag_log format ["FIRE : _gunner = %1, Params = %2", _gunner, [_weapon, _charge]];

	//- Use the saved weapon otherwise.
	// _gunner forceWeaponFire [_weapon, _charge];
	[_gunner, [_weapon, _charge]] remoteExecCall ["forceWeaponFire",_gunner,true];
	
	// _taskUnit fire [_weapon, _charge];
/* [
  {

    
  }, _this, _delay
] call CBA_fnc_waitAndExecute; */
