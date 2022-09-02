params["_vehicle","_cameraview"];

_current_turret = ((player getVariable "TGP_View_Selected_Optic") # 0) # 1;
_turret_Unit = _vehicle turretUnit _current_turret;

//-Remote Unit
player remotecontrol _turret_Unit;
_turret_Unit switchcamera "gunner";

//-Key Cap
_keyEHs = call BCE_fnc_addKeyInEH;
_turret_Unit setVariable ["TGP_View_Turret_Control",_keyEHs,true];

[{
  params ["_vehicle","_turret_Unit","_vehicleRole","_cameraview"];

  _current_turret = ((player getVariable "TGP_View_Selected_Optic") # 0) # 1;
  _turret_Unit_Now = _vehicle turretUnit _current_turret;

  /* _distance = (getpos _vehicle) distance (screenToWorld [0.5,0.5]);
  _zeroing = floor (_distance / 50);
  _weapon_info = weaponState [_vehicle,_current_turret];
  _vehicle setWeaponZeroing [_weapon_info # 0, _weapon_info # 1, _zeroing]; */

  (!(isnull curatorcamera) or (_turret_Unit_Now != _turret_Unit) or !(alive _turret_Unit) or !(alive player) or (player getVariable ["TGP_View_EHs",-1] == -1))
}, {
    params ["_vehicle","_turret_Unit","_vehicleRole","_cameraview"];

    _current_turret = ((player getVariable "TGP_View_Selected_Optic") # 0) # 1;
    _turret_Unit_Now = _vehicle turretUnit _current_turret;

    if ((isnull curatorcamera) && (player getVariable ["TGP_View_EHs",-1] != -1)) then {
      objnull remotecontrol _turret_Unit;
      player remotecontrol _turret_Unit_Now;
      _turret_Unit_Now switchcamera "gunner";
      removeUserActionEventHandler ["defaultAction", "Activate", ((_turret_Unit getVariable "TGP_View_Turret_Control") # 0)];
      removeUserActionEventHandler ["gunElevAuto", "Activate", ((_turret_Unit getVariable "TGP_View_Turret_Control") # 1)];
      _turret_Unit setVariable ["TGP_View_Turret_Control",[],true];

      [_vehicle,_cameraview] call BCE_fnc_onButtonClick_Gunner;

    } else {
      objnull remotecontrol _turret_Unit_Now;
      player switchcamera _cameraview;
      removeUserActionEventHandler ["defaultAction", "Activate", ((_turret_Unit getVariable "TGP_View_Turret_Control") # 0)];
      removeUserActionEventHandler ["gunElevAuto", "Activate", ((_turret_Unit getVariable "TGP_View_Turret_Control") # 1)];
      _turret_Unit setVariable ["TGP_View_Turret_Control",[],true];
    };

  }, [_vehicle,_turret_Unit,_vehicleRole,_cameraview]
] call CBA_fnc_waitUntilAndExecute;
