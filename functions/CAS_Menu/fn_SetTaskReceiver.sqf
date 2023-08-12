params ["_ctrlList","_type","_taskVar"];

lbClear _ctrlList;
_Cfg = configFile >> "RscTitles" >> "BCE_Task_Receiver" >> "controls" >> "TaskList" >> "CfgItems";

switch _type do {

  //-5 Line
  case 5: {
    private ["_classes","_DanClose"];
    _classes = ("true" configClasses (_Cfg >> "5Line")) apply {getText(_x >> "Text")};
    _DanClose = (_taskVar # 4 # 2) param [2,false];

    {
      if (_forEachIndex == 0) then {
        private _index = _ctrlList lbAdd (_x # 2);
        _ctrlList lbSetTextRight [_index, _x # 0];
      } else {
        private ["_index","_text"];
        _index = _ctrlList lbAdd (_classes # _forEachIndex);

        _text = [_x # 0,format ["%1 with: [%2]", trim(_x # 1), trim(_x # 2)]] select (_index == 3);
        _ctrlList lbSetTextRight [_index,_text];

        //-Read Back
        if (_index in [4]) then {
          private _color = [[0.27,1,0.16,1],[1,0.22,0.17,1]] select _DanClose;
          _ctrlList lbSetColor [_index, _color];
          _ctrlList lbSetColorRight [_index, _color];
        };
      };
    } foreach _taskVar;
  };

  //-9 Line
  case 9: {
    private _classes = ("true" configClasses (_Cfg >> "9Line")) apply {getText(_x >> "Text")};
    private _Danclose = (_taskVar # 10 # 2) param [2,false];
    {
      private _index = _ctrlList lbAdd (_classes # _forEachIndex);

      //-Read Back
      if (_index in [4,6,8,10]) then {
        private _color = [[0.27,1,0.16,1],[1,0.22,0.17,1]] select _Danclose;
        _ctrlList lbSetColor [_index, _color];
        _ctrlList lbSetColorRight [_index, _color];
      };

      _ctrlList lbSetTextRight [_index, _x # ([0,1] select (_index == 5))];
    } foreach _taskVar;
  };
};
