/* 
	NAME : BCE_fnc_getCharge
	
	Description :
	Function to create a list of charges + corresponding Angle + ETA + AimPos.
	
	Return 
	[
		_charge	: String - Name of the charge to use.
		_angleA	: Number - Angle in radians to fire the charge.
		_ETA		: Number - Estimated Time of Arrival in seconds.
		_AimPos : Array - Position to aim at, in AGL coordinates.
	]
*/

params ["_unit", "_magazineType", "_chosenTargetPos", ["_angleType",false], ["_weapon",""]];

private _chargesArray = call BCE_fnc_getAllCharges;
// diag_log "------------------------------------------";
// diag_log format ["PARAMS : %1", _this];
private _chargeInfo = [_unit,_chosenTargetPos,_chargesArray] call BCE_fnc_FindBestCharge;
// diag_log format ["_chargeInfo : %1", _chargeInfo];

_chargeInfo