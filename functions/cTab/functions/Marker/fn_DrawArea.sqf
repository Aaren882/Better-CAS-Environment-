private ["_displayName","_mapTypes","_mapType","_map","_EH"];

_displayName = cTabIfOpen # 1;

_mapTypes = [_displayName,"mapTypes"] call cTab_fnc_getSettings;
_mapType = [_displayName,"mapType"] call cTab_fnc_getSettings;

_map = (uiNamespace getVariable _displayName) displayCtrl ([_mapTypes,_mapType] call cTab_fnc_getFromPairs);
_EH = uiNamespace getVariable ["BCE_DrawingTool_EH",-1];

if (_EH > 0) then {
  _map ctrlRemoveEventHandler ["Draw", _EH];
  uiNamespace setVariable ["BCE_DrawingTool_EH",nil];
};

_EH = _map ctrlAddEventHandler ["Draw", {
  params ["_map"];

  _displayName = cTabIfOpen # 1;
  _display = ctrlParent _map;

  _toggle = [_displayName,"MarkerWidget"] call cTab_fnc_getSettings;

  //- Self Remove
  if ((_toggle # 4) < 1) exitWith {
    _map ctrlRemoveEventHandler ["Draw", uiNamespace getVariable ["BCE_DrawingTool_EH",-1]];
    uiNamespace setVariable ["BCE_DrawingTool_EH",nil];
  };

  _MarkerSel = (uiNameSpace getVariable ["cTab_Marker_CurSel",-1]) > -1;

  _lastClick = localNamespace getVariable ["BCE_DrawHold_lastClick",-1];
	_Pool = localNamespace getVariable ["BCE_Draw_Pool",[]];
  
  //- Pause
  if (
    !cTabCursorOnMap ||
    _MarkerSel ||
    ([_displayName,"PLP_mapTools"] call cTab_fnc_getSettings)
  ) exitWith {
    if (_lastClick > -1 || _Pool findIf {true} > -1) then {
      localNamespace setVariable ["BCE_DrawHold_lastClick",nil];
      localNamespace setVariable ["BCE_Draw_Pool",nil];
    };
  };

  _mPos = _map ctrlMapScreenToWorld getMousePosition;
  
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
        _map drawRectangle _draw;
      } else {
        _map drawEllipse _draw;
      };
      
    };
  };
  
  //- on Hold-End
  if (_LMB == 0 && _lastClick > 0) then {
    private ["_colorLb","_color","_markers","_id","_name","_center"];

    //- Clear Vars
      localNamespace setVariable ["BCE_DrawHold_lastClick",nil];
      localNamespace setVariable ["BCE_Draw_Pool",nil];

    if ((uiNameSpace getVariable ["cTab_Marker_CurSel",-1]) > -1) exitWith {};

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
      _markers = (if (isMultiplayer) then {
        allMapMarkers select {markerChannel _x == currentChannel}
      } else {
        allMapMarkers
      }) select {"_cTab_DEFINED" in _x};

      _id = (selectMax (_markers apply {
        private _a = _x select [15];
        parseNumber ((_a splitString ":") # 1);
      })) + 1;

      if (isNil{_id}) then {
        _id = 0;
      };

      _name = format ["_cTab_DEFINED #%1:%2:%3:%4", clientOwner, _id, currentChannel, 1];
    //- Place Marker
      _center = _PosA vectorAdd ((_PosB vectorDiff _PosA) vectorMultiply 0.5);

    _toggle params ["","","_BoxSel","_texts","","_brush","_opacity"];

    //- Marker
      _marker = createMarker [_name, _center, currentChannel, cTab_player];

      _marker setMarkerShape (["Rectangle","ELLIPSE"] select _BoxSel);
      _marker setMarkerSize [_width/2,_height/2];
      _marker setMarkerColor _color;
      _marker setMarkerBrush (_brushes lbData _brush);
      _marker setMarkerAlpha (_opacity / 100);

      _texts params [["_prefix",""],["_index",""],["_DESC",""]];

      _marker setMarkerText format [
        "%1%2%3",
        _prefix + (["-",""] select (_index == "")),
        _index,
        [" || " + _DESC, _DESC] select (_DESC == "" || (_prefix == "" && _index == ""))
      ];
  };
}];

uiNamespace setVariable ["BCE_DrawingTool_EH",_EH];