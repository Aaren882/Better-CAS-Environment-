params ["_control","_lbCurSel"];

private _veh = objNull;
private _veh_str = _control lbdata _lbCurSel;
if (_veh_str != "") then {
	{
		if (_veh_str == str _x) exitWith {
			_veh = _x;
		};
	} count vehicles;	
};

_veh call BCE_fnc_set_TaskCurUnit;