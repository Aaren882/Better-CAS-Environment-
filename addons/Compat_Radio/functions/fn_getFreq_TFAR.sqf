#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_fnc_getFreq_TFAR
Description:
		Get the current radio frequency of the given unit.

Parameters:
		_unit  - Vehicle OBJECT <STRING>

Returns:
		Vehicle Radio Frequency <STRING>

Examples
		(begin example)
				player call BCE_fnc_getFreq_TFAR
		(end)

Author:
		Aaren
---------------------------------------------------------------------------- */

Params ["_unit"];
TRACE_1("fn_getFreq_TFAR",_this);

((_unit call TFAR_fnc_VehicleLR) call TFAR_fnc_getLrFrequency)
