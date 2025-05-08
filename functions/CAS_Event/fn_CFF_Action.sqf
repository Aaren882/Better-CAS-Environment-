/*
  NAME : BCE_fnc_CFF_Action
*/
params ["_taskUnit","_data"];

private _group = group _taskUnit;

_data params [
  "_Task_Type",
  "_TGPOS", //- OT Infos
  "_Wpn_setup",
  "_taskVar"
];
(_Wpn_setup # 0) params ["_lbAmmo_IE","_lbFuse_IE","_fireUnitSel_IE","_setCount_IE","_radius_IE","_fuzeVal_IE"];
(_Wpn_setup # 1) params ["_lbAmmo_IA","_lbFuse_IA",["_fireUnitSel_IA",1],"_setCount_IA","_radius_IA","_fuzeVal_IA"];

//- #TODO - Integrate 
private _angleType = "LOW";
private _longRangeGuided = false;

private _abort = false;
private _endMission = false;
private _checkFire = false;

//- FROM "StartMission.sqf"
  // If it's long range guided, then fake the distance to get the projectile into the air regardless.
if (_longRangeGuided) then {
  private _realDistance = _distance;
  _distance = _regularMaxRange / 2;
};

private _artyAlt = _posUnit # 2;
private _alt = (_chosenTargetPos # 2) - _artyAlt;		// Altitude difference

private _AllCharges = [_unit, _weapon, _lbAmmo_IA, _distance, _alt] call BCE_Fnc_GetAllCharges;
_allCharges params ["_chargesArrayLow","_chargesArrayHigh","_vel"];

// - findBestCharge
private _array = [_taskUnit, _TGPOS, _angleType, _longRangeGuided, _chargesArrayLow, _chargesArrayHigh, _abort, _endMission, _checkFire] call BCE_Fnc_findBestCharge;
_array params ["_bestCharge","_abort","_endMission","_checkFire"];

_taskUnit setWeaponReloadingTime [_gunner,(currentMuzzle _gunner), 0];
_taskUnit fire [_weapon, _bestCharge # 0];