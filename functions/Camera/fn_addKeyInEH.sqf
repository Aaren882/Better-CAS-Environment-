private ["_keyEH_1","_keyEH_2","_keyEH_3"];
_keyEH_1 = addUserActionEventHandler ["defaultAction", "Activate", {

  (player getVariable "TGP_View_Selected_Optic") params ["_turretInfo","_vehicle"];
  _current_turret = _turretInfo # 1;
  _turret_Unit = _vehicle turretUnit _current_turret;
  _weapon_info = weaponState [_vehicle,_current_turret];
  _weapon_info params ["_Weapon","_Muzzle","_mode"];

  if (((getNumber (configFile >> "CfgWeapons" >> _Weapon >> _mode >> "autoFire")) == 1) && !("laserdesignator" in (tolower _Weapon)) && !(isnil {_current_turret})) then {
    [{
      params ["_vehicle","_turret","_turret_Unit","_Weapon_old"];
      _current_turret = ((player getVariable "TGP_View_Selected_Optic") # 0) # 1;

      _weapon_info = weaponState [_vehicle,_current_turret];
      _weapon_info params ["_Weapon","_Muzzle","_mode"];

      //-Fire
      if(inputAction "defaultAction" > 0) then {
        _turret_Unit forceWeaponFire [_Muzzle, _mode];
      };

      (
        (_Weapon_old != _Weapon) or
        !(_turret isEqualTo _current_turret) or
        ((_turret_Unit getVariable ["TGP_View_Turret_Control",[]]) isEqualTo []) or
        ((player getVariable ["TGP_View_EHs",-1]) == -1)
      )
    }, {
      //- Stop
      }, [_vehicle,_current_turret,_turret_Unit,_Weapon]
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

_keyEH_3 = addUserActionEventHandler ["vehLockTurretView", "Activate", {
  (player getVariable "TGP_View_Selected_Optic") params ["_turretInfo","_vehicle"];

  _current_turret = _turretInfo # 1;
  _POS = [_vehicle,_current_turret] call BCE_fnc_Turret_InterSurface;

  _target = [
    objNull,
    AGLToASL _POS
  ] select (isnil{(_vehicle lockedCameraTo _current_turret)} && !isnil {_POS});

  _vehicle lockCameraTo [_target, _current_turret];
}];

[_keyEH_1,_keyEH_2,_keyEH_3]
