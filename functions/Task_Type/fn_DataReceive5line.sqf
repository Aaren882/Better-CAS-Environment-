#define GetGRID(POS,GRID) [POS,GRID] call BCE_fnc_POS2Grid

switch _curLine do {
  //-Control Type
  case 0:{
    _shownCtrls params ["_ctrl"];
    _taskVar set [0, [["Type 1","Type 2","Type 3"] # (lbCurSel _ctrl), lbCurSel _ctrl]];
  };

  //-Friendly
  case 1:{
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
        _markerInfo = format ["Marker: %1 %2", _ctrl2 lbText (lbCurSel _ctrl2), _info];
        _TGPOS resize [3, 0];
        _taskVar set [1,
          [
            _markerInfo,
            _ctrl2 lbText (lbCurSel _ctrl2),
            _TGPOS,
            [lbCurSel _ctrl1,lbCurSel _ctrl2],
            _text
          ]
        ];
      } else {
        _taskVar set [1,["NA","",[],[0,0],""]];
      };
    } else {
      _TGPOS = uinamespace getVariable ["BCE_MAP_ClickPOS",[]];

      //-[1:Marker, 2:Marker Name, 3:Marker POS, 4:CurSel, 5: Mark Info]
      if !(_TGPOS isEqualTo []) then {
        _markerInfo = format ["FRND: [%1] %2", GetGRID(_TGPOS,8), _info];
        _TGPOS resize [3, 0];
        _taskVar set [1,
          [
            _markerInfo,
            "GRID",
            _TGPOS,
            [lbCurSel _ctrl1,lbCurSel _ctrl2],
            _text
          ]
        ];
      } else {
        _taskVar set [1,["NA","",[],[0,0],""]];
      };
    };
    _ctrl3 ctrlSetText (_taskVar # 1 # 0);
  };

  //-Target POS
  case 2:{
    _shownCtrls params ["_ctrl1","_ctrl2","_ctrl3"];

    if (lbCurSel _ctrl1 == 0) then {
      _TGPOS = call compile (_ctrl2 lbData (lbCurSel _ctrl2));

      //-[1:Marker, 2:Marker Name, 3:Marker POS, 4:LBCurSel, 5:Elevation(ASL), 6:RAM]
      if !(_TGPOS isEqualTo []) then {
        _markerInfo = format ["Marker: %1 [%2]", _ctrl2 lbText (lbCurSel _ctrl2), GetGRID(_TGPOS,8)];
        _TGPOS resize [3, 0];
        _taskVar set [2,
          [
            _markerInfo,
            _ctrl2 lbText (lbCurSel _ctrl2),
            _TGPOS,
            [lbCurSel _ctrl1,lbCurSel _ctrl2],
            (AGLToASL _TGPOS) # 2
          ]
        ];
      } else {
        _taskVar set [2,["NA",[]]];
      };
    } else {
      _TGPOS = uinamespace getVariable ["BCE_MAP_ClickPOS",[]];

      //-[1:Marker, 2:Marker Name, 3:Marker POS, 4:Empty, 5:Elevation(ASL), 6:Marker info]
      if !(_TGPOS isEqualTo []) then {
        _markerInfo = format ["GRID: [%1]",GetGRID(_TGPOS,8)];
        _TGPOS resize [3, 0];
        _taskVar set [2,
          [
            _markerInfo,
            "GRID",
            _TGPOS,
            [lbCurSel _ctrl1,lbCurSel _ctrl2],
            (AGLToASL _TGPOS) # 2
          ]
        ];
      } else {
        _taskVar set [2,["NA",[]]];
      };
    };
    _ctrl3 ctrlSetText (_taskVar # 2 # 0);
  };

  //-DESC
  case 3:{
    _shownCtrls params ["_ctrl1","_ctrl2"];
    private ["_text","_InfoText","_isEmptyInfo","_Info"];
    _text = ctrlText _ctrl1;
    _InfoText = ctrlText _ctrl2;

    _isEmptyInfo = ((_InfoText == "Mark with...") or (_InfoText == ""));
    _Info = if _isEmptyInfo then {
      ""
    } else {
      _InfoText
    };

    if (_text != "") then {
      _taskVar set [3,["",_text,_Info]];
    } else {
      _taskVar set [3,["NA","--",""]];
    };
  };

  //-Remarks
  case 4:{
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
      _taskVar set [4,[_text,_ordnanceInfo + [_ATK_range],[lbCurSel _ctrl1,lbCurSel _ctrl2,_rangeIndex,str _setCount]]];
    };
  };
};

//-Automatically Generate
//-Line 1
_taskVar set [0, [(_taskVar # 0) # 0, (_taskVar # 0) # 1,(_display displayCtrl 2005) lbText 0]];

//-2 Friendly
if (((_taskVar # 1 # 0) != "NA") && ((_taskVar # 2 # 0) != "NA") && !("with:" in (_taskVar # 1 # 0))) then {
  private ["_taskVar_1","_taskVar_2","_HDG","_dist","_cardinaldir","_InfoText","_info","_isEmptyInfo"];
  _taskVar_1 = _taskVar # 1;
  _taskVar_2 = _taskVar # 2;

  //-[Text ,Dist]
  _TGPOS = _taskVar_1 # 2;
  _HDG = round (((_taskVar_2 # 2) getDir _TGPOS) / 10) * 10;
  _dist = round (((_taskVar_2 # 2) distance2D _TGPOS) / 10) * 10;
  _cardinaldir = _HDG call BCE_fnc_getAzimuth;
  _InfoText = _taskVar_1 # 4;
  _isEmptyInfo = ((_InfoText == "Mark with...") or (_InfoText == ""));

  _info = if _isEmptyInfo then {
    format ["“%1” %2m [%3]", _cardinaldir, _dist, GetGRID(_TGPOS,8)];
  } else {
    format ["“%1” %2m [%3] with: [%4]", _cardinaldir, _dist, GetGRID(_TGPOS,8), toUpper _InfoText];
  };

  _taskVar set [1, [_info,_taskVar_1 # 1,_taskVar_1 # 2,_taskVar_1 # 3,_taskVar_1 # 4]];
};

uiNamespace setVariable ["BCE_CAS_5Line_Var",_taskVar];
