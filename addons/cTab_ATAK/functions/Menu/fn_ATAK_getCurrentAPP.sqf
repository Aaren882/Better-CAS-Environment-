#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_fnc_ATAK_getCurrentAPP
Description:
		Retrieves the currently active application's name (string) and its corresponding menu CONTROL within ATAK.

Parameters:
		[]    - NONE

Returns:
		ARRAY - [appName, menuControl]. appName is a string, and CONTROL is a number.

Examples
		(begin example)
				call BCE_fnc_ATAK_getCurrentAPP
		(end)

Author:
		Aaren
---------------------------------------------------------------------------- */

private _displayName = cTabIfOpen param [1,""];
if (_displayName == "") exitWith {["",controlNull]};

//- Don't Run this onEachFrame or similar
  private _display = uiNamespace getVariable _displayName;
  private _order = [] call BCE_fnc_ATAK_getAPPs;
  private _settings = ["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings;
  private _page = _settings param [0, ""];

private _Apps_Group = _display displayCtrl (17000 + 4650);
private _menuIDC = 15000 + (_order find _page);

[_page, _Apps_Group controlsGroupCtrl _menuIDC];
