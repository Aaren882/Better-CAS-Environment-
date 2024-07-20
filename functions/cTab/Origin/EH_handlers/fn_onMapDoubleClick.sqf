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
([_displayName,"MarkerWidget"] call cTab_fnc_getSettings) params ["_show","_curSel","_BoxSel","_texts","_widgetMode"];

//- Get map Clicked Marker
  _cursorMarkerIndex = [_control,_click_POS] call cTab_fnc_findUserMarker;

//- Get Marker Type ("ICON", "RECTANGLE"...)
_Data = if (_cursorMarkerIndex > -1) then {
  private _marker = allMapMarkers # _cursorMarkerIndex;
  [
    (((_marker select [15]) splitString "/") apply {parseNumber _x}) param [4, [-1,_widgetMode] select (_marker find "_USER" > -1)],
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
  
  [_displayName,[["MarkerEDIT",_marker]]] call cTab_fnc_setSettings;
  
  [_display,_marker] call cTab_fnc_Marker_Edittor;
};

/////////////////////////// - PLACE MARKER - //////////////////////////////
if (
  _show && _widgetMode == 0
) exitWith {
  //- Needs "_display" and other components
  [_click_POS] call cTab_fnc_PlaceMarker;
};