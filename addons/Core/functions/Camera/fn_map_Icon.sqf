allMapMarkers apply {
	private _Channel = markerChannel _x;
	((getMarkerType _x) call BCE_fnc_getMarkerItem) params ["_name","_icon","_shadow","_size"];

	//-Exclude Polylines
	if (
			(_size != 0) &&
			("ICON" == MarkerShape _x) &&
			(
				[_Channel < 0, _Channel > -1] select isMultiplayer
			)
		) then {

		//-Color
		private _color = (markerColor _x) call BCE_fnc_getMarkerColor;

		drawIcon3D [
			_icon,
			_color,
			getMarkerPos _x,
			1,
			1,
			0,
			markerText _x,
			1,
			0.04,
			"PuristaMedium",
			"",
			false
		];
	};
};
