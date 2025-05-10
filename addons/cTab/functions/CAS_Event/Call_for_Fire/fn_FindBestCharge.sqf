/* 
	NAME : BCE_fnc_FindBestCharge
 */

// Function to find a firing angle that the unit can actually aim with.

params[
	"_taskUnit",
	"_chosenTargetPos",
	["_angleType","LOW"],
	"_longRangeGuided",
	
	"_chargesArrayLow",
	"_chargesArrayHigh",

	"_abort",
	"_endMission",
	"_checkFire"
];

//DIAG_LOG format ["UNIT: %1 - FIND BEST CHARGE - _this: %2", _taskUnit, _this];

_chosenTargetPos params ["_posX","_posY"];
private _chosenCharge = ["",0,0];
private _chargesArray = [];

private _angleText = if (_angleType == "HIGH") then {
	_chargesArray = _chargesArrayHigh;
	"HIGH"
} else {
	_chargesArray = _chargesArrayLow;
	"LOW"
};

//DIAG_LOG format ["UNIT: %1 - FIND BEST CHARGE - _chargesArrayHigh: %2", _taskUnit, _chargesArrayHigh];
//DIAG_LOG format ["UNIT: %1 - FIND BEST CHARGE - _chargesArrayLow: %2", _taskUnit, _chargesArrayLow];
//DIAG_LOG format ["UNIT: %1 - FIND BEST CHARGE - _chargesArray: %2", _taskUnit, _chargesArray];

private _array = [_taskUnit, _chosenTargetPos, _chargesArray, _posX, _posY, _angleText, _chosenCharge, _abort, _endMission, _checkFire] call BCE_Fnc_findCharge;
_array params ["_chosenCharge","_chargeFound","_abort","_endMission","_checkFire"];

// If no good charge was found, and not long range guided, then try the other angle type.
if (!_chargeFound && !_longRangeGuided && !_abort && !_endMission && !_checkFire) then {
	
	// It could be that no good charge was found because the AI got stuck and refused to aim.
	// So, try to make the AI unstuck, just in case.
	[_taskUnit,_chosenTargetPos] call T1AM_Fnc_UnstuckUnit;
	
	_angleText = if (_angleType == "HIGH") then {
		_chargesArray = _chargesArrayLow;
		"LOW"
	} else {
		_chargesArray = _chargesArrayHigh;
		"HIGH"
	};
	
	private _array = [_taskUnit, _posUnit, _chosenTargetPos, _chargesArray, _posX, _posY, _angleText, _chosenCharge, _chargeFound, _abort, _endMission, _checkFire] call BCE_Fnc_findCharge;
	_chosenCharge = _array # 0;
	_chargeFound = _array # 1;
	_abort = _array # 2;
	_endMission = _array # 3;
	_checkFire = _array # 4;
	
	//DIAG_LOG format ["UNIT: %1 - FIND BEST CHARGE - TRYING OTHER ANGLE - _chargesArray: %2", _taskUnit, _chargesArray];
};


switch true do {
	case (_abort || _endMission || _checkFire) : {
		_chosenCharge = ["",0,0,"",false,true];
		//DIAG_LOG format ["UNIT: %1 | FIND BEST CHARGE | ABORT | _chosenCharge: %2", _taskUnit, _chosenCharge];
	};
	case ((_chosenCharge # 0) == "") : {
		_chosenCharge = ["",0,0,"",false,false];
		//DIAG_LOG format ["UNIT: %1 | FIND BEST CHARGE | NOTHING CHOSEN | _chosenCharge: %2", _taskUnit, _chosenCharge];
	};
};

//DIAG_LOG format ["UNIT: %1 | FIND BEST CHARGE | END | _chosenCharge: %2 | _abort: %3 | _endMission: %4 | _checkFire: %5", _taskUnit, _chosenCharge, _abort, _endMission, _checkFire];

[_chosenCharge, _abort, _endMission, _checkFire]