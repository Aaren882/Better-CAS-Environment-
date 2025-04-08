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
    if (_selectedIndex == 0) then {
      _shownCtrls params ["_toolBox","_combo"];
      _combo ctrlShow true;
      _combo call BCE_fnc_IPMarkers;
    } else {
      _shownCtrls params ["_toolBox","_combo","_textBox"];
      _combo ctrlShow false;
    };
  };
};