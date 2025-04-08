params ["_checklist","_vehicle"];

private _result = createHashMap;
private _taskGroupId = groupId group _vehicle; 
private _group_vehs = (units _vehicle) apply {vehicle _x}; 
_group_vehs = _group_vehs ArrayIntersect _group_vehs;

{
  private _veh = _x;
  private _magazines = magazinesAmmo _veh;

  // Create a list of all magazine types.
  // Also create a list of ammo numbers with same index (make them all 0 for now).
  private _magazineTypes = [];
  {
    private _magazine = _x # 0;
    if !(_magazine in _magazineTypes) then {
      _magazineTypes pushback _magazine;
    };
  } forEach _magazines;

  // Store ammo amounts in ammo array. (forEach Veh)
  {
    private _magazine = _x;
    {
      if (_magazine == (_x # 0)) then {
        private _value = _result getOrDefault [_magazine, []];
        private _displayName = [configFile >> "CfgMagazines" >> _magazine] call BIS_fnc_displayName;
        
        private _magazineCount = (_value param [1,0]) + 1;
        private _count = (_value param [2,0]) + (_x # 1);

        _result set [
          _magazine, [
            _displayName,    //- DisplayName
            _magazineCount,  //- Magazine Count (how many vehicles have this magazine)
            _count           //- Ammo Counts
          ]
        ];
      };
    } forEach _magazines;
  } forEach _magazineTypes;
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