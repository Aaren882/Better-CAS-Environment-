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

//- Use for grabbing vehicle initial aimed deg
private _typeOf = typeOf _taskUnit;
private _cache = localNameSpace getVariable ["#BCE_CFF_Vehicle_Cache", createHashMap];

//- Create cache for getting correct the elevation limits
	if !(_typeOf in _cache) then {
		private _temp = createVehicleLocal [_typeOf, [0,0,-1000], [], 0, "CAN_COLLIDE"];
		_temp allowDamage false;

		private _gunner = gunner _taskUnit;
		private _turretPath = (assignedVehicleRole _gunner) # 1;
		private _turretConfig = [_taskUnit, _turretPath] call CBA_fnc_getTurret;
		
		private _initElev = getNumber(_turretConfig >> "initElev");
		private _minElev = getNumber(_turretConfig >> "minElev");
		private _maxElev = getNumber(_turretConfig >> "maxElev");
		
		//- Get barral selection
			private _gunBeg = getText(_turretConfig >> "gunBeg");
			private _gunEnd = getText(_turretConfig >> "gunEnd");
			private _posA2 = _temp modelToWorldWorld (_temp selectionPosition _gunBeg);
			private _posC2 = _temp modelToWorldWorld (_temp selectionPosition _gunEnd);
			private _barrelDir = _posC2 vectorFromTo _posA2;

		//- #NOTE - Get the real 0 degree from the temp model
		private _startElev = acos ((vectorDir _temp) vectorCos _barrelDir);
		_startElev = _startElev - _initElev;
		
		//- [_initElev == _startElev]
		_cache set [_typeOf, [_startElev + _minElev, _startElev + _maxElev]];

		deleteVehicle _temp;
		localNameSpace setVariable ["#BCE_CFF_Vehicle_Cache", _cache];
	};

(_cache get _typeOf) params ["_minElev","_maxElev"];

private _vecUp = vectorUp _taskUnit;
private _posUnit = getPosASL _taskUnit; 							// Point of angle A.

private _heightArtyToSeaLvl = _posUnit # 2;						// Height between triangle and sea level.
private _posC = [_posX, _posY, _heightArtyToSeaLvl];

//- Get the ARTY surface angle between the target |/_
// * Calculate pitch angle: vehicle's up vector angle to target minus 90 degrees
// * This gives us the required elevation angle relative to the vehicle's orientation
private _degVehToAim = acos (_posC vectorCos _vecUp);
private _pitchDeg = _degVehToAim - 90;

//- Get AimPOS
private _chargeInfo = [];

{
	_x params ["_charge", "_angleA", "_ETA"];

	//- Check if the required angle is within the turret's elevation limits
	// * accounting for the vehicle's current pitch
	if (
		_pitchDeg + _minElev > _angleA ||        //- unable Reach MIN
		_maxElev - _pitchDeg < _angleA           //- unable Reach MAX
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
