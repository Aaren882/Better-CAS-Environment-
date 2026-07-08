/*
	NAME : BCE_fnc_ATAK_FireAdjust_Init_Polar
*/
params ["_AdjustGrp","_config"];

private _AdjustBnt = _AdjustGrp controlsGroupCtrl 5003;

_AdjustBnt call BCE_fnc_UpdateFireAdjust; //- Refresh UI Values

//- Set offset Meter display button
private _AdjustMeter = _AdjustGrp controlsGroupCtrl 5004;
[{
	private _MeterValue = ([] call BCE_fnc_get_FireAdjustValues) # 1;
	_this ctrlSetText format ["<-- %1 m -->", _MeterValue * 10];
}, _AdjustMeter] call CBA_fnc_execNextFrame;
