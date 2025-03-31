params ["_taskUnit","_taskVar"];

private _drawT = {
	private ["_HDG","_POSs","_dis"];
	_HDG = _FRPOS getDirVisual _TGPOS;
	_POSs = [-90,90] apply {
		_TGPOS getPos [
			3000,
			_HDG + _x
		]
	};
	_dis = _POSs apply {_from distance2D _x};

	(_POSs select ((_from distance (_POSs # 0)) > (_from distance (_POSs # 1))))
};

_taskVar params [
  "_taskVar_0",
  ["_taskVar_1",["NA","",[]]],
  "",
  "",
  "",
  "",
  ["_taskVar_6",["NA","111222"]],
  "",
  "_taskVar_8",
  ["_taskVar_9",["NA",0,[],nil,nil]],
  ["_taskVar_10",["NA",-1]]
];

//-Processing
(_taskVar_0 # 3) params ["_WeapName","_ModeName","_class","_Mode","_turret","_Count","_muzzle","_ATK_range","_ATK_height"];
private _FAD = _taskVar_10 # 1;

private _IP_NA = "NA" in _taskVar_1;
private _FAD_NA = _FAD == -1;

//-FAD/H
private _from = [_taskVar_1 # 2, _taskUnit] select _IP_NA;
private _TGPOS = _taskVar_6 # 2;
private _FRPOS = _taskVar_8 # 2;

private _POS =  switch (true) do {
  //-have FAD
  case !(_FAD_NA): {
    (_TGPOS getPos [
      [_from distance2D _TGPOS, 3000] select _IP_NA,
      _FAD
    ])
  };
  //-No FAD have IP
  case !(_IP_NA): {
    call _drawT;
  };

  //-Dont have both
  default {call _drawT};
};

/* private _POS = if (_FAD_NA && _IP_NA) then {
} else {
  //-have FAD
  if !(_FAD_NA) then {
    
  } else {
    //-No FAD have IP
    if !(_IP_NA) then {
    };
  };
}; */
// [_taskUnit, _taskVar_1 # 2, _POS, _taskVar_6 # 2, _taskVar_9 # 1, [_class,_Mode,_turret,_Count,_muzzle,_ATK_range,_ATK_height],_taskVar,9] call BCE_fnc_Plane_CASEvent;

[_taskVar_1 # 2, _POS, _taskVar_6 # 2, _taskVar_9 # 1, [_class,_Mode,_turret,_Count,_muzzle,_ATK_range,_ATK_height],_taskVar,9]
