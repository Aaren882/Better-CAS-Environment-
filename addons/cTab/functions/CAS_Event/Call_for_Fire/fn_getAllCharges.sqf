/*
	NAME : BCE_fnc_getAllCharges
*/

// Function to create a list of charges + corresponding Angle and ETA.
// It will only include charges that can reach the target pos.

params ["_unit", "_weapon", "_magazineType", "_distance", "_alt"];

private _ammoInitSpeed = getNumber(configfile >> "CfgMagazines" >> _magazineType >> "initSpeed");
private _chargesArrayLow = [];
private _chargesArrayHigh = [];
private = configProperties [
	configfile >> "CfgWeapons" >> _weapon,
	"isClass (_x) && 1 == getNumber(_x >> 'showToPlayer')",
	true
];
// private _vel = 0;

//DIAG_LOG format["UNIT: %1 - CHARGES - _magazineType: %2", _unit, _magazineType];
//DIAG_LOG format["UNIT: %1 - CHARGES - _ammoInitSpeed: %2", _unit, _ammoInitSpeed];

{
	private _charge = _x;
	
	// if (getNumber (configfile >> "CfgWeapons" >> _weapon >> _charge >> "showToPlayer") == 1) then {
		
		private _vel = _ammoInitSpeed * getNumber(configfile >> "CfgWeapons" >> _weapon >> _charge >> "artilleryCharge");
		private _g = 9.78;
		private _calc = _vel^4-_g*(_g*_distance^2+2*_alt*_vel^2);
		//DIAG_LOG format["UNIT: %1 - CHARGE: %2 - _calc: %3", _unit, _charge, _calc];
		if (_calc < 0) exitWith {
			//DIAG_LOG format ["UNIT: %1 | IMPOSSIBLE _calc | _charge: %2 | _vel: %3 | _calc: %4", _unit, _charge, _vel, _calc];
		};
		
		// Angle
		private _hA = atan((_vel^2+sqrt _calc) / (_g*_distance));
		private _lA = atan((_vel^2-sqrt _calc) / (_g*_distance));
		
		// ETA
		private _hETA = _distance/(_vel*cos(_hA));
		private _lETA = _distance/(_vel*cos(_lA));
		
		_chargesArrayLow pushback [_charge, _lA, _lETA];
		_chargesArrayHigh pushback [_charge, _hA, _hETA];
		
		//DIAG_LOG format ["UNIT: %1 - CHARGE ADDED: %2 -- VELOCITY: %3 -- HIGH ANGLE: %4 -- HIGH ETA: %5 -- LOW ANGLE: %6 -- LOW ETA: %7", _unit, _charge, _vel, _hA, _hETA, _lA, _lETA];
	// };
	
} forEach (getArray (configfile >> "CfgWeapons" >> _weapon >> "modes"));
// } forEach (getArray (configfile >> "CfgWeapons" >> _weapon >> "modes"));


[_chargesArrayLow, _chargesArrayHigh, _vel]