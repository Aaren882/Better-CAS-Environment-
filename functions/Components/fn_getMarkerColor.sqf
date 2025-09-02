/*
	NAME : BCE_fnc_getMarkerColor

	Get Marker Color from CfgMarkerColors

	return :
		["Color", "Name"]
*/

params [["_colorFind", ""]];

private _cache = uiNamespace getVariable ["BCE_Marker_Color",createHashMap];

//- Check cache exist
	if (count _cache == 0) then {
		private _cfg = "getnumber (_x >> 'scope') == 2" configClasses (configFile >> "CfgMarkerColors");
		
		private _markerColors = _cfg apply {
			// private _name = getText (_x >> "name");
			private _color = (getArray (_x >> "color")) apply {
				if (_x isEqualType "") then {call compile _x} else {_x};
			};
			[configName _x, _color/*[, getText (_x >> "name")]*/]
		};
		_cache = createHashMapFromArray _markerColors;

		//- Save Marker Color Cache
		uiNamespace setVariable ["BCE_Marker_Color_Array", _markerColors apply {_x # 0}];
		uiNamespace setVariable ["BCE_Marker_Color", _cache];
	};


//- Return
	_cache getOrDefault [_colorFind, []];