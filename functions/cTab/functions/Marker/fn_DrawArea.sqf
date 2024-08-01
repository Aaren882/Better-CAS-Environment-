private ["_lastClick","_Pool","_mPos","_LMB"];

//- Self Remove
if ((_toggle # 4) < 1 || !(_toggle # 0)) exitWith {
  _ctrlScreen ctrlRemoveEventHandler ["Draw", uiNamespace getVariable ["BCE_DrawingTool_EH",-1]];
  uiNamespace setVariable ["BCE_DrawingTool_EH",nil];
};

_lastClick = localNamespace getVariable ["BCE_DrawHold_lastClick",-1];
_Pool = localNamespace getVariable ["BCE_Draw_Pool",[]];

//- Pause
if (
  !cTabCursorOnMap ||
  ([_displayName,"PLP_mapTools"] call cTab_fnc_getSettings) ||
  _curSelMarker > -1
) exitWith {
  if (_lastClick > -1 || _Pool findIf {true} > -1) then {
    localNamespace setVariable ["BCE_DrawHold_lastClick",nil];
    localNamespace setVariable ["BCE_Draw_Pool",nil];
  };
};

_mPos = _ctrlScreen ctrlMapScreenToWorld getMousePosition;

_LMB = inputMouse 0;

//- Holding LMB
if (_LMB >= 1) then {
  //- Once on Start
  if (_lastClick == -1) then {
    _Pool pushBack _mPos;
    localNamespace setVariable ["BCE_DrawHold_lastClick",time];
    localNamespace setVariable ["BCE_Draw_Pool",_Pool];
  } else {
    //- Draw Rectangle
    private _colorLb = _display displayCtrl (17000 + 1090);
    private _color = (call compile (_colorLb lbData lbCurSel _colorLb)) # 1;
    _color set [3, 0.3];

    private _PosA = _Pool # 0;
    private _PosB = _mPos;

    private _pointNE = [];
    _pointNE set [0,(_PosA#0) min (_PosB#0)];
    _pointNE set [1,(_PosA#1) max (_PosB#1)];

    ((_PosA vectorDiff _PosB) apply {abs _x}) params ["_width","_height"];

    private _draw = [
      _pointNE vectorAdd [_width/2,-_height/2],_width/2,_height/2,0,_color,"#(argb,1,1,1)color(1,1,1,1)"
    ];
    if (0 == _toggle # 2) then {
      _ctrlScreen drawRectangle _draw;
    } else {
      _ctrlScreen drawEllipse _draw;
    };
    
  };
};

//- on Hold-End
if (_LMB == 0 && _lastClick > -1) then {
  private ["_colorLb","_color","_id","_name","_center"];

  //- Clear Vars
    localNamespace setVariable ["BCE_DrawHold_lastClick",nil];
    localNamespace setVariable ["BCE_Draw_Pool",nil];

  if (_curSelMarker > -1) exitWith {};

  _Pool pushBack _mPos;
  _Pool params ["_PosA","_PosB"];

  ((_PosA vectorDiff _PosB) apply {abs _x}) params ["_width","_height"];

  //- Area less than 100
  if (_width * _height < 100) exitWith {};

  _group = _display displayCtrl (17000 + 1300);
  _brushes = _group controlsGroupCtrl 21;

  _colorLb = _display displayCtrl (17000 + 1090);
  _color = (call compile (_colorLb lbData lbCurSel _colorLb)) # 0;

  //- Marker ID
    _id = "cTab" call cTab_fnc_NextMarkerID;

  //- MARKER #<PlayerID>/<MarkerID>/#<SEPARATOR>#/<Hide Direction> .. /<ChannelID> must Be last
    _name = format ["_cTab_DEFINED #%1/%2/-1/%3/1/%4", clientOwner, _id, 1, currentChannel];
  
  //- Place Marker
    _center = _PosA vectorAdd ((_PosB vectorDiff _PosA) vectorMultiply 0.5);

  _toggle params ["","","_BoxSel","_texts","","_brush","_opacity"];

  //- Marker
    _marker = createMarker [_name, _center, currentChannel, player];

    _marker setMarkerShape (["Rectangle","ELLIPSE"] select _BoxSel);
    _marker setMarkerSize [_width/2,_height/2];
    _marker setMarkerColor _color;
    _marker setMarkerBrush (_brushes lbData _brush);
    _marker setMarkerAlpha (_opacity / 100);
    
    _marker setMarkerDrawPriority -0.5;

    _texts params [["_prefix",""],["_index",""],["_DESC",""]];

    _marker setMarkerText _DESC;
};