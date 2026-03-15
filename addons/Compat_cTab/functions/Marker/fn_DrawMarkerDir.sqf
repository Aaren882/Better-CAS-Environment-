#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cTab_fnc_DrawMarkerDir
Description:
	Draws a directional arrow on the map for a marker.
	Only applies to markers of type "ICON" and will not draw if the marker has the "Hide Direction" option enabled.

Parameters:
		_ctrlScreen  - Map UI <CONTROL>
		_marker      - Marker ID <STRING>
		_pos         - Marker position <ARRAY>
		_color       - Color of the direction arrow <ARRAY>
		_data				 - Additional data array containing:
			_dir         - Direction the arrow should point in (0-360) <NUMBER>
			_size        - Size of the marker (used to scale the arrow) <NUMBER>
			_mapScale    - Current map scale (used to scale the arrow) <NUMBER>

Returns:
		<NONE>

Author:
		Aaren
---------------------------------------------------------------------------- */

params ["_ctrlScreen","_marker","_pos","_color","_data"];

_data params ["_dir","_size","_mapScale"];

if (_dir isEqualTo 0) exitWith {};

private _hide_Direction = if (
  "_cTab" in _marker || BCE_cTab_Marker_Sync in _marker
) then {
	TRACE_1("fn_DrawMarkerDir",_marker);

	private _HideDir = (((_marker select [15]) splitString "/") apply {parseNumber _x}) param [3, 1];
  0 < _HideDir
} else {
  false
};

if (_hide_Direction) exitWith {};

//- Draw Direction Arrow (must be ICON) 
	private _arrowLength = cTabUserMarkerArrowSize * _mapScale * _size;
	private _secondPos = [_pos,_arrowLength,_dir] call BIS_fnc_relPos;
	_ctrlScreen drawArrow [_pos, _secondPos, _color];
