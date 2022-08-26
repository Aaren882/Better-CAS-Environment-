IR_LaserLight_UnitList = (allUnits + vehicles) select {
  _unit = _x;

  if !((_unit getvariable ["IR_LaserLight_has_gunner",[false,["","",""],false,1]]) # 2) then {
    _turrets = allTurrets _unit;

    _turret_Weapons = flatten (
      _turrets apply {
        getArray (([_unit, _x] call BIS_fnc_turretConfig) >> "Weapons")
    });

    _has_gunner = true in (_turret_Weapons apply {(tolower "Laserdesignator") in tolower _x});

    //Get memory point
    if (_has_gunner) then {

      {
        _config = [_unit, _x] call BIS_fnc_turretConfig;
        _weapons = getArray (_config >> "Weapons");

        if (true in (_weapons apply {(tolower "Laserdesignator") in tolower _x})) then {

          _turret_pos_mem = getText (_config >> "memoryPointGunnerOptics");
          _turret_gunBeg_mem = getText (_config >> "gunBeg");
          _turret_gunEnd_mem = getText (_config >> "gunEnd");

          _unit setvariable ["IR_LaserLight_has_gunner",[true,[_turret_pos_mem,_turret_gunBeg_mem,_turret_gunEnd_mem],true,_forEachIndex]];
        };
      } forEach _turrets;
    };
  };

  //Conditions
  (
    (isLaserOn _unit) &&
    alive _unit
  )
};
