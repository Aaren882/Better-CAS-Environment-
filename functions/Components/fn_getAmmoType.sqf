/*
	NAME : BCE_fnc_getAmmoType

	Returns the type of ammo based on its config class.

	Starts from simple types
	ex. "CLUSTER, "TRANS", "GUIDED", "HE", ""
*/

params ["_ammoClass",["_deepSearch",false]];

private _config = configfile >> "CfgAmmo" >> _ammoClass;
private _submunition = [_config,"submunitionAmmo",""] call BIS_fnc_returnConfigEntry;
private _simulation = toLowerANSI getText (_config >> "simulation");

//- Has submunition
if (_submunition isNotEqualTo "") exitWith {
		
	//- CLUSTER
	if (
		_submunition isEqualType [] || //- #NOTE - Force Return if the submunitionAmmo is Mixed
		(
			!_deepSearch &&
			"shotsubmunitions" == _simulation
		)
	) exitWith {
		"CLUSTER"
	};

	//- HEAT
	if (1 == getNumber (_config >> "triggerOnImpact")) exitWith {
		"HEAT"
	};

	//- #NOTE - Peek the "_submunition" (Recursive)
	private _return = "TRANS"; //- #NOTE - the "_ammoClass" just transform into other munition
	if (_deepSearch) then {
		_return = [_submunition,_deepSearch] call BCE_fnc_getAmmoType;
	};

	_return
};


//- Deployables like Mines
if ("shotmine" == _simulation) exitWith {
	private _trigger = getText (_config >> "mineTrigger");
	private _mass = getNumber (configFile >> "CfgMineTriggers" >> _trigger >> "mineTriggerMass");
	
	//- More then 5 tons
	if (_mass > 5000) exitWith {
		"AT_MINE"
	};

	"MINE"
};

//- SMOKE
if ("shotsmoke" == _simulation) exitWith {
	"SMOKE"
};

//- Flares
if ("shotilluminating" == _simulation) exitWith {
	"FLARE"
};

//- GUIDED
	private _lockSystem = [_config, "weaponLockSystem",""] call BIS_fnc_returnConfigEntry;
	if (
		"" isNotEqualTo _lockSystem ||
		0 isNotEqualTo _lockSystem
	) exitWith {
		_lockSystem = nil;
		"GUIDED"
	};

//- HE
if (0.5 < getNumber (_config >> "explosive")) exitWith {
	"HE"
};

//- Default Return
""