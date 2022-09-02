_keyEH_1 = addUserActionEventHandler ["defaultAction", "Activate", {

  _vehicle = player getVariable ["TGP_View_Selected_Vehicle",objNull];
  _current_turret = ((player getVariable "TGP_View_Selected_Optic") # 0) # 1;
  _turret_Unit = _vehicle turretUnit _current_turret;
  _weapon_info = weaponState [_vehicle,_current_turret];
  _Weapon = _weapon_info # 0;
  _Muzzle = _weapon_info # 1;
  _mode = _weapon_info # 2;

  if ((getNumber (configFile >> "CfgWeapons" >> _Weapon >> _mode >> "autoFire")) == 1) then {
    [{
      params ["_vehicle","_turret_Unit","_Weapon","_Muzzle","_mode"];
      _current_turret = ((player getVariable "TGP_View_Selected_Optic") # 0) # 1;

      //-Fire
      if(inputAction "defaultAction" > 0) then {
        _turret_Unit forceWeaponFire [_Muzzle, _mode];
      };

      (
        (_Weapon != (_vehicle currentWeaponTurret _current_turret)) or
        ((_turret_Unit getVariable ["TGP_View_Turret_Control",[]]) isEqualTo []) or
        ((player getVariable ["TGP_View_EHs",-1]) == -1)
      )
    }, {
      //- Stop
      }, [_vehicle,_turret_Unit,_Weapon,_Muzzle,_mode]
    ] call CBA_fnc_waitUntilAndExecute;
  } else {
    _turret_Unit forceWeaponFire [_Muzzle, _mode];
  };
}];

_keyEH_2 = addUserActionEventHandler ["gunElevAuto", "Activate", {
  [] spawn {
    //- Weapon
    _display = uiNameSpace getVariable "BCE_TGP";
    _WeaponDelay_ctrl = _display displayCtrl 1033;

    _WeaponDelay_ctrl ctrlShow true;
    uisleep 0.5;
    _WeaponDelay_ctrl ctrlShow false;
  };
}];

[_keyEH_1,_keyEH_2]
