params ["_ctrlScreen","_marker","_pos","_color","_data"];

((_data splitString "|") apply {parseNumber _x}) params ["_dir","_size","_mapScale"];

private _hide_Direction = if (
  "_cTab" in _marker || _marker find BCE_cTab_Marker_Sync > -1
) then {
  private _HideDir = (((_marker select [15]) splitString "/") apply {parseNumber _x}) # 3;

  //- Optimize
    if (isnil{_HideDir}) then {
      private _markerType = markerType _marker;
      private _values = values (uiNamespace getVariable "bce_marker_map");
      private _find = _values findIf {_markerType in (_x # 0)};
      _HideDir = (_values # _find) param [2, 0];
    };

  0 < _HideDir
} else {
  false
};

//- Draw Direction Arrow (must be ICON) 
  if (_dir != 0 && !_hide_Direction) then {
    private _arrowLength = cTabUserMarkerArrowSize * _mapScale * _size;
    private _secondPos = [_pos,_arrowLength,_dir] call BIS_fnc_relPos;
    _ctrlScreen drawArrow [_pos, _secondPos, _color];
  };

