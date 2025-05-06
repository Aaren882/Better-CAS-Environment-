params ["_ctrlBnts","_ctrlPOS","_interfaceInit"];
_ctrlBnts params ["_bnt_back","_bnt_Ent","_bnt_third","_bnt_result"];

//- Arrange Bottons layout
  _bnt_Ent ctrlSetPositionX (_ctrlPOS # 2);
  {
    _x ctrlSetPositionW (_ctrlPOS # 2);
    _x ctrlCommit 0;
  } count [
    _bnt_back,
    _bnt_Ent,
    _bnt_result
  ];

_bnt_Ent ctrlSetText localize "STR_BCE_Enter";
_bnt_Ent ctrlSetBackgroundColor [0,0,0,0.5];

_bnt_result ctrlSetStructuredText parseText localize "STR_BCE_ClearTaskInfo";
_bnt_result ctrlSetBackgroundColor [1,0,0,0.5];