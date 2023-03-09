params["_unit"];

deleteVehicle ((_unit getVariable ["BCE_turret_Gunner_Laser",[]]) # 0);
_unit setVariable ["BCE_turret_Gunner_Laser",[],true];
_unit setVariable ["turret_Direction",[0,0,0]/*,true*/];

/* if (_unit getVariable ["BCE_GunnerLaser_PerF_EH",-1] != -1) then {
  removeMissionEventHandler ["EachFrame", _unit getVariable ["BCE_GunnerLaser_PerF_EH",-1]];
  _unit setVariable ["BCE_GunnerLaser_PerF_EH",-1];
}; */
