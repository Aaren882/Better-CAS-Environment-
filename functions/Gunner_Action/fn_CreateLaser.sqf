params["_veh","_mode","_unit"];

//Start~~~~~~~~~~~~~~~~~~~~~~~~

[_veh,_mode,_unit] call BCE_fnc_CreateLightSources;

_lights = _unit getVariable "BCE_turret_Gunner_Laser";
_unit setVariable ["turret_Direction",vectorDir ((_Lights # 0) # 0),true];

/* _EHID = addMissionEventHandler ["EachFrame", {
  _veh = _thisArgs # 0;
  _unit = _thisArgs # 1;
  _Lights = _thisArgs # 2;
  _lod_Offset = _thisArgs # 3;
  _color = _thisArgs # 4;

  _lod = _lod_Offset # 0;
  _offset = _lod_Offset # 1;

  _isIR = if(_color isEqualTo [1000,1000,1000])then{true}else{false};

  _Source = _veh modelToWorldVisualWorld (_veh selectionPosition [_lod,"Memory"]);
  _dir_goal = vectorDir (_Lights # 0);
  _dir = _unit getVariable "turret_Direction";

  //Delay
  _turret_delay_time = _unit getVariable ["turret_delay_time",time];
  if (_turret_delay_time <= time) then {
    _turret_delay_time = _unit getVariable ["turret_delay_time",time + 0.01];
    _Diff = (_dir_goal vectorDiff _dir) vectorMultiply 0.18;
    _unit setVariable ["turret_Direction",(_dir vectorAdd _Diff)];
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
},[
  _veh,
  _unit,
  (_lights # 0),
  (_lights # 1),
  (_lights # 2)
]];

_unit setVariable ["BCE_GunnerLaser_PerF_EH",_EHID]; */
