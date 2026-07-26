#include "\a3\ui_f\hpp\definedikcodes.inc"
#include "script_component.hpp"

/* ----------------------------------------------------------------------------
Function: BCE_cTab_ATAK_Slideshow_fnc_onKeyDown
Description:
		Description.

Parameters:
		_param  - Parameter description <OBJECT>

Returns:
		<NONE>

Author:
		Aaren
---------------------------------------------------------------------------- */

params ["_slideshow_CtrlGroup", "_key", "_shift", "_ctrl", "_alt"];
TRACE_1("fnc_onKeyDown",_this);

private _mediaMap = missionNamespace getVariable [QEGVAR(cTab_ATAK_taskViewer,MediaData), createHashMap];
if (count _mediaMap isEqualTo 0) exitWith {
	ERROR_MSG("Media data map is empty.");
};

private _current = _mediaMap get "Index";

//- #NOTE - This updates the actual referenced data of EGVAR(cTab_ATAK_taskViewer,MediaData)
private _result = switch (_key) do {
	case DIK_PERIOD: {
		private _max = count (_mediaMap get "Media") - 1;

		if (_current < _max) then {
			_mediaMap set ["Index", _current + 1];
		};

		true
	};
	case DIK_COMMA: {
		if (_current > 0) then {
			_mediaMap set ["Index", _current - 1];
		};

		true
	};
	default { false	};
};

if (_result) then {
	TRACE_1("fnc_onKeyDown [Update]",_mediaMap);

	//- Setup contents
	_slideshow_CtrlGroup call FUNC(displayMedia);	
};

//- if "True" will intercepts the default action
_result