allMapMarkers apply {
	private _Channel = markerChannel _x;
	private _class = getMarkerType _x;
	private _path = configFile >> "CfgMarkers" >> _class;

	private _MP_Compat = if (isMultiplayer) then {
		_Channel >= 0
		//currentChannel == _Channel
	} else {
		_Channel == -1
	};
	//-Exclude Polylines
	if (
			(getNumber(_path >> "Size") != 0) &&
			((markerPolyline _x) isEqualTo []) &&
			(
				_MP_Compat
			)
		) then {
		private _text = markerText _x;

		//-Color
		private _color = (getArray (configFile >> "CfgMarkerColors" >> (markerColor _x) >> "Color")) apply {
			if (_x isEqualType "") then {
				call compile _x
			} else {
				_x
			};
		};

		drawIcon3D [
			getText (_path >> "icon"),
			_color,
			getMarkerPos _x,
			1,
			1,
			0,
			_text,
			1,
			0.04,
			"PuristaMedium",
			"",
			false
		];
	};
};
