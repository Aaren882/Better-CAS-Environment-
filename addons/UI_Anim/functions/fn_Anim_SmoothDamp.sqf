/*
  Function Name : BCE_fnc_Anim_SmoothDamp

  All the arguments are SCALARs
  
  Return => (SCALAR) :
    Vaule between "_current" and "_target"
*/

params [
  ["_current",0],
  ["_target",1],
  ["_maxSpeed",0],
  ["_smoothTime",0],
  ["_deltaTime",0],
  ["_currentVelocity",0]
];
privateAll;

_smoothTime = 0.0001 Max _smoothTime;
_omega = 2.0 / _smoothTime;

_x = _omega * _deltaTime;
_exp = 1.0 / (1.0 + _x + 0.48 * _x * _x + 0.235 * _x * _x * _x);
_change = _current - _target;
_originalTo = _target;

// Clamp maximum speed
_maxChange = _maxSpeed * _smoothTime;
_change = [_change, -_maxChange, _maxChange] call BIS_fnc_clamp;
_target = _current - _change;

_temp = (_currentVelocity + _omega * _change) * _deltaTime;
_currentVelocity = (_currentVelocity - _omega * _temp) * _exp;
_output = _target + (_change + _temp) * _exp;

// Prevent overshooting
if ((_originalTo - _current > 0.0) == (_output > _originalTo)) then {
	_output = _originalTo;
	_currentVelocity = (_output - _originalTo) / _deltaTime;
};

_output
