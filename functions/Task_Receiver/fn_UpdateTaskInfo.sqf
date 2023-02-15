private _display = uiNamespace getVariable "BCE_Task_Receiver";
private _vehicle = vehicle cameraOn;
private _var = _vehicle getVariable "BCE_Task_Receiver";

private _ctrlUnit = _display displayCtrl 101;
private _ctrlList = _display displayCtrl 102;
private _Cfg = configFile >> "RscTitles" >> "BCE_Task_Receiver" >> "controls" >> "TaskList" >> "CfgItems";

_var params ["_caller","_callerGrp","_type","_taskVar"];

_ctrlUnit ctrlSetText (format ["%1 [%2]",_callerGrp, name _caller]);

//-Set LB
switch _type do {

  //-5 Line
  case 5: {
    private _classes = ("true" configClasses (_Cfg >> "5Line")) apply {getText(_x >> "Text")};
    {
      if (_forEachIndex == 0) then {
        private _index = _ctrlList lbAdd (_x # 2);
        _ctrlList lbSetTextRight [_index, _x # 0];
      } else {
        private _index = _ctrlList lbAdd (_classes # _forEachIndex);
        if (_index == 3) then {
          _ctrlList lbSetTextRight [_index, format ["%1 with: [%2]", trim(_x # 1), trim(_x # 2)]];
        } else {
          _ctrlList lbSetTextRight [_index, _x # 0];
        };
      };
    } foreach _taskVar;
  };

  //-9 Line
  case 9: {

    private _classes = ("true" configClasses (_Cfg >> "9Line")) apply {getText(_x >> "Text")};
    {
      private _index = _ctrlList lbAdd (_classes # _forEachIndex);
      if (_index == 5) then {
        _ctrlList lbSetTextRight [_index, _x # 1];
      } else {
        _ctrlList lbSetTextRight [_index, _x # 0];
      };
    } foreach _taskVar;
  };
};

//-Set UI POS
{
  _x params ["_idc",["_BG",0]];
  private _ctrl = _display displayCtrl _idc;
  private _class = if (_BG > 0) then {
    configFile >> "RscTitles" >> "BCE_Task_Receiver" >> "controlsBackground" >> ctrlClassName _ctrl
  } else {
    configFile >> "RscTitles" >> "BCE_Task_Receiver" >> "controls" >> ctrlClassName _ctrl
  };
  private _pos = ["x","y","w","h"] apply {
    call compile getText (_class >> _x)
  };

  _ctrl ctrlSetPosition _pos;
  _ctrl ctrlCommit 0;
} forEach [
  [15110,1],
  [15111,1],
  15112,
  101,
  102
];
