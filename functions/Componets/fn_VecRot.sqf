params[["_obj",objNull],"_wRot","_isTurret"];
private [
  // "_time",
  "_offset","_offset2","_wVec","_vDirUp",
  "_vec_Cur","_vec_tar",
  "_array","_vecDirUp", "_i"
];

//-For camera only
if (_wRot isEqualType objNull) exitWith {
  _obj camPrepareTarget _wRot;
  _obj camCommitPrepared 0;
};

if (isnil{_wRot} || isnull _obj) exitWith {};

_offset = [1,-1] select (isSimpleObject _obj);
/*_offset2 = [1,-1] select (_isTurret);
_wVec = _wRot apply {(linearConversion [-1,1,_x,-65,65,true])};
_vDirUp = [nil, 0, _wVec # 2, 0] call BIS_fnc_transformVectorDirAndUp;
_vec_tar = [_wRot vectorMultiply _offset ,(_vDirUp # 1) vectorMultiply _offset2]; //- Target*/

_vec_Cur = [vectorDirVisual _obj, vectorUpVisual _obj]; //- Current
_vec_tar = [_wRot vectorMultiply _offset, _wRot vectorCrossProduct [-(_wRot # 1), _wRot # 0, 0]]; //- Target

_i = -1;
_vecDirUp = [
  (_vec_tar # 0) vectorDiff (_vec_Cur # 0),
  (_vec_tar # 1) vectorDiff (_vec_Cur # 1)
] apply {
  _i = _i + 1;
  private _m = vectorMagnitude _x;
  private _a = _m * 0.98;

  hintSilent str [_m,_a];
  vectorLinearConversion [_m ^ 2, 0.0, _a, _vec_Cur # _i, _vec_tar # _i,true]
};

_obj setVectorDirAndUp _vecDirUp;