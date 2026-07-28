#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_cTab_ATAK_Slideshow_fnc_DecreaseCurPageValue
Description:
		Decrements the current page index in the media map and updates the displayed page.

Parameters:
		<NONE>

Returns:
		<BOOL>

Author:
		Aaren
---------------------------------------------------------------------------- */

TRACE_1("fnc_DecreaseCurPageValue",_this);

private _mediaMap = missionNamespace getVariable [QEGVAR(cTab_ATAK_taskViewer,MediaData), createHashMap];
if (count _mediaMap isEqualTo 0) exitWith {
	ERROR_MSG("Media data map is empty.");
	false
};

private _current = _mediaMap get "Index";

//- Out of range
if (_current <= 0) exitWith {false};

_current = _current - 1;
_current call FUNC(SetPage); //- Update Page
