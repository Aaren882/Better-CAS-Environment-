/* 
	NAME : BCE_fnc_FindBestCharge
 */

// Function to find a firing angle that the unit can actually aim with.

params[
	"_taskUnit",
	"_chosenTargetPos",
	"_chargesArray"
];


//- Check Charge exist
	if (
		_chargesArray findIf {true} < 0
	) exitWith {
		["CFF no Charge found ""_chargesArray"" = []; !!"] call BIS_fnc_error;
	};

private _posUnit = getPosASL _taskUnit;
private _taskUnit_DIR = vectorDir _taskUnit;
private _taskUnit_UP = vectorUp _taskUnit;

_chosenTargetPos params ["_posX","_posY"];
// [_taskUnit, _chosenTargetPos, _chargesArray] call BCE_Fnc_findCharge;

private _gunner = gunner _taskUnit;
private _turretPath = (assignedVehicleRole _gunner) # 1;
private _turretConfig = [_taskUnit, _turretPath] call CBA_fnc_getTurret;

private _cfgProps = [
	getText(_turretConfig >> "gun"),
	getText(_turretConfig >> "gunBeg"),
	getText(_turretConfig >> "gunEnd"),
	getNumber(_turretConfig >> "minElev"),
	getNumber(_turretConfig >> "maxElev")
];
_cfgProps params ["_gunAnim","_gunBeg","_gunEnd","_minElev","_maxElev"];


private _chargeFound = false;
private _heightArtyToSeaLvl = _posUnit # 2;						// Height between triangle and sea level.

//- Get AimPOS
	private _aimPOS = _chargesArray apply {
		_x params ["_charge", "_angleA", "_ETA"];

		// Calculate triangle opposite side. Add that to the height between the triangle and the sea level. 
			private _posC = [_posX, _posY, _heightArtyToSeaLvl];	// Point of angle C.
			private _distanceAdj = _posUnit vectorDistance _posC;	// Adjacent side

		// HYPOTENUSE * sin angleA [OPPOSITE/HYPOTENUSE] = OPPOSITE
			private _distanceOp = (_distanceAdj / cos _angleA) * (sin _angleA);	// Opposite side.
			private _z = _distanceOp + _heightArtyToSeaLvl;											// Add the two height numbers together to get the altitude above sea level.

		//- ARRAY of AGL POS
			_x pushBack (ASLtoAGL [_posX,_posY,_z]);
			_x
	};

//- Get the most possible solution
{
	_x params ["_charge", "_angleA", "_ETA", "_pos"];

	//- Check Vectors from _posUnit "VecUp" to "VecAim"
		private _vecToAim = _posUnit vectorFromTo _pos;
		private _degVehToAim = 90 - acos (_vecToAim vectorCos _taskUnit_UP);
	
	if (
		_degVehToAim < _minElev ||	//- Over MIN
		_degVehToAim > _maxElev 		//- Over MAX
	) then {continue};

	// Calculate the vertical angle of the unit by using triangle calculations.
		// private _posA2 = _taskUnit modelToWorldWorld (_taskUnit selectionPosition _gunBeg);
		// private _posC2 = _taskUnit modelToWorldWorld (_taskUnit selectionPosition _gunEnd);

	//- Get Turrect ELEV
	private _verDegrees = deg (_taskUnit animationPhase _gunAnim);
	
	// Check if the unit is aiming with the correct angle.
		private _difference = abs(_verDegrees - _degVehToAim);

	if (_difference < MAX_DIFFERENCE) then {
		_chosenCharge = _x;
		_chargeFound = true;

		// Check if there's an obstruction.
		// Draw a line from the barrel to a point 1000 meters down the barrel.
		// If target pos is closer than 1000m, then draw from the muzzle to the target pos.
		if (_distanceAdj > 1000) then {
			// Create the line starting from the beginning of the barrel to a point a 1000 meters out.
			// private _mult = 1000 / _adjacent;
			// private _x2 = ((_posC2 # 0) - (_posA2 # 0)) * _mult;
			// private _y2 = ((_posC2 # 1) - (_posA2 # 1)) * _mult;
			// private _z2 = ((_posC2 # 2) - (_posA2 # 2)) * _mult;
			// _pos = [(_posC2 # 0) - _x2, (_posC2 # 1) - _y2, (_posC2 # 2) - _z2];
		};
		private _lineIntersectsSurfaces = lineIntersectsSurfaces [_posA2, _pos, _taskUnit, objNull, true, 1];
		
		// Obstructed.
		if (_lineIntersectsSurfaces findIf {true} > -1) then {
			_chargeFound = false;
		};
	};
	
	//- if _chargeFound Exit
	if (_chargeFound) then {
		hintSilent str _chargeInfo;
		
		//- Exit Loop
		Break;
	};
} forEach _aimPOS;


if !(_chargeFound) exitWith {
	hint "Unable to shoot (No charge were Found)!!";
};