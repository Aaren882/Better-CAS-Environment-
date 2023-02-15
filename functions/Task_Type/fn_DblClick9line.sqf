if (_curLine in [2,3,4]) then {_clearbut ctrlShow false};

switch _curLine do {
  //-Control type
  case 0:{
    _shownCtrls params ["_ctrl"];
    _taskVar_0 = _taskVar # 0;

    if ((_taskVar_0 # 0) != "NA") then {
      _ctrl lbSetCurSel ((_taskVar # 0) # 1);
    } else {
      _ctrl lbSetCurSel 0;
    };

    private _ctrlPOS = ctrlPosition _ctrl;
    private _c = (_titlePOS # 3) + (_ctrlPOS # 3);
    _description ctrlSetPosition
    [
      _TaskListPOS # 0,
      (_TaskListPOS # 1) + _c,
      _TaskListPOS # 2,
      (_TaskListPOS # 3) - _c
    ];
  };

  //-IP/BP
  case 1:{
    _shownCtrls params ["_ctrl1","_ctrl2","_ctrl3"];
    _taskVar_1 = _taskVar # 1;

    //-Back to previous status
    if ((_taskVar_1 # 0) != "NA") then {
      _ctrl1 lbSetCurSel (_taskVar_1 # 3 # 0);
      _ctrl2 lbSetCurSel (_taskVar_1 # 3 # 1);
    };

    _ctrl1sel = lbCurSel _ctrl1;
    _ctrl3 ctrlSetText (_taskVar_1 # 0);

    if (_ctrl1sel == 0) then {
      _ctrl2 ctrlShow true;
      _ctrl2 call BCE_fnc_IPMarkers;
    } else {
      _ctrl2 ctrlShow false;
    };

    //-Description POS
    _c = 0;
    {
      _c = _c + ((ctrlPosition _x) # 3);
    } forEach [_ctrl1,_ctrl2];
    private _c = (_titlePOS # 3) + _c;
    _description ctrlSetPosition
    [
      _TaskListPOS # 0,
      (_TaskListPOS # 1) + _c,
      _TaskListPOS # 2,
      (_TaskListPOS # 3) - _c
    ];

    _ctrl2POS = ctrlPosition _ctrl2;
    _ctrl3POS = ctrlPosition _ctrl3;

    //-Expression
    _ctrl3 ctrlSetPosition
    [
      (_ctrl2POS # 0) + (_ctrl2POS # 2),
      _ctrl2POS # 1,
      _ctrl2POS # 2,
      _ctrl2POS # 3
    ];
    _ctrl3 ctrlCommit 0;
  };
  //-Heading
  case 2:{
    private _c = _titlePOS # 3;
    _description ctrlSetPosition
    [
      _TaskListPOS # 0,
      (_TaskListPOS # 1) + _c,
      _TaskListPOS # 2,
      (_TaskListPOS # 3) - _c
    ];
  };
  case 3:{
    private _c = _titlePOS # 3;
    _description ctrlSetPosition
    [
      _TaskListPOS # 0,
      (_TaskListPOS # 1) + _c,
      _TaskListPOS # 2,
      (_TaskListPOS # 3) - _c
    ];
  };
  case 4:{
    private _c = _titlePOS # 3;
    _description ctrlSetPosition
    [
      _TaskListPOS # 0,
      (_TaskListPOS # 1) + _c,
      _TaskListPOS # 2,
      (_TaskListPOS # 3) - _c
    ];
  };

  //-DESC
  case 5:{
    _shownCtrls params ["_ctrl"];
    private _ctrlPOS = ctrlPosition _ctrl;
    private _c = (_titlePOS # 3) + (_ctrlPOS # 3);
    _description ctrlSetPosition
    [
      _TaskListPOS # 0,
      (_TaskListPOS # 1) + _c,
      _TaskListPOS # 2,
      (_TaskListPOS # 3) - _c
    ];
  };

  //-GRID
  case 6:{
    _shownCtrls params ["_ctrl1","_ctrl2","_ctrl3"];
    _taskVar_6 = _taskVar # 6;

    //-Back to previous status
    if ((_taskVar_6 # 0) != "NA") then {
      _ctrl1 lbSetCurSel (_taskVar_6 # 3 # 0);
      _ctrl2 lbSetCurSel (_taskVar_6 # 3 # 1);
    };

    _ctrl1sel = lbCurSel _ctrl1;
    _ctrl3 ctrlSetText (_taskVar_6 # 0);

    if (_ctrl1sel == 0) then {
      _ctrl2 ctrlShow true;
      _ctrl2 call BCE_fnc_IPMarkers;
    } else {
      _ctrl2 ctrlShow false;
    };

    //-Description POS
    _c = 0;
    {
      _c = _c + ((ctrlPosition _x) # 3);
    } forEach [_ctrl1,_ctrl2];
    private _c = (_titlePOS # 3) + _c;
    _description ctrlSetPosition
    [
      _TaskListPOS # 0,
      (_TaskListPOS # 1) + _c,
      _TaskListPOS # 2,
      (_TaskListPOS # 3) - _c
    ];

    _ctrl2POS = ctrlPosition _ctrl2;
    _ctrl3POS = ctrlPosition _ctrl3;

    //-Expression
    _ctrl3 ctrlSetPosition
    [
      (_ctrl2POS # 0) + (_ctrl2POS # 2),
      _ctrl2POS # 1,
      _ctrl2POS # 2,
      _ctrl2POS # 3
    ];
    _ctrl3 ctrlCommit 0;
  };

  //-MARK
  case 7:{
    _shownCtrls params ["_ctrl"];
    private _taskVar7 = _taskVar # 7;
    private _ctrlPOS = ctrlPosition _ctrl;
    private _c = (_titlePOS # 3) + (_ctrlPOS # 3);

    if ((_taskVar7 # 0) != "NA") then {
      _ctrl ctrlSetText (_taskVar # 7 # 1);
    } else {
      _ctrl ctrlSetText "Mark with...";
    };

    _description ctrlSetPosition
    [
      _TaskListPOS # 0,
      (_TaskListPOS # 1) + _c,
      _TaskListPOS # 2,
      (_TaskListPOS # 3) - _c
    ];

    _ctrl ctrlSetPosition
    [
      _ctrlPOS # 0,
      (_titlePOS # 1) + (_titlePOS # 3),
      _ctrlPOS # 2,
      _ctrlPOS # 3
    ];
    _ctrl ctrlCommit 0;
  };

  //-Friendlies
  case 8:{
    _shownCtrls params ["_ctrl1","_ctrl2","_ctrl3","_ctrl4"];
    private ["_taskVar_8","_ctrl4POS","_InfoText","_isEmptyInfo","_Info"];
    _taskVar_8 = _taskVar # 8;
    _ctrl4POS = ctrlPosition _ctrl4;
    _InfoText = _taskVar_8 # 4;
    _isEmptyInfo = ((_InfoText == "Mark with...") or (_InfoText == ""));

    _Info = if _isEmptyInfo then {
      "Mark with..."
    } else {
      format ["with :[%1]",_taskVar_8 # 4]
    };

    //-Back to previous status
    if ((_taskVar_8 # 0) != "NA") then {
      _ctrl1 lbSetCurSel (_taskVar_8 # 3 # 0);
      _ctrl2 lbSetCurSel (_taskVar_8 # 3 # 1);
      _ctrl4 ctrlSetText _Info;
    } else {
      _ctrl4 ctrlSetText "Mark with...";
    };

    _ctrl1sel = lbCurSel _ctrl1;
    _ctrl3 ctrlSetText (_taskVar_8 # 0);

    if (_ctrl1sel == 0) then {
      _ctrl2 ctrlShow true;
      _ctrl2 call BCE_fnc_IPMarkers;
    } else {
      _ctrl2 ctrlShow false;
    };

    //-Description POS
    _c = 0;
    {
      _c = _c + ((ctrlPosition _x) # 3);
    } forEach [_ctrl1,_ctrl2,_ctrl4];
    private _c = (_titlePOS # 3) + _c;
    _description ctrlSetPosition
    [
      _TaskListPOS # 0,
      (_TaskListPOS # 1) + _c,
      _TaskListPOS # 2,
      (_TaskListPOS # 3) - _c
    ];

    _ctrl2POS = ctrlPosition _ctrl2;
    _ctrl3POS = ctrlPosition _ctrl3;

    //-Expression
    _ctrl3 ctrlSetPosition
    [
      (_ctrl2POS # 0) + (_ctrl2POS # 2),
      _ctrl2POS # 1,
      _ctrl2POS # 2,
      _ctrl2POS # 3
    ];
    _ctrl3 ctrlCommit 0;

    _ctrl4 ctrlSetPosition
    [
      _TaskListPOS # 0,
      (_TaskListPOS # 1) + (_c) - (_ctrl4POS # 3),
      _ctrl4POS # 2,
      _ctrl4POS # 3
    ];
    _ctrl4 ctrlCommit 0;
  };

  //-EGRS [Toolbox, EditBox, output, Toolbox(Azimuth), Marker(combo)]
  case 9:{
    _shownCtrls params ["_ctrl1","_ctrl2","_ctrl3","_ctrl4","_ctrl5"];
    _taskVar_9 = _taskVar # 9;

    //-Back to previous status
    if ((_taskVar_9 # 0) != "NA") then {
      _ctrl1 lbSetCurSel (_taskVar_9 # 2 # 0);
      _ctrl4 lbSetCurSel (_taskVar_9 # 2 # 1);
      _ctrl4 lbSetCurSel (_taskVar_9 # 2 # 2);

      _ctrl2 ctrlSetText (str (_taskVar_9 # 1));
    } else {
      _ctrl2 ctrlSetText "Bearing...";
    };

    _ctrl1sel = lbCurSel _ctrl1;
    _ctrl3 ctrlSetText (_taskVar_9 # 0);

    if (_ctrl1sel == 0) then {
      _ctrl2 ctrlShow false;
      _ctrl5 ctrlShow false;

      _ctrl4 ctrlShow true;
    } else {
      //-Map Markers
      if (_ctrl1sel == 2) then {
        _ctrl5 ctrlShow true;
        _ctrl5 call BCE_fnc_IPMarkers;

        _ctrl2 ctrlShow false;
        _ctrl4 ctrlShow false;
      } else {
        _ctrl5 ctrlShow false;

        _ctrl2 ctrlShow true;
        _ctrl4 ctrlShow false;
      };
    };

    //-Description POS
    _c = 0;
    {
      _c = _c + ((ctrlPosition _x) # 3);
    } forEach [_ctrl1,_ctrl2,_ctrl3];
    private _c = (_titlePOS # 3) + _c;
    _description ctrlSetPosition
    [
      _TaskListPOS # 0,
      (_TaskListPOS # 1) + _c,
      _TaskListPOS # 2,
      (_TaskListPOS # 3) - _c
    ];

    _ctrl2POS = ctrlPosition _ctrl2;
    _ctrl3POS = ctrlPosition _ctrl3;

    //-Expression
    _ctrl3 ctrlSetPosition
    [
      (_ctrl2POS # 0) + (_ctrl2POS # 2),
      _ctrl2POS # 1,
      _ctrl2POS # 2,
      _ctrl2POS # 3
    ];
    _ctrl3 ctrlCommit 0;
  };

  //-Remarks
  case 10:{
    _shownCtrls params["_ctrl1","_ctrl2","_ctrl3","_ctrl4"];
    _taskVar_10 = _taskVar # 10;

    //-Weapon List
    [ctrlParent _ctrl1,_ctrl1,player getVariable ['TGP_View_Selected_Vehicle',objNull],false,false,false] call BCE_fnc_checkList;

    //-Default
    if ((_taskVar_10 # 0) != "NA") then {
      _ctrl1 lbSetCurSel (_taskVar_10 # 2 # 0);
      _ctrl2 lbSetCurSel (_taskVar_10 # 2 # 1);
      _ctrl3 lbSetCurSel (_taskVar_10 # 2 # 2);
      _ctrl4 ctrlSetText (_taskVar_10 # 2 # 3);
    } else {
      _ctrl1 lbSetCurSel (lbCurSel _checklist);
    };

    _c = 0;
    {
      _c = _c + ((ctrlPosition _x) # 3);
    } forEach [_ctrl1,_ctrl3];
    private _c = (_titlePOS # 3) + _c;
    _description ctrlSetPosition
    [
      _TaskListPOS # 0,
      (_TaskListPOS # 1) + _c,
      _TaskListPOS # 2,
      (_TaskListPOS # 3) - _c
    ];

    _ctrl1POS = ctrlPosition _ctrl1;
    _ctrl2POS = ctrlPosition _ctrl2;
    _ctrl3POS = ctrlPosition _ctrl3;
    _ctrl4POS = ctrlPosition _ctrl4;

    //-Expression
    _ctrl2 ctrlSetPosition
    [
      (_ctrl1POS # 0) + (_ctrl2POS # 2),
      _ctrl1POS # 1,
      _ctrl1POS # 2,
      _ctrl1POS # 3
    ];
    _ctrl4 ctrlSetPosition
    [
      (_ctrl1POS # 0) + (_ctrl2POS # 2),
      _ctrl3POS # 1,
      _ctrl3POS # 2,
      _ctrl3POS # 3
    ];
    _ctrl2 ctrlCommit 0;
    _ctrl4 ctrlCommit 0;
  };
};
