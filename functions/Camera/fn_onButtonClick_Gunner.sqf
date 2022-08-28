params["_vehicle","_cameraview"];

_current_turret = ((player getVariable "TGP_View_Selected_Optic") # 0) # 1;
_turret_Unit = _vehicle turretUnit _current_turret;

//-Remote Unit
player remotecontrol _turret_Unit;
_turret_Unit switchcamera "gunner";

[{
  params ["_vehicle","_turret_Unit","_vehicleRole","_cameraview"];

  _current_turret = ((player getVariable "TGP_View_Selected_Optic") # 0) # 1;
  _turret_Unit_Now = _vehicle turretUnit _current_turret;

  /*if (inputAction "defaultAction" > 0) then {
    _weapon_info = weaponState [_vehicle,_current_turret];
    _turret_Unit_Now forceWeaponFire [_weapon_info # 1, _weapon_info # 2];
  }; */

  /* _distance = (getpos _vehicle) distance (screenToWorld [0.5,0.5]);
  _zeroing = floor (_distance / 50);
  _weapon_info = weaponState [_vehicle,_current_turret];
  _vehicle setWeaponZeroing [_weapon_info # 0, _weapon_info # 1, _zeroing]; */

  (!(isnull curatorcamera) or (_turret_Unit_Now != _turret_Unit) or !(alive _turret_Unit_Now) or !(alive player) or (player getVariable ["TGP_View_EHs",-1] == -1))
}, {
    params ["_vehicle","_turret_Unit","_vehicleRole","_cameraview"];

    _current_turret = ((player getVariable "TGP_View_Selected_Optic") # 0) # 1;
    _turret_Unit_Now = _vehicle turretUnit _current_turret;

    if (player getVariable ["TGP_View_Turret_Control",false]) then {
      objnull remotecontrol _turret_Unit;
      player remotecontrol _turret_Unit_Now;
      _turret_Unit_Now switchcamera "gunner";
      [_vehicle,_cameraview] call BCE_fnc_onButtonClick_Gunner;
    } else {
      if (isnull curatorcamera) then {
        objnull remotecontrol _turret_Unit_Now;
        player switchcamera _cameraview;
      };
    };
  }, [_vehicle,_turret_Unit,_vehicleRole,_cameraview]
] call CBA_fnc_waitUntilAndExecute;

//-Key Cap
player setVariable ["TGP_View_Turret_Control",true];
