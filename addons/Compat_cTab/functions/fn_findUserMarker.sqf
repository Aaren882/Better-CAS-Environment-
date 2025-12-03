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

//- #TODO - Use ctrlMapMouseOver
//  : https://community.bistudio.com/wiki/ctrlMapMouseOver?useskin=darkvector
// private _mouseover = ctrlMapMouseOver _ctrl;

private ["_return","_targetRadius","_maxDistance"];
_return = -1;

// figure out radius around cursor box based on map zoom and scale
_targetRadius = cTabIconSize * 2 * (ctrlMapScale _ctrl) * cTabMapScaleFactor;
_maxDistance = _searchPos distanceSqr [(_searchPos # 0) + _targetRadius, (_searchPos # 1) + _targetRadius];

// find closest user marker within _maxDistance
{
	private ["_veh","_pos","_distance"];
	_veh = _x # 0;
	_pos = if (ctab_core_bft_mode == 1) then { getPosASLVisual _veh } else { _x # 5 };
	_pos resize 2;

	_distance = _searchPos distanceSqr _pos;
	if (
			(_distance <= _maxDistance) && (
				_veh in cTabUAVlist ||
				_veh in cTabARTYlist
			)
		) exitWith {
		_maxDistance = _distance;
		_return = _veh;
	};
} count cTabBFTvehicles;

{
	_x params ["_marker","","_ID","_markerShape"];

	if (_markerShape == 0) then {
		if (
			getNumber (configFile >> "CfgMarkers" >> markerType _marker >> "size") == 0
		) then {continue};
		private _pos = getMarkerPos _marker;
		_pos resize 2;
		private _distance = _searchPos distanceSqr _pos;
		if (_distance <= _maxDistance) exitWith {
			_maxDistance = _distance;
			_return = _ID;
		};
	} else {
		if (_searchPos inArea _marker) exitWith {
			_return = _ID;
		};
	};
} count cTabMarkerList;

_return
