/*
	NAME : BCE_fnc_CFF_getAmmoType

	Returns the type of ammo based on its config class.

	Starts from simple types
	ex. "CLUSTER, "TRANS", "GUIDED", "HE", ""
*/

params ["_ammoClass"];

private _ammoType = [_ammoClass, true] call BCE_fnc_getAmmoType;

switch (_ammoType) do {
	case "CLUSTER": {"DPICM"}; //- #NOTE - Arma3 gernally is Dual-Purpose
	case "AT_MINE": {"RAAMS"};
	case "MINE": {"ADAM"};
	case "FLARE": {"Illumination"};
	case "GUIDED": {"CLGP"};
	default {_ammoType};
};
