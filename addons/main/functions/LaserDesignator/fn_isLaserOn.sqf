params ["_unit"];

(({_unit isLaserOn _x} count (allTurrets _unit)) > 0) || (isLaserOn _unit)
