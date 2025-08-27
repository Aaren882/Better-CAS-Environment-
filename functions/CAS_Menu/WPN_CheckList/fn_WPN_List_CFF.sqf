params ["_checklist","_vehicle"];

private _result = createHashMap;
private _taskGroupId = groupId group _vehicle; 
private _group_vehs = _vehicle call BCE_fnc_getGroupVehicles;
_group_vehs = _group_vehs select {(alive gunner _x)};

private _magazineTypes = getArtilleryAmmo _group_vehs;

{
  private _veh = _x;
  private _newVehicle = true;
  private _unitCount_F = 0;
  private _magazines = magazinesAmmoFull _veh;

	// Store ammo amounts in ammo array. (forEach Veh)
  {
	_x params ["_magazine","_ammoCount"];
	if (_magazine in _magazineTypes) then {
	  private _value = _result getOrDefault [_magazine, []];
		private _displayName = [configFile >> "CfgMagazines" >> _magazine] call BIS_fnc_displayName;
		private _ammo = getText (configFile >> "CfgMagazines" >> _magazine >> "ammo");
		
		private _magazineCount = (_value param [1,0]) + 1;
		private _count = (_value param [2,0]) + _ammoCount;
		
		if (_newVehicle) then {
			private _unitCount = _value param [3,0]; //- Default = 1
			_unitCount_F = _unitCount + 1;
			_newVehicle = false;
		};
	
		_result set [
			_magazine, [
				_displayName,		//- DisplayName
				_magazineCount,	  //- Magazine Count (how many vehicles have this magazine)
				_count,			  //- Ammo Counts
				_unitCount_F,	 //- fireUnit Counts
				_ammo call BCE_fnc_CFF_getAmmoType // : Get the ammo type 
			]
		];  
	};
  } forEach _magazines;
} forEach _group_vehs;

{
  _y params ["_displayName","","_count"];

  private _add = _checklist lbAdd _displayName;
  _checklist lbSetTextRight [_add, format ["x%1",_count]];
  _checklist lbSetTooltip [_add, _x];
  _checklist lbSetData [_add, _x];
} forEach _result;

//- Save HashMap
_checklist setVariable ["CheckList", _result];

/*
	_result <HASHMAP> : [
		"magazineClass", [ : #NOTE - This is also saved in LB's DATA (easier to query)
			_displayName,    : DisplayName
			_magazineCount,  : Magazine Count (how many vehicles have this magazine)
			_count,          : Ammo Counts
			_unitCount_F     : fireUnit Counts
			_Type 					 : Type of ammo in CFF perspective
		]
	]
*/