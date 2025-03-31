params ["_taskUnit","_taskVar"];

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

  //-Dont have both
  default {
    []
  };
};

[
  _taskVar_1 # 2,
  _POS,
  _TGPOS,
  _taskVar_9 # 1,
  [_class,_Mode,_turret,_Count,_muzzle,_ATK_range,_ATK_height],
  _taskVar,
  9,
  [_from,_FRPOS,_TGPOS] //- ["_from","_FRPOS","_TGPOS"]
]
