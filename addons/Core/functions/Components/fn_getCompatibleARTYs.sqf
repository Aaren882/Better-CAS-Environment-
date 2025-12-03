/* 
  NAME : BCE_fnc_getCompatibleARTYs
*/

/* private _vehs = [];
{
  if (
    (_x isKindOf "LandVehicle") && 
    (playerSide == side _x)
  ) then {
    private _grp = group _x;
    _vehs pushBackUnique [_grp, groupId _grp];
  };
  false
} count vehicles;

_vehs */

private _groups = [];
private _result = [];
private _list = vehicles Select {
  (getArtilleryAmmo [_x]) findIf {true} > -1 &&
  (alive gunner _x) &&
  (playerSide == side _x)
};

{
	private _grp = group _x;
	if !(_grp in _groups) then {
		_result pushBack _x;
		_groups pushBack _grp;
	};
} forEach _list;

_result
