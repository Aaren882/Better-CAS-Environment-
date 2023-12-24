params[["_light",objNull],"_wRot","_isTurret"];
private ["_offset","_offset2","_wVec","_vDirUp"];
if (isnil{_wRot} || isnull _light) exitWith {};
_offset = [1,-1] select (isSimpleObject _light);
_offset2 = [1,-1] select (_isTurret);
_wVec = _wRot apply {(linearConversion [-1,1,_x,-65,65,true])};
_vDirUp = [nil, 0, _wVec # 2, 0] call BIS_fnc_transformVectorDirAndUp;

_light setVectorDirAndUp [_wRot vectorMultiply _offset ,(_vDirUp # 1) vectorMultiply _offset2];
