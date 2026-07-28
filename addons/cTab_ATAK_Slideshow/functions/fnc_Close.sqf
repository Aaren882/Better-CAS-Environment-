#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_cTab_ATAK_Slideshow_fnc_Close
Description:
		Closes the slideshow interface by deleting its associated control group.
		then update the cTab interface settings.

Parameters:
		_bnt_Ctrl - The Close button. <CONTROL>

Returns:
		<NONE>

Author:
		Aaren
---------------------------------------------------------------------------- */

params [["_bnt_Ctrl",controlNull,[controlNull]]];
TRACE_1("fnc_Close",_this);

if (isNull _bnt_Ctrl) exitWith {
	ERROR_MSG("Error: Button control is null.");
};

//- Delete Current controlGroup
private _ctrlGroup = ctrlParentControlsGroup _bnt_Ctrl;
ctrlDelete _ctrlGroup;

LOG_1("[className] _ctrlGroup = ""%1""",ctrlClassName _ctrlGroup);

//- Update ATAK interface 
private _displayName = cTabIfOpen # 1;

//- Update Interface
[_displayName,[["popUpMenu",""]], true] call cTab_fnc_setSettings;

nil