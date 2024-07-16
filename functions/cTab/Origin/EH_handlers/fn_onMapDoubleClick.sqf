params ["_control", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];

//- no additional inputs
  if (_shift || _ctrl || _alt) exitWith {};

private [
  "_click_POS",
  "_display","_displayName",
  "_cursorMarkerIndex",
  "_Data",
  "_markers","_marker"
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
  _markers = if (isMultiplayer) then {
    allMapMarkers select {markerChannel _x == currentChannel}
  } else {
    allMapMarkers
  };
  _marker = _markers # _cursorMarkerIndex;
  (((_marker select [15]) splitString "/") apply {parseNumber _x}) param [4, [-1,_widgetMode] select (_marker find "_USER" > -1)];
} else {
  -1
};

///////////////////////////- EDITTING MODE - //////////////////////////////
if (
  !_show || _widgetMode == _Data
) exitWith {
  systemChat str [_cursorMarkerIndex,time];
};

///////////////////////////- PLACE MARKER - //////////////////////////////
if (
  _show && _widgetMode == 0
) exitWith {
  //- Needs "_display" and other components
  [_click_POS] call cTab_fnc_PlaceMarker;
};