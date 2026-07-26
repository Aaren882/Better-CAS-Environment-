#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_cTab_ATAK_Slideshow_fnc_PopUp
Description:
		Setting up a pop-up menu.
		then update the cTab interface settings.

Parameters:
		_menuClassName  - The UI controlGroup class name for the pop-up menu. <STRING>

Returns:
		<NONE>

Author:
		Aaren
---------------------------------------------------------------------------- */

params [["_menuClassName", "", [""]]];
TRACE_1("fnc_PopUp",_this);

if (_menuClassName isEqualTo "") exitWith {
	ERROR_MSG_1("Error: Menu class name not provided. (_menuClassName = ""%1"")",_menuClassName);
};

//- Update ATAK interface 
private _displayName = cTabIfOpen # 1;
private _setting = [_displayName, "popUpMenu"] call cTab_fnc_getSettings;

//- Update Interface
[_displayName,[["popUpMenu",_menuClassName]],true] call cTab_fnc_setSettings;

nil