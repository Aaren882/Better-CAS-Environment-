#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_cTab_ATAK_missions_fnc_ATAK_onVehicleChanged
Description:
		Handles changes in vehicle status within the mission interface, updating UI elements and mission data.

Parameters:
		_connect  - Indicates if the vehicle is connected to the system <BOOL>.
		_display  - Reference to the display component <DISPLAY>.

Returns:
		<NONE>

Author:
		Aaren
---------------------------------------------------------------------------- */

params ["_connect","_display"];
TRACE_1("fnc_ATAK_onVehicleChanged",_this);

//- Update Interface
	"showMenu" call BCE_fnc_cTab_UpdateInterface;

private _settings = ["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings;
private _page = _settings param [0,""];

if (_page != "mission") exitWith {};

(call BCE_fnc_ATAK_getCurrentAPP) params ["_page","_TaskList"];

//- Pylon info
if (_connect) then {
	//-Connected
	_TaskList call EFUNC(cTab_ATAK_missions,ATAK_Refresh_Weapons);
} else {
	//-Disconnected
	{lbClear (_TaskList controlsGroupCtrl (17000 + 2020 + _x))} count [0,1];
};
