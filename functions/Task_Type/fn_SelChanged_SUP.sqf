params ["_shownCtrls","_curLine","_selectedIndex","_taskVar"];

switch _curLine do {
  case 3:{
		_shownCtrls params ["_Checkboxes","_Duration","_Rounds","_Interval","_SkipAdjust","_MinSec","_StructText"];
  
    private _taskVar_3 = _taskVar # 3;
    private _varStore = _taskVar_3 param [2, []];

    private _checked = _Checkboxes ctrlChecked _selectedIndex;
    private _secNum = _MinSec ctrlChecked 0;

    private _inputs = [_Duration,_Rounds,_Interval];

    (_inputs # _selectedIndex) ctrlEnable _checked;

		private _info = _varStore param [0,[0,0,0]];
      private _output = [];
      {
        private _val = parseNumber (ctrlText _x);
        
        if (
          !(ctrlEnabled _x) ||
          !(_val > 0)
        ) then {continue};
        
        _info set [_forEachIndex, _val];

        //- Setup Text
          private _color = "#ffffff";
          private _T = [
            "%1 Min(s)",
            "%1 Round(s)",
            [
              "per %1 Min(s)",
              "per %1 Sec(s)"
            ] select _secNum
          ];
          private _struct = format [
            "<t color='%2'>%1</t>",
            ["-", _val] select (_val > 0),
            _color
          ];

        //- return
          private _txt = format [
            (_T # _forEachIndex),
            _struct
          ];
          
        _output pushBack _txt;
      } forEach _inputs;

    //- Check "_output" exist
      if (count _output == 0) then {
        private _T = [
          ["%1 Round(s)", 1],
          ["per %1 Min(s)", 1]
        ];
        //- it will be "1 Round, Per 1 Min"
        _output = _T apply {format _x};
      };
    
    _StructText ctrlSetStructuredText parseText str (_output joinString ", ");

    //- Save Task value
      private _checked1 = _Checkboxes ctrlChecked 0;
      private _checked2 = _Checkboxes ctrlChecked 1; //- Round per Interval must be specified (bc ARMA)
      private _checked3 = _Checkboxes ctrlChecked 2;
      private _checked4 = _SkipAdjust ctrlChecked 0;
      private _checked5 = _MinSec ctrlChecked 0;

      _varStore set [0, _info];
      _varStore set [1, ([_checked1,_checked2,_checked3,_checked4,_checked5] apply {parseNumber _x})];

      _taskVar_3 set [2, _varStore];
      [
        "SUP" call BCE_fnc_get_TaskIndex,
        _curLine,
        _taskVar_3
      ] call BCE_fnc_setTaskVar;
  };
  default {
    call BCE_fnc_SelChanged_ADJ;
  };
};