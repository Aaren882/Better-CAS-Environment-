#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_cTab_ATAK_taskViewer_fnc_LoadMediaData
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

params [["_bnt_Ctrl",controlNull,[controlNull]]];
TRACE_1("fnc_LoadMediaData",_this);

if (isNull _bnt_Ctrl) exitWith {
	ERROR_MSG("Error: Button control is null.");
};

//- Get Current controlGroup "Media" Data
private _ctrlGroup = ctrlParentControlsGroup _bnt_Ctrl;
private _media = _ctrlGroup getVariable ["Media", createHashMap];

//- Media data are from 👇
//- #LINK - addons/cTab_ATAK_taskViewer/functions/fnc_ATAK_Tag_Init.sqf
GVAR(MediaData) = _media;
TRACE_1("fnc_LoadMediaData [Media]",GVAR(MediaData));

nil