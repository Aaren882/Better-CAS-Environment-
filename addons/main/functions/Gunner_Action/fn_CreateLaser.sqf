params["_veh","_mode","_unit"];

//Start~~~~~~~~~~~~~~~~~~~~~~~~

[_veh,_mode,_unit] call BCE_fnc_CreateLightSources;

_light = _unit getVariable "BCE_turret_Gunner_Laser";
_unit setVariable ["turret_Direction",vectorDir (_light # 0)];
