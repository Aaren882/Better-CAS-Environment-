/* 
	NAME : BCE_fnc_FindBestCharge

	Finds the best charge for the artillery unit to fire at a given target position.
*/

params[
	"_taskUnit",
	"_chosenTargetPos",
	"_chargesArray"
];

_chosenTargetPos params ["_posX","_posY"];

private _gunner = gunner _taskUnit;
private _turretPath = (assignedVehicleRole _gunner) # 1;
private _turretConfig = [_taskUnit, _turretPath] call CBA_fnc_getTurret;

private _vecUp = vectorUp _taskUnit;
private _posUnit = getPosASL _taskUnit; 							// Point of angle A.

private _heightArtyToSeaLvl = _posUnit # 2;						// Height between triangle and sea level.
private _posC = [_posX, _posY, _heightArtyToSeaLvl];

private _minElev = getNumber(_turretConfig >> "minElev");
private _maxElev = getNumber(_turretConfig >> "maxElev");

//- Get AimPOS
private _chargeInfo = [];

{
	_x params ["_charge", "_angleA", "_ETA"];

	//- Get the ARTY surface angle between the target |/_
		private _degVehToAim = acos (_posC vectorCos _vecUp);
		private _pitchDeg = _degVehToAim - 90;
	
	if (
		_pitchDeg + _minElev > _angleA ||		//- unable Reach MIN
		_maxElev - _pitchDeg < _angleA 			//- unable Reach MAX
	) then {continue};

	// HYPOTENUSE * sin angleA [OPPOSITE/HYPOTENUSE] = OPPOSITE
		private _distanceAdj = _posUnit vectorDistance _posC;
		private _distanceOp = (_distanceAdj / cos _angleA) * (sin _angleA);
		private _z = _distanceOp + _heightArtyToSeaLvl;

	//- ARRAY of AGL POS
		private _pos = [_posX,_posY,_z];
		private _lineIntersectsSurfaces = lineIntersectsSurfaces [_posUnit, _pos, _taskUnit, objNull];
		
		// Check if there's an obstruction.
		// Draw a line from the barrel to a point 1000 meters down the barrel.
		// If target pos is closer than 1000m, then draw from the muzzle to the target pos.
		if (_lineIntersectsSurfaces findIf {true} > -1) then {
			(_lineIntersectsSurfaces # 0) params [["_intersectASL",_posUnit]];
			if ((_posUnit vectorDistance _intersectASL) > 1) then {continue};
		};

		_chargeInfo = _x + [ASLtoAGL _pos];
		break;
} forEach _chargesArray;

_chargeInfo