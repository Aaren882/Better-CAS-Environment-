params ["_unit"];

(_unit getVariable "BCE_turret_Gunner_Laser") params ["_Lights","_lod_Offset","_color","_veh"];

_dir = _unit getVariable ["turret_Direction",[]];

if !(_dir isEqualTo []) then {
  _lod = _lod_Offset # 0;
  _offset = _lod_Offset # 1;

  _isIR = if(_color isEqualTo [1000,1000,1000])then{true}else{false};

  _Source = _veh modelToWorldVisualWorld (_veh selectionPosition [_lod,"Memory"]);
  _dir_goal = vectorDir (_Lights # 0);

  //Delay
  _turret_delay_time = _unit getVariable ["turret_delay_time",time];
  if (_turret_delay_time <= time) then {
    _turret_delay_time = _unit getVariable ["turret_delay_time",time + 0.01];
    _Diff = (_dir_goal vectorDiff _dir) vectorMultiply 0.18;
    _unit setVariable ["turret_Direction",(_dir vectorAdd _Diff),true];
  };

  drawLaser [
    _Source vectorAdd _offset,
    _dir,
    _color,
    [],
    0.01,
    0.5,
    -1,
    _isIR
  ];
};
