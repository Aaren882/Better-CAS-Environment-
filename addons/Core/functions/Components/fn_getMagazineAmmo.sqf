/*
	NAME : BCE_fnc_getMagazineAmmo

	Params : 
		_magazine <String> : Name of the magazine

	Return :
		AmmoType <String> : Name of the ammo type used by the magazine
*/

params ["_magazine", ["_deepSearch",false]];

//- Find the ammo type 
	private _ammo = getText (configfile >> "CfgMagazines" >> _magazine >> "ammo");
	private _submunition = getText (configfile >> "CfgAmmo" >> _ammo >> "submunitionAmmo");

	while {_submunition != "" && _deepSearch} do {
		_ammo = _submunition;
	};

_ammo
