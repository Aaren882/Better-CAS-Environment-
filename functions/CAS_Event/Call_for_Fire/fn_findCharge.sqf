/*
  NAME : BCE_fnc_findCharge
*/

// maxDifference = 0.15;	// Ideal number.
// maxDifference = 1;			// Number that works better with the AI aiming bugs, mainly the one where the AI takes a while to aim at low angle shots.
#define MAX_DIFFERENCE 1

/* params[
	"_taskUnit",
	"_chosenTargetPos",
	"_chargesArray",
	["_abort",false],
	["_endMission",false],
	["_checkFire",false]
]; */

params[
	"_taskUnit",
	"_chosenTargetPos",
	"_chargesArray"
];

//- Check Charge exist
	if (_chargesArray findIf {true} < 0) exitWith {
		["CFF no Charge found ""_chargesArray"" = []; !!"] call BIS_fnc_error;
	};

_chosenTargetPos params ["_posX","_posY"];

// private _chargeFound = false;
// private _parents = [configOf _taskUnit, true] call BIS_fnc_returnParents;

// private _group = group _taskUnit;
private _gunner = gunner _taskUnit;
private _turretPath = (assignedVehicleRole _gunner) # 1;
private _turretConfig = [_taskUnit, _turretPath] call CBA_fnc_getTurret;

private _posUnit = getPosASL _taskUnit; 							// Point of angle A.
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
		[_charge, _angleA, _ETA, ASLtoAGL [_posX,_posY,_z]]
};

_taskUnit setVariable ["#CFF_Aim_Index",0];

[
	{
		params ["_args","_handlerID"];
		_args params[
			"_taskUnit",
			"_chosenTargetPos",
			"_aimPOS",
			"_cfgProps"
		];

		//- Check ARTY Exist
		if !(alive _taskUnit) exitWith {[_handlerID] call CBA_fnc_removePerFrameHandler};

		_cfgProps params ["_gunBeg","_gunEnd","_minElev","_maxElev"];

		//- Check ARTY Charge is able to find
		private _aimIndex = _taskUnit getVariable ["#CFF_Aim_Index",0];
		if (_aimIndex >= count _aimPOS) exitWith {
			hint "Unable to shoot (No charge were Found)!!";
			[_handlerID] call CBA_fnc_removePerFrameHandler;
		};

		//- Start with 0
			private _chargeFound = false;
			(_aimPOS # _aimIndex) params ["_charge", "_angleA", "_ETA", "_pos"];

		if (
			_angleA < _minElev ||	//- Over MIN
			_angleA > _maxElev 		//- Over MAX
		) exitWith {
			_taskUnit setVariable ["#CFF_Aim_Index", _aimIndex + 1];
		};

		// Make unit aim.
			(gunner _taskUnit) doWatch _pos;

		// Calculate the vertical angle of the unit by using triangle calculations.
			private _posUnit = getPosASLVisual _taskUnit;
			private _posA2 = _taskUnit modelToWorldVisualWorld (_taskUnit selectionPosition _gunBeg);
			private _posC2 = _taskUnit modelToWorldVisualWorld (_taskUnit selectionPosition _gunEnd);
			private _posB2 = [_posC2 # 0, _posC2 # 1, _posA2 # 2];
			
			private _adjacent = _posA2 vectorDistance _posB2;
			private _opposite = _posB2 vectorDistance _posC2;
			private _hypotenuse = _posA2 vectorDistance _posC2;
	
		//-  Law of Cosines
			private _verDegrees = acos((_adjacent^2 + _hypotenuse^2 - _opposite^2) / (2*_adjacent*_hypotenuse));
		
		// Find direction difference between the direction to the target and the direction of the unit.
		// If difference is too high, then skip this charge.
			private _dirToTarget = _posUnit getDirVisual _chosenTargetPos;
			private _aimDir = _posC2 getDirVisual _posA2;
			private _diff = (_aimDir - _dirToTarget) % 180;
			private _goodDir = abs _diff < 5; //- it's pointing correct direction
		
		// Check if the unit is aiming with the correct angle.
		// _angleA is the requested angle that the unit should aim with.
		// _verDegrees is the actual angle that the unit is aiming with at the moment.
		// MAX_DIFFERENCE is the maximum allowed difference between the above two.
		private _difference = abs(_angleA - _verDegrees);

		if (_goodDir && _difference < MAX_DIFFERENCE) then {
			_chosenCharge = _x;
			_chargeFound = true;

			_taskUnit setVariable ["#CFF_Aim_Index", _aimIndex + 1];
			
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
			
			// Obstructed.
			if (_lineIntersectsSurfaces findIf {true} > -1) then {
				_chargeFound = false;
			};
		};
		systemChat str ["CHECK : ",_goodDir, _difference < MAX_DIFFERENCE, _difference,_chargeFound,time];
		
		//- if _chargeFound Exit
		if (_chargeFound) exitWith {
			_taskUnit setVariable ["#CFF_Aim_Index", nil];
			[_charge, _taskUnit, 2] call BCE_fnc_doFireMission;
			[_handlerID] call CBA_fnc_removePerFrameHandler;
		};

		// [_chosenCharge, _chargeFound, _abort, _endMission, _checkFire]
	}, 1, [
		_taskUnit,
		_chosenTargetPos,
		_aimPOS, [
			getText(_turretConfig >> "gunBeg"),
			getText(_turretConfig >> "gunEnd"),
			getNumber(_turretConfig >> "minElev"),
			getNumber(_turretConfig >> "maxElev")
		]
	]
] call CBA_fnc_addPerFrameHandler;