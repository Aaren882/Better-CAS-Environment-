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

vehicles Select {
  (
    _x isKindOf "MBT_01_arty_base_F" ||
    _x isKindOf "MBT_01_mlrs_base_F" ||
    _x isKindOf "MBT_02_arty_base_F" ||
    _x isKindOf "StaticMortar"
  ) &&
  (vehicle leader _x == _x) &&
  (playerSide == side _x)
};