#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_cTab_ATAK_Slideshow_fnc_onLoad
Description:
		Description.

Parameters:
		_param  - Parameter description <OBJECT>

Returns:
		Return description <NONE>

Author:
		Aaren
---------------------------------------------------------------------------- */
disableSerialization;

params ["_slideshow_CtrlGroup"];
TRACE_1("fnc_onLoad",_this);

//- #LINK - addons/cTab_ATAK_taskViewer/functions/fnc_LoadMediaData.sqf
private _mediaMap = missionNamespace getVariable [QEGVAR(cTab_ATAK_taskViewer,MediaData), createHashMap];

if (count _mediaMap isEqualTo 0) exitWith {
	ERROR_MSG("Slideshow initialization failed: Media data is empty.");
};

//- Setup media players
private _mediaPlayersGroup = _slideshow_CtrlGroup controlsGroupCtrl 10;
private _mediaPlayers = createHashMapFromArray ((allControls _mediaPlayersGroup) apply {[ctrlClassName _x, _x]}) ;
_slideshow_CtrlGroup setVariable ["MediaPlayers", _mediaPlayers];

private _media = _mediaMap get "Media";
private _mediaSel = _mediaMap get "Index";

(_media # _mediaSel) params ["_mediaType", "_content"];

private _mediaPlayer = _mediaPlayers getOrDefault [_mediaType, controlNull];
_mediaPlayer ctrlShow true;

//- Setup contents
_slideshow_CtrlGroup call FUNC(displayMedia);

//- CT_WEBBROWSER "IMAGE" -> #LINK - addons/cTab_ATAK_Slideshow/UI/elements.hpp
/* {
	_y ctrlAddEventHandler ["PageLoaded", { 
		params ["_control"];
		TRACE_1("fnc_onLoad [PageLoaded]",_this);

		// [FUNC(displayMedia), ctrlParentControlsGroup _control, 5] call CBA_fnc_waitAndExecute;

		(ctrlParentControlsGroup _control) call FUNC(displayMedia);
		// (ctrlParentControlsGroup _control) call FUNC(displayMedia);
	}];
} forEach _mediaPlayers; */

//- Setup contents
// [FUNC(displayMedia), _slideshow_CtrlGroup, 1] call CBA_fnc_waitAndExecute;
