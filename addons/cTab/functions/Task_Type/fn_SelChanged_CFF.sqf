switch _curLine do {
  case 0:{
    _shownCtrls params [
			"",
			"","_CTFuse","","","","_CTFuzeVal",
			"","_IA_fuse","","","","_IA_fuzeVal"
		];

    {
      _x params ["_lbFuze","_lbFuzeVal"];

      private _value = _lbFuze lbValue (lbCurSel _lbFuze);

      //- -1 : As IE Setup ("IN Adjust" Section only)
      //-  0 : Impact Fuze
      //-  1 : VT Fuze
      //-  2 : Delay Fuze
      private _tip = call {
        if (_value == 1) exitWith {
          "Burst Height (m)"
        };
        if (_value == 2) exitWith {
          "Delay Time (Sec)"
        };
        ""
      };

      _lbFuzeVal ctrlSetTooltip _tip;
      _lbFuzeVal ctrlShow (_tip != "");
    } forEach [
      [_CTFuse,_CTFuzeVal],
      [_IA_fuse,_IA_fuzeVal]
    ];
  };
  /* case 1:{
    _shownCtrls params ["_toolBox","_combo"];
    if (_selectedIndex == 1) then {
      _combo ctrlShow true;

      private _color = [
        (profilenamespace getvariable ['Map_BLUFOR_R',0]),
        (profilenamespace getvariable ['Map_BLUFOR_G',1]),
        (profilenamespace getvariable ['Map_BLUFOR_B',1]),
        (profilenamespace getvariable ['Map_BLUFOR_A',0.8])
      ];
      
      lbClear _combo;
      {
        if (isNull leader _x) then {continue};
        private _index = _combo lbAdd (groupId _x);
        _combo lbSetData [_index, str _x];

        _combo lbSetPicture [_index, "\a3\ui_f\data\Map\Markers\NATO\b_inf.paa"];
        _combo lbSetPictureColor [_index, _color];
      } forEach (groups playerSide);
      
    } else {
      _combo ctrlShow false;
    };
  }; */
  //- Control Method  [Toolbox, EditBox, output, ETA(StructuredText)]
  case 4:{
    _shownCtrls params ["_ctrl1","_ctrl2","_ctrl3","_ctrl4"];

    call {
      if (_selectedIndex == 1) exitWith {
        _ctrl2 ctrlShow true;
      };
      _ctrl2 ctrlShow false;
    };
  };
  default {
    _shownCtrls params ["_toolBox","_combo","_textBox"];
    if (_selectedIndex == 0) then {
      _combo ctrlShow true;
      _combo call BCE_fnc_IPMarkers;
    } else {
      _combo ctrlShow false;
    };
  };
};