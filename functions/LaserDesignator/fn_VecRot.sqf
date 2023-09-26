params["_light","_wRot","_isTurret"];

_offset = if (isSimpleObject _light) then {-1} else {1};
_offset2 = if (_isTurret) then {-1} else {1};
_wVec = _wRot apply {(linearConversion [-1,1,_x,-65,65,true])};
_vDirUp = [nil, 0, _wVec # 2, 0] call BIS_fnc_transformVectorDirAndUp;

_light setVectorDirAndUp [_wRot vectorMultiply _offset ,(_vDirUp # 1) vectorMultiply _offset2];
