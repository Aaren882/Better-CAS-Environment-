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
private _abort = false;
private _endMission = false;
private _checkFire = false;

//- FROM "StartMission.sqf"

private _turretPath = (assignedVehicleRole (gunner _taskUnit)) # 1;
private _weapon = _taskUnit currentWeaponTurret _turretPath;
private _chargesArray = [_taskUnit, _lbAmmo_IA, _TGPOS, false, _weapon] call BCE_Fnc_GetAllCharges;

// - findBestCharge
[_taskUnit, _TGPOS, _chargesArray] call BCE_Fnc_findBestCharge;


////////////////// #TODO - FIX fn_findCharge
  /* _taskUnit = h3;
  _TGPOS = getposASL h2;

  [_taskUnit, "12Rnd_230mm_rockets", _TGPOS, true] call BCE_Fnc_GetAllCharges; 

  //- OR
  _taskUnit = h3; 
  _chosenTargetPos = getPosASL h2; 

  private _turretPath = (assignedVehicleRole (gunner _taskUnit)) # 1; 
  private _weapon = _taskUnit currentWeaponTurret _turretPath;


  private _unitPOS = getPosASL _taskUnit; 
  
  private _distance = _unitPOS distance2D _chosenTargetPos; 
  private _alt = (_chosenTargetPos # 2) - (_unitPOS # 2);  // Altitude difference
  
  [_taskUnit, _weapon,"12Rnd_230mm_rockets",_distance, _alt] call T1AM_Fnc_GetAllCharges;


//- SETUP
  [] spawn {
    _taskUnit = h1; 
    _TGPOS = getPosASL h2; 
    private _chargesArray = [_taskUnit, "32Rnd_155mm_Mo_shells", _TGPOS, true, ""] call BCE_Fnc_GetAllCharges;
    hint str ([_taskUnit, _TGPOS, _chargesArray] call BCE_Fnc_findBestCharge);
  };
//- FIRE
  _taskUnit = h1;

  private _turretPath = (assignedVehicleRole (gunner _taskUnit)) # 1; 
  private _weapon = _taskUnit currentWeaponTurret _turretPath;

  _gunner = gunner _taskUnit;
  _taskUnit setWeaponReloadingTime [_gunner,(currentMuzzle _gunner), 0];
  _taskUnit fire [_weapon, "Single2"];

  // "32Rnd_155mm_Mo_shells"
  // "12Rnd_230mm_rockets"

//--- Vector Test
  _taskUnit = h3;

  private _turretPath = (assignedVehicleRole (gunner _taskUnit)) # 1;   
  private _turretConfig = [_taskUnit, _turretPath] call CBA_fnc_getTurret;

  _sel_A = _taskUnit selectionPosition getText(_turretConfig >> "gunBeg"); 
  _sel_B = _taskUnit selectionPosition getText(_turretConfig >> "gunEnd"); 

  //- Default
  private _posA2 = _taskUnit modelToWorldWorld _sel_A; 
  private _posC2 = _taskUnit modelToWorldWorld _sel_B; 
  private _posB2 = [_posC2 # 0, _posC2 # 1, _posA2 # 2]; 

  private _adjacent = _posA2 vectorDistance _posB2;
  private _opposite = _posB2 vectorDistance _posC2;
  private _hypotenuse = _posA2 vectorDistance _posC2;

  private _verDegrees = acos((_adjacent^2 + _hypotenuse^2 - _opposite^2) / (2*_adjacent*_hypotenuse));

  private _posB2B = [_sel_B # 0, _sel_B # 1, 0]; 
  private _verDegreesB = acos((_sel_A vectorFromTo _sel_B) vectorCos (_sel_B vectorFromTo _posB2B));

  [_verDegrees,_verDegreesB] */