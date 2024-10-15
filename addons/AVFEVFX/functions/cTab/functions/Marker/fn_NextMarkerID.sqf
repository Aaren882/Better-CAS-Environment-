params ["_MID"];
private ["_markers","_id"];

if (isnil{_MID}) then {
  _MID = BCE_cTab_Marker_Sync select [1];
};

_markers = (if (isMultiplayer) then {
  allMapMarkers select {markerChannel _x == currentChannel}
} else {
  allMapMarkers
}) select {(["_","_DEFINED"] joinString _MID) in _x};

_id = (selectMax (_markers apply {
  private _a = _x select [15];
  parseNumber ((_a splitString "/") # 1);
})) + 1;

if (isNil{_id}) then {_id = 0};
_id