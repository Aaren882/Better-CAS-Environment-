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
[{
	params ["_args", "_handle"];
	_args params ["_mediaMap","_mediaPlayers"];

	private _media = _mediaMap get "Media";
	private _mediaSel = _mediaMap get "Index";

	(_media # _mediaSel) params ["_mediaType", "_content"];

	private _mediaPlayer = _mediaPlayers getOrDefault [_mediaType, controlNull];
	if (isNull _mediaPlayer) exitWith {
		localNamespace setVariable [QGVAR(JS),nil];
		[_handle] call CBA_fnc_removePerFrameHandler;
	};

	private _js = localNamespace getVariable [QGVAR(JS),""];
	if (_js isNotEqualTo "") then {
		TRACE_1("fnc_onLoad [LOOP]",_js);
		_mediaPlayer ctrlWebBrowserAction ["ExecJS", _js];
	};
}, 1, [_mediaMap, _mediaPlayers]] call CBA_fnc_addPerFrameHandler;

//- CT_WEBBROWSER "IMAGE" -> #LINK - addons/cTab_ATAK_Slideshow/UI/elements.hpp
{
	private _ctrl = _y;

	_ctrl ctrlAddEventHandler ["PageLoaded", { 
		params ["_control"];
		TRACE_1("fnc_onLoad [PageLoaded]",_this);

		(ctrlParentControlsGroup _control) call FUNC(displayMedia);
	}];

	_ctrl ctrlAddEventHandler ["JSDialog", {
		params ["_control", "_isConfirmDialog", "_message"];
		
		//- Clean up
		if (_isConfirmDialog) then {
			localNamespace setVariable [QGVAR(JS),nil];
		};

		TRACE_2("fnc_onLoad [JSDialog]",_isConfirmDialog,_message);
		hintSilent format ["_isConfirmDialog = %1\n ""%2""",_isConfirmDialog,_message];
		true; // We need to tell it that we handled the "dialog", by returning true or false.
	}];
} forEach _mediaPlayers;

//- Setup contents
// [FUNC(displayMedia), _slideshow_CtrlGroup, 1] call CBA_fnc_waitAndExecute;
