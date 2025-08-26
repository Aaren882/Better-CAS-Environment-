params ["_ctrlBnts","_ctrlPOS","_subMenu","_interfaceInit"];
_ctrlBnts params ["_bnt_back","_bnt_Ent","_bnt_third","_bnt_result"];

//- Arrange Bottons layout
  {
    _x ctrlShow false;
    false
  } count (_ctrlBnts select [2]);

  _size = (2 * (_ctrlPOS # 2));

  _bnt_back ctrlSetPositionW _size;
  
  _bnt_Ent ctrlSetPositionX _size;
  _bnt_Ent ctrlSetPositionW _size;

  _bnt_back ctrlCommit 0;
  _bnt_Ent ctrlCommit 0;

  //- Set Color
    _bnt_Ent ctrlSetBackgroundColor [
      (profilenamespace getvariable ['GUI_BCG_RGB_R',0.77]),
      (profilenamespace getvariable ['GUI_BCG_RGB_G',0.51]),
      (profilenamespace getvariable ['GUI_BCG_RGB_B',0.08]),
      0.8
    ];

//- Botton Text
  _bnt_Ent ctrlSetText localize "STR_BCE_Locate_Position";

//- Bottons Fade-out "when showing [Sub-List]"
  private _group = ctrlParentControlsGroup _bnt_Ent;
  private _commitTime = [0.3, 0] select _interfaceInit;

  if !(_line < 1) then {
    _group ctrlEnable false;
    _group ctrlSetFade 0.75;
  } else {
    _group ctrlSetFade 0;
  };
  _group ctrlCommit _commitTime;