params ["_control", "_lbCurSel"];

private _mapValue = _control getVariable ["CheckList",createHashMap];
private _data = _mapValue get (_control lbData _lbCurSel);
_data params ["",["_magazineCount",0]];

{
	private _fireUnits = _x call BCE_fnc_getTaskSingleComponent;
	lbClear _fireUnits;

	//- If it's in Adjust Section
	if ("CFF_IA_FireUnit_Combo" == _x) then {
		private _add = _fireUnits lbAdd "--";
		_fireUnits lbSetValue [_add, -1];
	};

	for "_i" from 1 to _magazineCount do {
		private _add = _fireUnits lbAdd (str _i);
		_fireUnits lbSetValue [_add, _i];
	};
} forEach [
	"CFF_IE_FireUnit_Combo", //- Add FireUnit forEach drop menu
	"CFF_IA_FireUnit_Combo"
];