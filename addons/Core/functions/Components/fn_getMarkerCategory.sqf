#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_fnc_getMarkerCategory
Description:
		Retrieves marker types that belong to a specific category along with associated color and direction visibility.

Parameters:
		_category - Category name to retrieve marker data for <STRING>
		
Returns:
		_markerTypes - Array of marker types that belong to the category <ARRAY>
		_color			 - Color associated with the category <ARRAY>
		_hide				 - Whether markers in this category have hidden direction [0,1] <NUMBER>

Author:
		Aaren
---------------------------------------------------------------------------- */

params ["_category"];
TRACE_1("fn_getMarkerCategory",_this);

private _map = uiNamespace getVariable "BCE_Marker_Map";

//- Set Marker Cache
if (isNil "_map") then {
	private _start = diag_tickTime;
	private _classes = "true" configClasses (configFile >> "cTab_CfgMarkers");

	private _result = _classes apply {

		private _CategoryName = configName _x;
		private _Categories = getArray (_x >> "Categories");
		private _color = (getText (_x >> "MarkerColor")) call BCE_fnc_getMarkerColor;
		private _hide = getNumber (_x >> "Hide_Direction");

		private _markerTypes = flatten (_Categories apply {
			(format [ 
				"(getText (_x >> 'markerClass') == '%1' && getNumber (_x >> 'scope') > 0)", _x 
			]) configClasses (configFile >> "CfgMarkers") apply { 

				configName _x
			};
		});

		private _result = [_markerTypes, _color];
		if (_hide > 0) then {
			_result pushBack 1;
		};

		[_CategoryName, _result]
	};

	_map = createHashMapFromArray _result;
	INFO_2("Cache ""fn_getMarkerCategory"" %1 sec : %2",(diag_tickTime - _start),_map);
	uiNamespace setVariable ["BCE_Marker_Map", _map];
};

_map getOrDefault [_category, []];