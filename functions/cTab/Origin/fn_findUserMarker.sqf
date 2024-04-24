/*
 	Name: cTab_fnc_findUserMarker

 	Author(s):
		Gundy, Riouken

		Edit:
			Aaren

 	Description:
		Find user placed marker at provided position

	Parameters:
		0: OBJECT - Map control we took the position from
		1: ARRAY	- Position to look for marker

 	Returns:
		INTEGER - Index of user marker, if not found -1

 	Example:
		_markerIndex = [_ctrlScreen,[0,0]] call cTab_fnc_findUserMarker;
*/
params ["_ctrl","_searchPos"];


private ["_return","_targetRadius","_maxDistance","_markers"];
_return = -1;

// figure out radius around cursor box based on map zoom and scale
_targetRadius = cTabIconSize * 2 * (ctrlMapScale _ctrl) * cTabMapScaleFactor;
_maxDistance = _searchPos distanceSqr [(_searchPos # 0) + _targetRadius, (_searchPos # 1) + _targetRadius];

_markers = if (isMultiplayer) then {
	allMapMarkers select {markerChannel _x == currentChannel}
} else {
	allMapMarkers
};

// find closest user marker within _maxDistance
{
	private ["_pos","_distance"];
	_pos = getPos (_x # 0);
	_pos resize 2;
	_distance = _searchPos distanceSqr _pos;
	if ((_distance <= _maxDistance) && ((_x # 0) isKindOf "Air")) exitWith {
		_maxDistance = _distance;
		_return = _x # 0;

		_return
	};
} count cTabBFTvehicles;

{
	private _pos = getMarkerPos _x;
	_pos resize 2;
	private _distance = _searchPos distanceSqr _pos;
	if (_distance <= _maxDistance) exitWith {
		_maxDistance = _distance;
		_return = _forEachIndex;

		_return
	};
} forEach _markers;

_return
