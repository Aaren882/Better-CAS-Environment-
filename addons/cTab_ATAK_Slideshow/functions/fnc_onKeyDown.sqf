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

//- #NOTE - This updates the actual referenced data of EGVAR(cTab_ATAK_taskViewer,MediaData)
private _result = switch (_key) do {
	case DIK_PERIOD: {
		call FUNC(IncreaseCurPageValue);
	};
	case DIK_COMMA: {
		call FUNC(DecreaseCurPageValue);
	};
};

if (_result) then {
	//- Setup contents
	_slideshow_CtrlGroup call FUNC(displayMedia);
};

//- if "True" will intercepts the default action
_result