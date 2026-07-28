#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_cTab_ATAK_Slideshow_fnc_IncreaseCurPageValue
Description:
		Increments the current page index of the media slideshow and updates the view.

Parameters:
		<NONE>

Returns:
		<BOOL>

Author:
		Aaren
---------------------------------------------------------------------------- */

TRACE_1("fnc_IncreaseCurPageValue",_this);

private _mediaMap = missionNamespace getVariable [QEGVAR(cTab_ATAK_taskViewer,MediaData), createHashMap];
if (count _mediaMap isEqualTo 0) exitWith {
	ERROR_MSG("Media data map is empty.");
	false
};

private _current = _mediaMap get "Index";
private _max = count (_mediaMap get "Media") - 1;

//- Out of range
if (_current >= _max) exitWith {false};

_current = _current + 1;
_current call FUNC(SetPage); //- Update Page
