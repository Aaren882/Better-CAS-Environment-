params ["_connect","_display"];

//- Update Interface
	"showMenu" call BCE_fnc_cTab_UpdateInterface;

private _settings = ["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings;
private _page = _settings param [0,""];

if (_page != "mission") exitWith {};

(call BCE_fnc_ATAK_getCurrentAPP) params ["_page","_TaskList"];

//- Pylon info
if (_connect) then {
	//-Connected
	_TaskList call BCE_fnc_ATAK_Refresh_Weapons;
} else {
	//-Disconnected
	{lbClear (_TaskList controlsGroupCtrl (17000 + 2020 + _x))} count [0,1];
};