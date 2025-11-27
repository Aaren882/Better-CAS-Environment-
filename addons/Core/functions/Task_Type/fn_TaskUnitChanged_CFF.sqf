params ["_unit","_taskUnit"];

private _artyGrp = "Vehicle_Grp_Sel" call BCE_fnc_getTaskSingleComponent;

if (isnull _artyGrp) exitWith {};

private _curSel = 0;
private _Empty_Sel = [];

//- Get "NA" from List
for "_i" from 0 to (lbsize _artyGrp - 1) do {
	if (_artyGrp lbValue _i > -1) then {break};
	_Empty_Sel pushBack (_artyGrp lbText _i);
};

lbClear _artyGrp;

//- Re-create List
{
	private _add = _artyGrp lbAdd _x;
	_artyGrp lbSetValue [_add,-1];

	if (isnull _taskUnit) then {
		_curSel = _add;
	};
} forEach _Empty_Sel;

{
	private _add = _artyGrp lbAdd (groupId group _x);
	_artyGrp lbSetData [_add, str _x];

	if (_taskUnit == _x) then {
		_curSel = _add;
	};
} forEach (call BCE_fnc_getCompatibleARTYs);

_artyGrp lbSetCurSel _curSel;

//- Refresh Weapons
	["BCE_TaskBuilding_Opened", [0]] call CBA_fnc_localEvent;
