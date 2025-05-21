/*
	NAME : BCE_fnc_getAllCharges

	Description :
	Function to create a list of charges + corresponding Angle and ETA.
	It will only include charges that can reach the target pos.
*/

params ["_unit", "_magazineType", "_chosenTargetPos", ["_angleType",false], ["_weapon",""]];

if (_weapon == "") then {
	private _turretPath = (assignedVehicleRole (gunner _unit)) # 1;
	_weapon = _unit currentWeaponTurret _turretPath;
};

private _g = 9.8066; //- 9.8066 , 9.78
private _profile = [-1,1] select _angleType; //- [LOW, HIGH]
private _unitPOS = getPosASL _unit;

private _distance = _unitPOS distance2D _chosenTargetPos;
private _alt = (_chosenTargetPos # 2) - (_unitPOS # 2);		// Altitude difference

private _WPN_Cfg = configfile >> "CfgWeapons" >> _weapon;
private _ammoInitSpeed = getNumber(configfile >> "CfgMagazines" >> _magazineType >> "initSpeed");

private _chargesArray = [];
{
	private _charge = _x;
	private _config = _WPN_Cfg >> _charge;
	if (getNumber (_config >> "showToPlayer") == 1) then {

		private _vel = _ammoInitSpeed * getNumber(_config >> "artilleryCharge");
		private _calc = _vel^4 - _g*(_g * _distance^2 + 2*_alt*_vel^2);
		
		if (_calc < 0) exitWith {};
		
		// Angle
		private _A = atan ((_vel^2 + (_profile * sqrt _calc)) / (_g*_distance));
		
		// ETA
		// private _ETA = _distance / (_vel* cos(_A));
		private _ETA = (2 * _vel * sin _A) / _g;
		
		_chargesArray pushback [_charge, _A, _ETA];
	};
} forEach getArray (_WPN_Cfg >> "modes");

_chargesArray