/*
	NAME : BCE_fnc_ATAK_FireAdjust_Init_Impact
*/
params ["_AdjustGrp","_config"];

private _AdjustBnt = _AdjustGrp controlsGroupCtrl 5003;

//- Refresh UI Values
	_AdjustBnt call BCE_fnc_UpdateFireAdjust; //- Refresh UI Values
