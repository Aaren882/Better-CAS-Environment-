params ["_combo"];

lbclear _combo;
private _index = _combo lbAdd (localize "STR_BCE_SelectMarker");
_combo lbSetData [_index, "[]"];

{
	private _Channel = markerChannel _x;
	((getMarkerType _x) call BCE_fnc_getMarkerItem) params ["","_icon","","_size"];

	private _MP_Compat = [_Channel == -1,_Channel >= 0] select isMultiplayer;
	//-Exclude Polylines
	if (
			(_size != 0) &&
			((markerPolyline _x) isEqualTo []) &&
			(
				_MP_Compat
			)
	) then {
		private _text = markerText _x;

		//-Color
		private _color = ((markerColor _x) call BCE_fnc_getMarkerColor) param [1, [0,0,0,0]];

		//-Set Control Contents
		_text = [_text, "N/A"] select (_text == "");
		private _index = _combo lbAdd _text;
		_combo lbSetData [_index, str (getMarkerPos _x)];

		_combo lbSetPicture [_index, _icon];
		_combo lbSetPictureColor [_index, _color];
	};
} foreach allMapMarkers;
