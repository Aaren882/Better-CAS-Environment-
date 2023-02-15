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

  //-Friendly
  case 1:{
    _shownCtrls params ["_ctrl1","_ctrl2","_ctrl3","_ctrl4"];
    private ["_taskVar_1","_ctrl4POS","_InfoText","_isEmptyInfo","_Info","_ctrl1sel","_c"];
    _taskVar_1 = _taskVar # 1;

    _InfoText = _taskVar_1 # 4;
    _isEmptyInfo = ((_InfoText == "Mark with...") or (_InfoText == ""));

    _Info = if _isEmptyInfo then {
      "Mark with..."
    } else {
      _InfoText
    };

    //-Back to previous status
    if ((_taskVar_1 # 0) != "NA") then {
      _ctrl1 lbSetCurSel (_taskVar_1 # 3 # 0);
      _ctrl2 lbSetCurSel (_taskVar_1 # 3 # 1);
      _ctrl4 ctrlSetText _Info;
    } else {
      _ctrl4 ctrlSetText "Mark with...";
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
    } forEach [_ctrl1,_ctrl2,_ctrl4];

    _c = (_titlePOS # 3) + _c;

    _ctrl4POS = ctrlPosition _ctrl4;

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

  //-Target
  case 2:{
    _shownCtrls params ["_ctrl1","_ctrl2","_ctrl3"];
    _taskVar_2 = _taskVar # 2;

    //-Back to previous status
    if ((_taskVar_2 # 0) != "NA") then {
      _ctrl1 lbSetCurSel (_taskVar_2 # 3 # 0);
      _ctrl2 lbSetCurSel (_taskVar_2 # 3 # 1);
    };

    _ctrl1sel = lbCurSel _ctrl1;
    _ctrl3 ctrlSetText (_taskVar_2 # 0);

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

  //-DESC
  case 3:{
    _shownCtrls params ["_ctrl1","_ctrl2"];
    private ["_taskVar_3","_InfoText","_isEmptyInfo","_Info","_ctrlPOS","_c"];
    _taskVar_3 = _taskVar # 3;
    _InfoText = _taskVar_3 # 2;

    _isEmptyInfo = ((_InfoText == "Mark with...") or (_InfoText == ""));

    _Info = if _isEmptyInfo then {
      "Mark with..."
    } else {
      _InfoText
    };

    //-Back to previous status
    if ((_taskVar_3 # 0) != "NA") then {
      _ctrl1 ctrlSetText (_taskVar_3 # 1);
      _ctrl2 ctrlSetText _Info;
    } else {
      _ctrl2 ctrlSetText "Mark with...";
    };

    _c = 0;
    {
      _c = _c + ((ctrlPosition _x) # 3);
    } forEach [_ctrl1,_ctrl2];
    _c = (_titlePOS # 3) + _c;

    _description ctrlSetPosition
    [
      _TaskListPOS # 0,
      (_TaskListPOS # 1) + _c,
      _TaskListPOS # 2,
      (_TaskListPOS # 3) - _c
    ];

    _ctrl1POS = ctrlPosition _ctrl1;
    _ctrl2POS = ctrlPosition _ctrl2;

    //-Expression
    _ctrl2 ctrlSetPosition
    [
      _TaskListPOS # 0,
      (_ctrl1POS # 1) + (_ctrl1POS # 3),
      _ctrl2POS # 2,
      _ctrl2POS # 3
    ];
    _ctrl2 ctrlCommit 0;
  };

  //-Remarks
  case 4:{
    _shownCtrls params["_ctrl1","_ctrl2","_ctrl3","_ctrl4"];
    _taskVar_4 = _taskVar # 4;

    //-Weapon List
    [ctrlParent _ctrl1,_ctrl1,player getVariable ['TGP_View_Selected_Vehicle',objNull],false,false,false] call BCE_fnc_checkList;

    //-Default
    if ((_taskVar_4 # 0) != "NA") then {
      _ctrl1 lbSetCurSel (_taskVar_4 # 2 # 0);
      _ctrl2 lbSetCurSel (_taskVar_4 # 2 # 1);
      _ctrl3 lbSetCurSel (_taskVar_4 # 2 # 2);
      _ctrl4 ctrlSetText (_taskVar_4 # 2 # 3);
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
