params["_unit"];
_lights = (_unit getVariable ["BCE_turret_Gunner_Lights",[]]) # 0;
_lights apply {deleteVehicle _x};
_unit setVariable ["BCE_turret_Gunner_Lights",[]];
