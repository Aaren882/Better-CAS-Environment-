params ["_shownCtrls","_curLine","_selectedIndex","_taskVar"];

switch _curLine do {
  case 0:{
    _shownCtrls params [
			"",
			"","_CTFuse","","","_CTFuzeVal","",
			"","_IA_fuse","","","_IA_fuzeVal"
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
        /* if (_value == 2) exitWith { //- IRL it cannot be changed
          "Delay Time (Sec)"
        }; */
        ""
      };

      _lbFuzeVal ctrlSetTooltip _tip;
      _lbFuzeVal ctrlShow (_tip != "");
    } forEach [
      [_CTFuse,_CTFuzeVal],
      [_IA_fuse,_IA_fuzeVal]
    ];
  };
  case 1: {
    _shownCtrls params [
      "_toolBox",
      "_output",
      "_Radius",
      "_LINE_L","_LINE_W","_LINE_Dir",
      "_Title_L","_Title_W","_Title_Dir"
    ];

    private _ctrls = _shownCtrls select [2];
    private _show = call {
      if (_selectedIndex == 1) exitWith {
        [_Radius]
      };
      if (_selectedIndex == 2) exitWith {
        _shownCtrls select [_shownCtrls findIf {_x == _LINE_L}]
      };
      []
    };
    
    {_x ctrlshow (_x in _show)} count _ctrls;
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
    _shownCtrls params ["_toolBox","_combo","_textBox"];
    if (_selectedIndex == 0) then {
      _combo ctrlShow true;
      _combo call BCE_fnc_IPMarkers;
    } else {
      _combo ctrlShow false;
    };
  };
};