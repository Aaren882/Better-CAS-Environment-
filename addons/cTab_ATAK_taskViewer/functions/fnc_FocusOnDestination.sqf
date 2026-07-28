#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_cTab_ATAK_taskViewer_fnc_FocusOnDestination
Description:
		Animates the target map control to focus on a specific destination position based on control variables.

Parameters:
		_bnt_Ctrl  - The control object triggering the focus operation. <CONTROL>

Returns:
		<NONE>

Author:
		Aaren
---------------------------------------------------------------------------- */

params [["_bnt_Ctrl",controlNull,[controlNull]]];
TRACE_1("fnc_FocusOnDestination",_this);

private _tagGroup = ctrlParentControlsGroup _bnt_Ctrl;
private _position = _tagGroup getVariable ["Position", []];

if (_position isEqualTo []) exitWith {
	ERROR_MSG("Target ""Position"" not available.");
};

private _displayName = cTabIfOpen param [1, ""];
if (_displayName isEqualTo "") exitWith {
	ERROR_MSG("""DisplayName"" not provided.");
};

private _display = ctrlParent _bnt_Ctrl;
private _targetMapName = [_displayName,"mapType"] call cTab_fnc_getSettings;
private _mapTypes = [_displayName,"mapTypes"] call cTab_fnc_getSettings;
private _targetMapIDC = [_mapTypes,_targetMapName] call cTab_fnc_getFromPairs;
private _targetMapCtrl = _display displayCtrl _targetMapIDC;

//- Start focus animation
private _targetMapScale = ctrlMapScale _targetMapCtrl;
_targetMapCtrl ctrlMapAnimAdd [0.5, _targetMapScale, _position];
ctrlMapAnimCommit _targetMapCtrl;
