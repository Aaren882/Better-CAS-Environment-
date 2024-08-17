params ["_control"];
private _display = ctrlParent _control;
private _displayName = cTabIfOpen # 1;

private _group = _display displayCtrl (17000 + 1301);
private _markerColor = _display displayCtrl (17000 + 1090);

private _desc = _group controlsGroupCtrl 10;
private _EDIT_Type = _group controlsGroupCtrl 50;
private _EDIT_color = _group controlsGroupCtrl 51;

//- Current Select Marker
  private _marker = [_displayName,"MarkerEDIT"] call cTab_fnc_getSettings;

//- if Setup Marker
  if (_marker != "") then {
    
    private _channel = _group controlsGroupCtrl 110;

    private _pos = markerPos _marker;
    private _type = MarkerType _marker;
    private _shape = MarkerShape _marker;
    private _size = MarkerSize _marker;
    private _dir = markerDir _marker;
    private _brush = MarkerBrush _marker;
    private _alpha = MarkerAlpha _marker;
    private _priority = MarkerDrawPriority _marker;

    private _split = ((_marker select [15]) splitString "/") apply {parseNumber _x};

    //- Marker
      deleteMarker _marker;

    //- Data
      private _curSel_COLOR = (call compile (_markerColor lbData lbCurSel _EDIT_color)) # 0;
      switch true do {
        //- Marker Dropper
        case (_shape == "ICON"): {
          private _values = values (uiNamespace getVariable "bce_marker_map");
          private _data = _EDIT_Type lbData lbCurSel _EDIT_Type;
          _split set [
            3, 
            (_values # (_values findIf {_data in (_x # 0)})) param [2, 0]
          ];
          _marker = (_marker select [0,15]) + (_split joinString "/");

          createMarker [
            _marker,
            _pos,
            _channel lbValue lbCurSel _channel,
            player
          ];

          _marker setMarkerType _data;
          _marker setMarkerShadow (0 < getNumber (configFile >> "CfgMarkers" >> _type >> "shadow"));

        };
        //- Drawing Tool
        case (_shape == "RECTANGLE" || _shape == "ELLIPSE"): {
          _brush = _EDIT_Type lbData lbCurSel _EDIT_Type;
          createMarker [
            _marker,
            _pos,
            _channel lbValue lbCurSel _channel,
            player
          ];
        };
      };

    //- Setup New marker
    _marker setMarkerShape _shape;
    _marker setMarkerSize _size;
    _marker setmarkerDir _dir;
    _marker setMarkerBrush _brush;
    _marker setMarkerColor _curSel_COLOR;
    _marker setMarkerAlpha _alpha;
    _marker setMarkerDrawPriority _priority;
    _marker setMarkerText ctrlText _desc;
  };

//- Clear Variable (don't update interface due to refresh request being ignored something)
[_displayName,[["MarkerEDIT",""]],false] call cTab_fnc_setSettings;
_group ctrlShow false;