params[["_obj",objNull],"_wRot","_isTurret"];
private [
  // "_time",
  "_offset","_offset2","_vecDirUp",
  "_vecTar"
];

if (isnil{_wRot} || isnull _obj) exitWith {};

_offset = [1,-1] select (isSimpleObject _obj);
_offset2 = [1,-1] select (_isTurret);
_vecDirUp = [_wRot, _wRot vectorCrossProduct (_wRot vectorCrossProduct [0, 0, -1])];

_vec_tar = if (isnil{_delta}) then {
  _vecDirUp
} else {
  call {
    /*_private ["_vec_Cur","_dis"];
    vec_Cur = ;
    _dis = vectorMagnitude (_wRot vectorDiff _vec_Cur);

    if (_dis^2 < 0.0001) exitWith {_wRot};

    private _result = [
      _wRot,
      _vec_Cur,
      1/_dis
    ] call BIS_fnc_lerpVector;*/

    [
      0,1
    ] apply {
      private _vec_Cur = _current_vec # _x;
      private _Vec_target = _vecDirUp # _x;

      private _result = [
        _vec_Cur,
        _Vec_target,
        _delta,
        1.2
      ] call BIS_fnc_interpolateVector;
      _current_vec set [_x, _result];
      _result
    };
  };
};

hintSilent str [_current_vec,time];

_obj setVectorDirAndUp _vec_tar;
