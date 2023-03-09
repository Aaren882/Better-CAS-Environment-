#define GetGRID(POS,GRID) [POS,GRID] call BCE_fnc_POS2Grid


switch _curLine do {
  //-Control Type
  case 0:{
    _shownCtrls params ["_ctrl"];
    _taskVar set [0, [["Type 1","Type 2","Type 3"] # (lbCurSel _ctrl), lbCurSel _ctrl]];
  };
  //-IP/BP
  case 1:{
    _shownCtrls params ["_ctrl1","_ctrl2","_ctrl3"];

    if (lbCurSel _ctrl1 == 0) then {
      _TGPOS = call compile (_ctrl2 lbData (lbCurSel _ctrl2));

      //-[1:Marker, 2:Marker Name, 3:Marker POS, 4:GRID]
      if !(_TGPOS isEqualTo []) then {
        _markerInfo = format ["Marker: %1 [%2]", _ctrl2 lbText (lbCurSel _ctrl2), mapGridPosition _TGPOS];
        _TGPOS resize [3, 0];
        _taskVar set [1,
          [
            _markerInfo,
            _ctrl2 lbText (lbCurSel _ctrl2),
            _TGPOS,
            [lbCurSel _ctrl1,lbCurSel _ctrl2]
          ]
        ];
      } else {
        _taskVar set [1,["NA",[]]];
      };
    } else {
      if (lbCurSel _ctrl1 == 1) then {
        _TGPOS = uinamespace getVariable ["BCE_MAP_ClickPOS",[]];

        //-[1:Marker, 2:Marker Name, 3:Marker POS, 4:Elevation]
        if !(_TGPOS isEqualTo []) then {
          _TGPOS resize [3, 0];
          _markerInfo = format ["GRID: [%1]",mapGridPosition _TGPOS];
          _taskVar set [1,
            [
              _markerInfo,
              "GRID",
              _TGPOS,
              [lbCurSel _ctrl1,lbCurSel _ctrl2]
            ]
          ];
        } else {
          _taskVar set [1,["NA",[]]];
        };
      } else {
        _TGPOS = getpos cameraOn;
        _TGPOS set [2,0];
        _markerInfo = format ["GRID: [%1]",mapGridPosition _TGPOS];
        _taskVar set [1,
          [
            _markerInfo,
            "GRID",
            _TGPOS,
            [lbCurSel _ctrl1,lbCurSel _ctrl2]
          ]
        ];
      };
    };
    _ctrl3 ctrlSetText (_taskVar # 1 # 0);
  };

  //-DESC
  case 5:{
    _shownCtrls params ["_ctrl"];
    private _text = ctrlText _ctrl;
    if (_text != "") then {
      _taskVar set [5,["",_text]];
    } else {
      _taskVar set [5,["NA",[]]];
    };
  };

  //-GRID
  case 6:{
    _shownCtrls params ["_ctrl1","_ctrl2","_ctrl3"];

    if (lbCurSel _ctrl1 == 0) then {
      _TGPOS = call compile (_ctrl2 lbData (lbCurSel _ctrl2));

      //-[1:Marker, 2:Marker Name, 3:Marker POS, 4:LBCurSel, 5:Elevation(ASL), 6:RAM]
      if !(_TGPOS isEqualTo []) then {
        _markerInfo = format ["Marker: %1 [%2]", _ctrl2 lbText (lbCurSel _ctrl2), GetGRID(_TGPOS,8)];
        _TGPOS resize [3, 0];
        _taskVar set [6,
          [
            _markerInfo,
            _ctrl2 lbText (lbCurSel _ctrl2),
            _TGPOS,
            [lbCurSel _ctrl1,lbCurSel _ctrl2],
            (AGLToASL _TGPOS) # 2,
            _markerInfo
          ]
        ];
      } else {
        _taskVar set [6,["NA",[]]];
      };
    } else {
      _TGPOS = uinamespace getVariable ["BCE_MAP_ClickPOS",[]];

      //-[1:Marker, 2:Marker Name, 3:Marker POS, 4:Empty, 5:Elevation(ASL), 6:Marker info]
      if !(_TGPOS isEqualTo []) then {
        _markerInfo = format ["GRID: [%1]",GetGRID(_TGPOS,8)];
        _TGPOS resize [3, 0];
        _taskVar set [6,
          [
            _markerInfo,
            "GRID",
            _TGPOS,
            [lbCurSel _ctrl1,lbCurSel _ctrl2],
            (AGLToASL _TGPOS) # 2,
            _markerInfo
          ]
        ];
      } else {
        _taskVar set [6,["NA",[]]];
      };
    };
    _ctrl3 ctrlSetText (_taskVar # 6 # 0);
  };

  //-MARK
  case 7:{
    _shownCtrls params ["_ctrl1"];

    private _text = toUpper (trim (ctrlText _ctrl1));
    private _isEmptyInfo = ((_text == "Mark with...") or (_text == ""));
    private _info = if _isEmptyInfo then {
      ""
    } else {
      format ["with :[%1]",_text]
    };
    if _isEmptyInfo then {
      _ctrl1 ctrlSetText "Mark with...";
    };

    if (_text != "") then {
      _taskVar set [7,[_info,_text]];
    } else {
      _taskVar set [7,["NA"]];
    };
  };

  //-Friendlies
  case 8:{
    _shownCtrls params ["_ctrl1","_ctrl2","_ctrl3","_ctrl4"];

    private _text = ctrlText _ctrl4;
    private _isEmptyInfo = ((_text == "Mark with...") or (_text == ""));
    private _info = if _isEmptyInfo then {
      ""
    } else {
      format ["with :[%1]",toUpper _text]
    };
    if _isEmptyInfo then {
      _ctrl4 ctrlSetText "Mark with...";
    };

    if (lbCurSel _ctrl1 == 0) then {
      _TGPOS = call compile (_ctrl2 lbData (lbCurSel _ctrl2));

      //-[1:Marker, 2:Marker Name, 3:Marker POS, 4:LBCurSel, 5: Mark Info]
      if !(_TGPOS isEqualTo []) then {
        _markerInfo = format ["Marker: %1 [%2] %3", _ctrl2 lbText (lbCurSel _ctrl2), GetGRID(_TGPOS,8), _info];
        _TGPOS resize [3, 0];
        _taskVar set [8,
          [
            _markerInfo,
            _ctrl2 lbText (lbCurSel _ctrl2),
            _TGPOS,
            [lbCurSel _ctrl1,lbCurSel _ctrl2],
            _text
          ]
        ];
      } else {
        _taskVar set [8,["NA","",[],[0,0],""]];
      };
    } else {
      if (lbCurSel _ctrl1 == 1) then {
        _TGPOS = uinamespace getVariable ["BCE_MAP_ClickPOS",[]];

        //-[1:Marker, 2:Marker Name, 3:Marker POS, 4:CurSel, 5: Mark Info]
        if !(_TGPOS isEqualTo []) then {
          _markerInfo = format ["FRND: %1", _info];
          _TGPOS resize [3, 0];
          _taskVar set [8,
            [
              _markerInfo,
              "GRID",
              _TGPOS,
              [lbCurSel _ctrl1,lbCurSel _ctrl2],
              _text
            ]
          ];
        } else {
          _taskVar set [8,["NA","",[],[0,0],""]];
        };
      } else {
        _TGPOS = getpos cameraOn;
        _TGPOS set [2,0];
        _markerInfo = format ["GRID: [%1]",mapGridPosition _TGPOS];
        _taskVar set [8,
          [
            _markerInfo,
            "GRID",
            _TGPOS,
            [lbCurSel _ctrl1,lbCurSel _ctrl2],
            _text
          ]
        ];
      };
    };
    _ctrl3 ctrlSetText (_taskVar # 8 # 0);
  };

  //-EGRS [Toolbox, EditBox, output, Toolbox(Azimuth)]
  case 9:{
    _shownCtrls params ["_ctrl1","_ctrl2","_ctrl3","_ctrl4","_ctrl5"];

    _HDG = _ctrl4 lbValue (lbCurSel _ctrl4);
    _TGPOS = nil;
    _marker = nil;
    if (lbCurSel _ctrl1 == 1) then {
      _TextInfo = ctrlText _ctrl2;

      //-Debug
      if ((_TextInfo == "") or (_TextInfo == "Bearing...") or isnil{(call compile _TextInfo)}) exitWith {
        hint "Wrong Input!!";
        _ctrl2 ctrlSetText "Bearing...";
      };

      _HDG = round (call compile _TextInfo);
      if (_HDG > 360) exitWith {
        _ctrl2 ctrlSetText "Bearing...";
        _HDG = nil;
      };
    } else {
      if (lbCurSel _ctrl1 == 2) then {
        _TGPOS = call compile (_ctrl5 lbData (lbCurSel _ctrl5));
        _TGPOS resize [3, 0];
        _marker = _ctrl5 lbText (lbCurSel _ctrl5);
      };
      if (lbCurSel _ctrl1 == 3) then {
        _TGPOS = getpos cameraOn;
        _TGPOS set [2,0];
        _marker = "OverHead";
      };
    };

    _cardinaldir = _HDG call BCE_fnc_getAzimuth;

    _text = [
      format ["EGRS: %1",_marker],
      format ["EGRS: %1 %2°",_cardinaldir,_HDG]
    ] select (isnil "_marker");

    if !(isnil"_cardinaldir") then {
      _taskVar set [9,[_text,_HDG,[lbCurSel _ctrl1,lbCurSel _ctrl4,lbCurSel _ctrl5],_TGPOS,_marker]];
      _ctrl3 ctrlSetText (_taskVar # 9 # 0);
    };
  };

  //-Remarks
  case 10:{
    _shownCtrls params ["_ctrl1","_ctrl2","_ctrl3","_ctrl4"];

    private _ordnanceInfo = call compile (_ctrl2 lbdata (lbcursel _ctrl2));
    _ordnanceInfo params ["_WeapName","_ModeName","_class","_Mode","_turret",["_Count",1,[0]]];

    //-Ammo Count
    private _str_Count = ctrlText _ctrl4;
    private _setCount = call compile (_str_Count);

    if (isnil{_setCount}) exitWith {};

    if (_setCount > _Count) then {
      _setCount = _Count;
      _ctrl4 ctrlSetText (str _Count);
    };

    //-Attack Range
    private _rangeIndex = lbCurSel _ctrl3;
    private _ATK_range = _ctrl3 lbValue _rangeIndex;

    _ordnanceInfo set [5,_setCount];
    private _text = format["%1 [%2]",_WeapName,_ModeName];
    if (isnil _WeapName) then {
      _taskVar set [10,[_text,_ordnanceInfo + [_ATK_range],[lbCurSel _ctrl1,lbCurSel _ctrl2,_rangeIndex,str _setCount]]];
    };
  };
};

//-Automatically Generate
if (((_taskVar # 1 # 0) != "NA") && ((_taskVar # 6 # 0) != "NA")) then {
  private ["_taskVar_1","_taskVar_6","_HDG","_cardinaldir","_DIST"];
  _taskVar_1 = _taskVar # 1;
  _taskVar_6 = _taskVar # 6;

  //-2 HDG [Text ,Heading]
  _HDG = round (((_taskVar_1 # 2) getDir (_taskVar_6 # 2)) / 10) * 10;

  _cardinaldir = _HDG call BCE_fnc_getAzimuth;

  _taskVar set [2, [format ["“%1” %2°", _cardinaldir, _HDG],_HDG]];

  //-3 DIST [Text ,Distance]
  _DIST = round (((_taskVar_1 # 2) distance2D (_taskVar_6 # 2)) / 100) * 100;
  _taskVar set [3, [format ["%1m",_DIST],_DIST]];
};

//-4 ELEV
if ((_taskVar # 6 # 0) != "NA") then {
  private ["_taskVar_6","_ELEV"];
  _taskVar_6 = _taskVar # 6;
  _ELEV = round (((_taskVar_6 # 4) * 3.2808399) / 10) * 10;
  //-in Feet
  _taskVar set [4, [format ["%1 MSL",_ELEV],_ELEV]];

  //-EGRS
  if (((_taskVar # 9 # 0) != "NA") && !(isnil {_taskVar # 9 # 3})) then {
    private ["_taskVar_9","_HDG","_text"];
    _taskVar_9 = _taskVar # 9;
    _HDG = round ((_taskVar_6 # 2) getDir (_taskVar_9 # 3));
    _text = format ["EGRS: [%1] %2 %3°",_taskVar_9 # 4, _HDG call BCE_fnc_getAzimuth, _HDG];
    _taskVar set [9,[_text,_HDG,_taskVar_9 # 2,_taskVar_9 # 3,_taskVar_9 # 4]];
  };
};

//-6 GRID
if (((_taskVar # 6 # 0) != "NA") && ((_taskVar # 7 # 0) != "NA")) then {
  private ["_taskVar_6","_taskVar_7"];
  _taskVar_6 = _taskVar # 6;
  _taskVar_7 = _taskVar # 7;

  _taskVar set [6, [format ["%1 %2",_taskVar_6 # 5, _taskVar_7 # 0],_taskVar_6 # 1,_taskVar_6 # 2,_taskVar_6 # 3,_taskVar_6 # 4,_taskVar_6 # 5]];
};

//-8 Friendlies
if (((_taskVar # 8 # 0) != "NA") && ((_taskVar # 6 # 0) != "NA")  && !("with:" in (_taskVar # 8 # 0))) then {
  private ["_taskVar_6","_taskVar_8","_HDG","_dist","_cardinaldir","_InfoText","_info","_isEmptyInfo"];
  _taskVar_6 = _taskVar # 6;
  _taskVar_8 = _taskVar # 8;

  //-[Text ,Dist]
  _TGPOS = _taskVar_8 # 2;
  _HDG = round (((_taskVar_6 # 2) getDir _TGPOS) / 10) * 10;
  _dist = round (((_taskVar_6 # 2) distance2D _TGPOS) / 10) * 10;
  _cardinaldir = _HDG call BCE_fnc_getAzimuth;
  _InfoText = _taskVar_8 # 4;
  _isEmptyInfo = ((_InfoText == "Mark with...") or (_InfoText == ""));

  _info = [
    format ["“%1” %2m with: [%3]", _cardinaldir, _dist, toUpper _InfoText],
    format ["“%1” %2m", _cardinaldir, _dist]
  ] select _isEmptyInfo;
  _taskVar set [8, [_info,_taskVar_8 # 1,_taskVar_8 # 2,_taskVar_8 # 3,_taskVar_8 # 4]];
};

uiNamespace setVariable ["BCE_CAS_9Line_Var",_taskVar];
