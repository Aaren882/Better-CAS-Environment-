params ["_control", "_lbCurSel"];

private _mapValue = _control getVariable ["CheckList",createHashMap];
private _data = _mapValue get (_control lbData _lbCurSel);
_data params ["",["_magazineCount",0]];

private _fireUnits = "Attack_CFF_FireUnit_Combo" call BCE_fnc_getTaskSingleComponent;
lbClear _fireUnits;

for "_i" from 1 to _magazineCount do {
	private _add = _fireUnits lbAdd (str _i);
	_fireUnits lbSetValue [_add, _i];
};

//- Restore State
	private _type = "CFF" call BCE_fnc_get_TaskIndex;
	(_type call BCE_fnc_getTaskVar) params ["_taskVar"];

	private _taskVar_0 = _taskVar # 0;
	(_taskVar_0 param [2,[]]) params [
		"",
		"",
		["_ctrlSel2",0]
	];

	_fireUnits lbSetCurSel _ctrlSel2;