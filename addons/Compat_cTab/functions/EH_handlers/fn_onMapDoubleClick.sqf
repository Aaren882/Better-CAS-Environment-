params ["_control", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];

//- no additional inputs
  if (_shift || _ctrl || _alt) exitWith {};

private [
  "_click_POS",
  "_display","_displayName",
  "_cursorMarkerIndex",
  "_Data"
];

//- Get Click POS
  _click_POS = _control posScreenToWorld [_xPos,_yPos];

_display = ctrlParent _control;
_displayName = cTabIfOpen # 1;
_toggle = [_displayName,"MarkerWidget"] call cTab_fnc_getSettings;

//- Get map Clicked Marker
  _cursorMarkerIndex = [_control,_click_POS] call cTab_fnc_findUserMarker;

//- Exit if the is an Aircraft in BFT
  if (_cursorMarkerIndex isEqualType objNull) exitWith {};

//- Other Interfaces
  if (isnil{_toggle}) exitWith {
    _toggle = [_displayName,"MarkerDropper"] call cTab_fnc_getSettings;

    if !(isnil{_toggle}) then {
      _toggle params ["_show","_mode","_count"];
      
      if (_show) then {
        //- Needs "_display" and other infoPanelComponents
        private _name = format [
          BCE_cTab_Marker_Sync + "_DEFINED #%1/%2/-1/1/0/%3",
          clientOwner,
          [] call cTab_fnc_NextMarkerID,
          currentChannel
        ];

        private _marker = createMarker [_name, _click_POS, currentChannel, focusOn]; 
        _marker setMarkerShape "ICON"; 
        _marker setMarkerType "hd_dot";
        _marker setMarkerText ([["M","E","B"] # _mode, _count] joinString "-");
        _marker setMarkerColor (["colorBlack","ColorEAST","ColorWEST"] # _mode);
        _marker setMarkerSize [0.8, 0.8];

        //- Update Values
          _count = _count + 1;
          if (_count > 20) then {
            _count = 0;
            ["BFT",localize "STR_BCE_MK_Limit_Reached_Error",5] call cTab_fnc_addNotification;
          };
          _toggle set [2,_count];
          [_displayName,[["MarkerDropper",_toggle]],false] call cTab_fnc_setSettings;
      };
    };
  };

_toggle params ["_show","_curSel","_BoxSel","_texts","_widgetMode"];

//- Get Marker Type ("ICON", "RECTANGLE"...)
_Data = if (_cursorMarkerIndex > -1) then {
  private _marker = allMapMarkers # _cursorMarkerIndex;
  [
    (((_marker select [15]) splitString "/") apply {parseNumber _x}) param [4, [-1,_widgetMode] select (_marker find BCE_cTab_Marker_Sync > -1)],
    _marker
  ]
} else {
  [-1]
};

///////////////////////////- EDITTING MODE - //////////////////////////////
if (
  (!_show && !isNil{_Data # 1}) || 
  (_cursorMarkerIndex > -1 && _widgetMode == (_Data # 0))
) exitWith {
  
  private _marker = _Data # 1;
  if (
    !(_marker find "PLP" < 0) && (
      (_marker find "_cTab" < 0) || 
      (_marker find BCE_cTab_Marker_Sync < 0) || 
      (_marker find "mtsmarker" < 0) ||
      (_marker find "SWT_" < 0)
    )
  ) exitWith {};
  private _EDIT_Marker = [_displayName,"MarkerEDIT"] call cTab_fnc_getSettings;

  //- Slew to Marker
    _control ctrlMapAnimAdd [
      0.5,
      ctrlMapScale _control,
      markerPos _marker
    ];
    ctrlMapAnimCommit _control;

  //- Can't be the same marker
    if (_marker == _EDIT_Marker) exitWith {};
  
  [_displayName,[["MarkerEDIT",_marker]],true] call cTab_fnc_setSettings;
};

/////////////////////////// - PLACE MARKER - //////////////////////////////
if (
  _show && _widgetMode == 0
) exitWith {
  //- Needs "_display" and other components
  [_click_POS, _toggle] call cTab_fnc_PlaceMarker;
};
