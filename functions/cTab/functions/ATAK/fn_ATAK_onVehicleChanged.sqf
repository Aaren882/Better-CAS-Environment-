params ["_connect","_display"];

private ["_group","_bnt_Ent","_vehicle","_condition"];

//-on vehicle changed
_group = _display displayCtrl 46600;
_bnt_Ent = _group controlsGroupCtrl 11;

_vehicle = player getVariable ['TGP_View_Selected_Vehicle',objNull];
_condition = (count (_vehicle getVariable ["BCE_Task_Receiver",[]])) > 0;

_bnt_Ent ctrlSetText localize (["STR_BCE_SendData","STR_BCE_Abort_Task"] select _condition);
_bnt_Ent ctrlSetBackgroundColor ([
	[
		(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77]),
		(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51]),
		(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08]),
		0.8
	],[
		1,0,0,0.5
	]
] select _condition);

if (_connect) then {
	//-Connected
	_display call BCE_fnc_ATAK_Refresh_Weapons;
} else {
	//-Disconnected
	_group = _display displayCtrl (17000 + 4661);
	{lbClear (_group controlsGroupCtrl (17000 + 2020 + _x))} count [0,1];
};