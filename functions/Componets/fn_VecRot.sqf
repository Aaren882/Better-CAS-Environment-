params[["_obj",objNull],"_wRot","_isTurret"];
private [
  "_offset","_offset2","_vecDirUp"
];

if (isnil{_wRot} || isnull _obj) exitWith {};

_offset = [1,-1] select (isSimpleObject _obj);
_offset2 = [1,-1] select (_isTurret);
_vecDirUp = [_wRot, _wRot vectorCrossProduct (_wRot vectorCrossProduct [0, 0, -1])];

if !(isnil{_delta}) then {
  _vecDirUp = [
    0,1
  ] apply {
    private _vec_Cur = _current_vec # _x;
    private _Vec_target = _vecDirUp # _x;

    private _VecMag = linearConversion [
      0, 1,
      vectorMagnitude (_Vec_target vectorDiff _vec_Cur),
      1.5, 1.2
    ];

    private _result = [
      _vec_Cur,
      _Vec_target,
      _delta,
      _VecMag
    ] call BIS_fnc_interpolateVector;
    _current_vec set [_x, _result];
    _result
  };
};

_obj setVectorDirAndUp _vecDirUp;
