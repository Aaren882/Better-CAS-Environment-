#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_fnc_getMarkerItem
Description:
		Retrieves display name, icon path, shadow visibility, and size for a specific marker type.

Parameters:
		_markerType - markerType name to retrieve marker data for <STRING>
		
Returns:
		_markerName 	- Display name of the marker <STRING>
		_icon					- Path to marker icon <STRING>
		_shadow				- Marker has shadow [0,1] <NUMBER>
		_size					- Size of the marker <NUMBER>
		_CategoryName - Category name that the marker belongs to <STRING>

Author:
		Aaren
---------------------------------------------------------------------------- */

params ["_markerType"];
TRACE_1("fn_getMarkerItem",_this);

private _map = uiNamespace getVariable "BCE_Marker_MapItems";

//- Set Marker Cache
if (isNil "_map") then {
	private _start = diag_tickTime;

	_map = createHashMap;
	private _classes = "true" configClasses (configFile >> "cTab_CfgMarkers");
	private _config = configFile >> "CfgMarkers";

	{
		private _CategoryName = configName _x;
		(_CategoryName call BCE_fnc_getMarkerCategory) params ["_markerTypes"];

		{ 
			private _name = getText (_config >> _x >> "name");
			private _icon = getText (_config >> _x >> "icon");
			private _shadow = getNumber (_config >> _x >> "shadow");
			private _size = getNumber (_config >> _x >> "size");
			_map set [_x, [_name, _icon, _shadow, _size, _CategoryName]];
		} forEach _markerTypes;
	} forEach _classes;

	INFO_2("Cache ""fn_getMarkerItem"" %1 sec : %2",(diag_tickTime - _start),_map);
	uiNamespace setVariable ["BCE_Marker_MapItems", _map];
};

_map getOrDefault [_markerType, []];