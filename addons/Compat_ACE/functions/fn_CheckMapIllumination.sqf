#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cTab_fnc_CheckMapIllumination
Description:
		Check ACE Map illumination is disabled OR no flashlight available.

Parameters:
		_unit  - Check unit <OBJECT>

Returns:
		Has flashlight to illuminate map <BOOL>

Examples
		(begin example)
				[params] call cTab_fnc_CheckMapIllumination
		(end)

Author:
		Aaren
---------------------------------------------------------------------------- */
params ["_unit"];

TRACE_1("fn_CheckMapIllumination",_this);

(
	(ace_map_mapillumination) &&
	(count ([_unit] call ace_map_fnc_getUnitFlashlights) > 0)
)