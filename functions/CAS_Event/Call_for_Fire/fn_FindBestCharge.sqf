/* 
	NAME : BCE_fnc_FindBestCharge
 */

// Function to find a firing angle that the unit can actually aim with.

params[
	"_taskUnit",
	"_chosenTargetPos",
	
	"_chargesArray"
];

[_taskUnit, _chosenTargetPos, _chargesArray] call BCE_Fnc_findCharge;
// _array params ["_chosenCharge"];

// If no good charge was found, and not long range guided, then try the other angle type.
/* if (!_chargeFound) then {
	
	// It could be that no good charge was found because the AI got stuck and refused to aim.
	// So, try to make the AI unstuck, just in case.
	[_taskUnit,_chosenTargetPos] call BCE_Fnc_UnstuckUnit;
	
	private _array = [_taskUnit, _chosenTargetPos, _chargesArray, _abort, _endMission, _checkFire] call BCE_Fnc_findCharge;
	_chosenCharge = _array # 0;
	_chargeFound = _array # 1;
	_abort = _array # 2;
	_endMission = _array # 3;
	_checkFire = _array # 4;
	
	//DIAG_LOG format ["UNIT: %1 - FIND BEST CHARGE - TRYING OTHER ANGLE - _chargesArray: %2", _taskUnit, _chargesArray];
}; */


/* switch true do {
	case (_abort || _endMission || _checkFire) : {
		_chosenCharge = ["",0,0,"",false,true];
	};
	case ((_chosenCharge # 0) == "") : {
		_chosenCharge = ["",0,0,"",false,false];
	};
};
 */
// [_chosenCharge, _abort, _endMission, _checkFire]