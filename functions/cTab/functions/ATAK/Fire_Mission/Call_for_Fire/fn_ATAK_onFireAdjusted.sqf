params ["_group","_vector","_isOnLoad"];

private _indecator = _group controlsGroupCtrl 5001;
private _adjustBnt = _group controlsGroupCtrl 5002;

_vector params ["_x","_y"];

private _LR = [1,-1] select (_x < 0);
private _result = _LR * acos ([0,1] vectorCos _vector); //- Get Vector

//- Update Vector
_vector = _vector vectorMultiply 10;
private _text = format [
  "<img image='\MG8\AVFEVFX\data\Arrows\%3.paa' /> %1 m | <img image='\MG8\AVFEVFX\data\Arrows\%4.paa' /> %2 m",
  _vector # 1,
  _vector # 0,
  ["Point_Arrow","Point_Arrow_D"] select (_y < 0),
  ["Point_Arrow_R","Point_Arrow_L"] select (_x < 0)
];

_indecator ctrlSetText format [
  "\MG8\AVFEVFX\data\Arrows\%1.paa",
  ["thin_Arrow","center"] select (_vector isEqualTo [0,0])
];

//- Update Indications
  _indecator ctrlSetAngle [_result,0.5, 0.5,false];
  _indecator ctrlCommit ([0.15, 0] select _isOnLoad);

  _adjustBnt ctrlSetStructuredText parseText _text;