#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_cTab_ATAK_Slideshow_fnc_SetPage
Description:
		Sets the page value (index) for the slideshow media map.

Parameters:
		_pageValue  - The index <NUMBER> of the page to display.

Returns:
		<BOOL> - TRUE if the page was successfully set, FALSE otherwise
					 : (e.g., if media map is empty or page value is nil).

Examples
		(begin example)
				[1] call BCE_cTab_ATAK_Slideshow_fnc_SetPage
		(end)

Author:
		Aaren
---------------------------------------------------------------------------- */

params [["_pageValue", nil, [0]]];
TRACE_1("fnc_SetPage",_this);

if (isNil "_pageValue") exitWith {
	ERROR_MSG("Page value is nil.");
	false
};

private _mediaMap = missionNamespace getVariable [QEGVAR(cTab_ATAK_taskViewer,MediaData), createHashMap];
if (count _mediaMap isEqualTo 0) exitWith {
	ERROR_MSG("Media data map is empty.");
	false
};

_mediaMap set ["Index", _pageValue];