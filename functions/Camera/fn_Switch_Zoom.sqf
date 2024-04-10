params ["_mode"];

if ((player getVariable ["TGP_View_EHs", -1]) != -1) then {
  private ["_config","_FOVs","_FOV"];

  (call BCE_fnc_getTurret) params ["_cam","_vehicle","_Optic_LODs","_current_turret"];
  (_Optic_LODs # _current_turret) params ["","_turret"];

  _config = if ((_turret # 0) < 0) then {
    configOf _vehicle >> "PilotCamera" >> "OpticsIn"
  } else {
    [_vehicle, _turret] call BIS_fnc_turretConfig >> "OpticsIn"
  };
  

  _FOVs = ("true" configClasses _config) apply {
    if (isText (_x >> "initFov")) then {
      call compile getText(_x >> "initFov")
    } else {
      getNumber(_x >> "initFov")
    };
  };

  _FOVs sort false;
  _FOV = _FOVs find (localNamespace getVariable ["TGP_View_Camera_FOV",_FOVs # 0]);
  
  _FOV = switch _mode do {
    case 1: {
      _FOV + 1
    };
    case -1: {
      _FOV - 1
    };
    default {
      [_FOV,0] select (_FOV < 0);
    };
  };
  
  //- dont cycle through entire FOVs
  if (_FOV >= count _FOVs || _FOV < 0) exitWith {};

  _FOV = _FOVs # _FOV;
  _cam camSetFov _FOV;
  localNamespace setVariable ["TGP_View_Camera_FOV", _FOV];
};