/*
  NAME : BCE_fnc_findCharge
*/

params["_taskUnit", "_chosenTargetPos", "_chargesArray", "_x1", "_y", "_angleText", "_chosenCharge", "_abort", "_endMission", "_checkFire"];

private _chargeFound = false;
private _parents = [configOf _taskUnit, true] call BIS_fnc_returnParents;

private _gunner = gunner _unit;
private _group = group _taskUnit;

private _posUnit = getPosASL _taskUnit;
private _posC = [_chosenTargetPos # 0, _chosenTargetPos # 1, _posUnit # 2];	// Point of angle C.
private _distanceAdj = _posUnit vectorDistance _posC;										// Adjacent side

{
	//DIAG_LOG format["UNIT: %1 | FIND CHARGE | FOREACH START | _this: %2", _taskUnit, _this];
	
	// Calculate triangle opposite side. Add that to the height between the triangle and the sea level. 
	private _angleA = _x # 1;	// Angle A.
	
	//private _maxDifference = 0.15;	// Ideal number.
	private _maxDifference = 1;			// Number that works better with the AI aiming bugs, mainly the one where the AI takes a while to aim at low angle shots.
	
	//      _posUnit = getPosASL _taskUnit;														// Point of angle A.
	//      _angleC = 90;																	// Angle C. C is always 90.
	private _angleB = 180 - 90 - _angleA;													// Angle B.
	private _distanceOp = (_distanceAdj / sin _angleB) * (sin _angleA);						// Opposite side.
	private _heightArtyToSeaLvl = _posUnit # 2;											// Height between triangle and sea level.
	private _z = _distanceOp + _heightArtyToSeaLvl;											// Add the two height numbers together to get the altitude above sea level.
	
	//DIAG_LOG format["UNIT: %1 | FIND CHARGE | CHARGE: %2", _taskUnit, _x];
	//DIAG_LOG format["UNIT: %1 | FIND CHARGE | _angleA: %2", _taskUnit, _angleA];
	//DIAG_LOG format["UNIT: %1 | FIND CHARGE | _posUnit: %2", _taskUnit, _posUnit];
	//DIAG_LOG format["UNIT: %1 | FIND CHARGE | _posC: %2", _taskUnit, _posC];
	//DIAG_LOG format["UNIT: %1 | FIND CHARGE | _distanceAdj: %2", _taskUnit, _distanceAdj];
	//DIAG_LOG format["UNIT: %1 | FIND CHARGE | _angleB: %2", _taskUnit, _angleB];
	//DIAG_LOG format["UNIT: %1 | FIND CHARGE | _distanceOp: %2", _taskUnit, _distanceOp];
	//DIAG_LOG format["UNIT: %1 | FIND CHARGE | _heightArtyToSeaLvl: %2", _taskUnit, _heightArtyToSeaLvl];
	//DIAG_LOG format["UNIT: %1 | FIND CHARGE | _x1: %2", _taskUnit, _x1];
	//DIAG_LOG format["UNIT: %1 | FIND CHARGE | _y: %2", _taskUnit, _y];
	//DIAG_LOG format["UNIT: %1 | FIND CHARGE | _z: %2", _taskUnit, _z];
	
	private _pos = [_x1,_y,_z];
	
	// Make unit aim.
	_gunner doWatch (ASLtoAGL _pos);
	
	// Wait until the unit stops moving/aiming by comparing its aiming vector every 0.25 second.
	private _lastWVD = _taskUnit weaponDirection currentWeapon _taskUnit;
	private _wvd = [];
	sleep 0.25;
	private _abortTime = time + 55;
	while {true} do {
		_wvd = _taskUnit weaponDirection currentWeapon _taskUnit;
		_wvd = [_wvd] call T1AM_Fnc_FindCharge_RemoveDigits;
		_lastWVD = [_lastWVD] call T1AM_Fnc_FindCharge_RemoveDigits;
		if (_lastWVD isEqualTo _wvd or time > _abortTime) exitWith {
			//DIAG_LOG format ["UNIT: %1 | FIND CHARGE MOVING LOOP EXIT | Time: %2 | If: %3 | _wvd: %4 | _lastWVD: %5 | Aborted: %6", _taskUnit, time, (_lastWVD isEqualTo _wvd), _wvd, _lastWVD, time > _abortTime];
		};
		//DIAG_LOG format ["UNIT: %1 | FIND CHARGE MOVING LOOP | Time: %2 | If: %3 | _wvd: %4 | _lastWVD: %5", _taskUnit, time, (_lastWVD isEqualTo _wvd), _wvd, _lastWVD];
		_lastWVD = _wvd;
		sleep 0.25;
		
		// Check if need to abort.
      _abort = [_taskUnit, _gunner] call T1AM_Fnc_CheckGroupStatus;
      if (_abort) exitWith {};
      
      private _group = group _taskUnit;
      if (_group getVariable ["T1AM_endMission", false]) exitWith {_endMission = true};
      if (_group getVariable ["T1AM_checkFire", false]) exitWith {_checkFire = true};
	};
	
	if (_abort or _endMission or _checkFire) exitWith {};
	
	sleep 0.5;
	
	// Calculate the vertical angle of the unit by using triangle calculations.
	private _turretPath = (assignedVehicleRole _gunner) select 1;
	private _turretConfig = [_taskUnit, _turretPath] call CBA_fnc_getTurret;
	private _logicStart = "logic" createVehicleLocal [0,0,0];
	_logicStart attachTo [_taskUnit, [0,0,0], getText(_turretConfig >> "gunBeg")];
	private _logicEnd = "logic" createVehicleLocal [0,0,0];
	_logicEnd attachTo [_taskUnit, [0,0,0], getText(_turretConfig >> "gunEnd")];
	private _posA2 = getPosASL _logicStart;
	private _posC2 = getPosASL _logicEnd;
	private _posB2 = [_posC2 select 0, _posC2 select 1, _posA2 select 2];
	private _adjacent = _posA2 vectorDistance _posB2;
	private _opposite = _posB2 vectorDistance _posC2;
	private _hypotenuse = _posA2 vectorDistance _posC2;
	private _verDegrees = acos((_adjacent^2 + _hypotenuse^2 - _opposite^2) / (2*_adjacent*_hypotenuse));
	deleteVehicle _logicStart;
	deleteVehicle _logicEnd;
	
	// Find direction difference between the direction to the target and the direction of the unit.
	// If difference is too high, then skip this charge.
	private _dirToTarget = _posUnit getDir _posC;
	private _aimDir = _posC2 getDir _posA2;
	private _diff = abs (_aimDir - _dirToTarget);
	if (_diff > 180) then {
		_diff = 360 - _diff;
	};
	private _goodDir = true;
	if (_diff > 5) then {_goodDir = false};
	
	//DIAG_LOG format ["UNIT: %1 | FIND CHARGE | _dirToTarget: %2", _taskUnit, _dirToTarget];
	//DIAG_LOG format ["UNIT: %1 | FIND CHARGE | _aimDir: %2", _taskUnit, _aimDir];
	//DIAG_LOG format ["UNIT: %1 | FIND CHARGE | _diff: %2", _taskUnit, _diff];
	//DIAG_LOG format ["UNIT: %1 | FIND CHARGE | _goodDir: %2", _taskUnit, _goodDir];
	
	// The vanilla MRLS truck has a bug where it appears to aim lower than it actually does.
	// So, increase the _verDegrees to make the unit appear to aim higher.
	private _realVerDegrees = _verDegrees;
	if (_goodDir && "Truck_02_MRL_base_F" in _parents) then {
		switch true do {
			case (_verDegrees >= 60) : {_verDegrees = _verDegrees * 1.0908};
			case (_verDegrees >= 55) : {_verDegrees = _verDegrees * 1.091};
			case (_verDegrees >= 50) : {_verDegrees = _verDegrees * 1.09116};
			case (_verDegrees >= 45) : {_verDegrees = _verDegrees * 1.0912};
			case (_verDegrees >= 40) : {_verDegrees = _verDegrees * 1.09142};
			case (_verDegrees >= 35) : {_verDegrees = _verDegrees * 1.09175};
			case (_verDegrees >= 30) : {_verDegrees = _verDegrees * 1.0922};
			case (_verDegrees >= 25) : {_verDegrees = _verDegrees * 1.0929};
			case (_verDegrees >= 20) : {_verDegrees = _verDegrees * 1.0939};
			case (_verDegrees >= 15) : {_verDegrees = _verDegrees * 1.0954};
			case (_verDegrees >= 10) : {_verDegrees = _verDegrees * 1.0984};
			case (_verDegrees >= 7.5) : {_verDegrees = _verDegrees * 1.1014};
			case (_verDegrees >= 5) : {_verDegrees = _verDegrees * 1.1075};
			case (_verDegrees >= 3) : {_verDegrees = _verDegrees * 1.1196};
			case (_verDegrees >= 2) : {_verDegrees = _verDegrees * 1.1349};
			case (_verDegrees >= 1) : {_verDegrees = _verDegrees * 1.181};
			default {_verDegrees = _verDegrees * 1.3};
		};
		// The unit aims too low when pitching/banking, so try to compensate for that too.
		private _pitch = abs ((_taskUnit call BIS_fnc_getPitchBank) select 0);
		_verDegrees = _verDegrees * ((100 - (_pitch * 0.19)) / 100);
		_verDegrees = _verDegrees min 89.999;
		// My calculation is not precise enough. So, increase the error tolerance.
		_maxDifference = 2;
	};
	
	//DIAG_LOG format["UNIT: %1 | FIND CHARGE | _realVerDegrees: %2", _taskUnit, _realVerDegrees];
	//DIAG_LOG format ["UNIT: %1 | FIND BEST CHARGE | FIND CHARGE | CHARGE: %2 | _angleA: %3 | _verDegrees: %4 | abs(_angleA-_verDegrees): %5", _taskUnit, _x select 0, _angleA, _verDegrees, abs(_angleA - _verDegrees)];
	//DIAG_LOG format ["UNIT: %1 | FIND BEST CHARGE | FIND CHARGE | WORLD: %2 | _maxDifference: %3", _taskUnit, worldName, _maxDifference];
	
	// Check if the unit is aiming with the correct angle.
	// _angleA is the requested angle that the unit should aim with.
	// _verDegrees is the actual angle that the unit is aiming with at the moment.
	// _maxDifference is the maximum allowed difference between the above two.
	private _difference = abs(_angleA - _verDegrees);
	if (_goodDir && _difference < _maxDifference && _difference > -_maxDifference) then {
		_chosenCharge = _x;
		_chargeFound = true;
		_chosenCharge pushback _angleText;
		
		//DIAG_LOG format ["UNIT: %1 | FIND BEST CHARGE | FIND CHARGE | _chosenCharge: %2", _taskUnit, _chosenCharge];
		
		// Check if there's an obstruction.
		// Draw a line from the barrel to a point 1000 meters down the barrel.
		// If target pos is closer than 1000m, then draw from the muzzle to the target pos.
		if (_distanceAdj > 1000) then {
			// Create the line starting from the beginning of the barrel to a point a 1000 meters out.
			private _mult = 1000 / _adjacent;
			private _x2 = ((_posC2 # 0) - (_posA2 # 0)) * _mult;
			private _y2 = ((_posC2 # 1) - (_posA2 # 1)) * _mult;
			private _z2 = ((_posC2 # 2) - (_posA2 # 2)) * _mult;
			_pos = [(_posC2 # 0) - _x2, (_posC2 # 1) - _y2, (_posC2 # 2) - _z2];
		};
		private _lineIntersectsSurfaces = lineIntersectsSurfaces [_posA2, _pos, _taskUnit, objNull, true, 1];
		
		//DIAG_LOG format ["UNIT: %1 | FIND BEST CHARGE | _pos: %2", _taskUnit, _pos];
		//DIAG_LOG format ["UNIT: %1 | FIND BEST CHARGE | _lineIntersectsSurfaces: %2", _taskUnit, _lineIntersectsSurfaces];
		
		// Obstructed.
		private _obstructed = false;
		if (count _lineIntersectsSurfaces > 0) then {
			_obstructed = true;
			_chargeFound = false;
			//DIAG_LOG format ["UNIT: %1 | FIND BEST CHARGE | OBSTRUCTED | _chosenCharge: %2", _taskUnit, _chosenCharge];
		};
		
		_chosenCharge pushback _obstructed;
	};
	
	if (_chargeFound) exitWith {
		//DIAG_LOG format["UNIT: %1 | FIND CHARGE | CHARGE FOUND", _taskUnit];
	};
	
	//DIAG_LOG format["UNIT: %1 | FIND CHARGE | FOREACH END", _taskUnit];
	
} forEach _chargesArray;

//DIAG_LOG format["UNIT: %1 | FIND CHARGE | END | _chosenCharge: %2 | _chargeFound: %3 | _abort: %4 | _endMission: %5 | _checkFire: %6", _taskUnit, _chosenCharge, _chargeFound, _abort, _endMission, _checkFire];

[_chosenCharge, _chargeFound, _abort, _endMission, _checkFire];