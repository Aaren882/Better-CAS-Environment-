params["_vehicle","_turret"];
/* _lod = getText([_vehicle, _turret] call BIS_fnc_turretConfig >> "memoryPointGunnerOptics");
_startLODPos = _vehicle modelToWorldVisual (_vehicle selectionPosition _lod);

_dirNorm = [_vehicle,_turret] call BCE_fnc_getTurretDir;
_dirDist = _dirNorm vectorMultiply ((getObjectViewDistance # 0)*2);
_startPos = (_dirNorm vectorMultiply 1.5) vectorAdd _startLODPos;
_dirPoint = _startPos vectorAdd _dirDist; */

_startPos = if ((_vehicle == cameraOn) && (cameraView == "GUNNER")) then {
	AGLToASL (positionCameraToWorld [0,0,0])
} else {
	private _lod = getText ([_vehicle, _turret] call BIS_fnc_turretConfig >> "gunBeg");
	_vehicle modelToWorldWorld (_vehicle selectionPosition _lod);
};

_dirNorm = [_vehicle,_turret] call BCE_fnc_getTurretDir;
_dirDist = _dirNorm vectorMultiply ((getObjectViewDistance # 0)*2);
_dirPoint = _startPos vectorAdd _dirDist;

(((lineIntersectsSurfaces [_startPos, _dirPoint, _vehicle, objNull, true, -1, "VIEW"]) # 0) # 0)
