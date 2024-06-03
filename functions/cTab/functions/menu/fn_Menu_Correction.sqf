private ["_header","_menu"];

(ctrlPosition _cGrp) params ["","","_GrpW","_GrpH"];
(ctrlPosition (_disp displayCtrl 1)) params ["_posX", "_posY", "_posW"];
(ctrlPosition (_disp displayCtrl 4660)) params ["", "", "","_posH"];

_cGrp ctrlSetPosition [
  _posX + (_posW/2) - _GrpW,
  _posY + (_posH/2) - _GrpH
];
_cGrp ctrlCommit 0;

hintsilent str [_cGrp,time]