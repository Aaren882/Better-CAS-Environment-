params["_unit"];

_lights = (_unit getVariable ["BCE_turret_Gunner_Laser",[]]) # 0;
_lights apply {deleteVehicle _x};
_unit setVariable ["BCE_turret_Gunner_Laser",[]];

if (_unit getVariable ["BCE_GunnerLaser_PerF_EH",-1] != -1) then {
  removeMissionEventHandler ["EachFrame", _unit getVariable ["BCE_GunnerLaser_PerF_EH",-1]];
  _unit setVariable ["BCE_GunnerLaser_PerF_EH",-1];
};
