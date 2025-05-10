/* 
	NAME : BCE_fnc_checkList
 */
params ["_display","_checklist","_vehicle","_skip",["_loop",true],["_include0",true]];

private _list = call BCE_fnc_getCompatibleAVs;

private _Task_Type = _display displayCtrl 2107;
private _TaskList = switch (_Task_Type lbValue (lbCurSel _Task_Type)) do {
	//-5 line
	case 1: {
		_display displayCtrl 2005
	};
	//-9 line
	default {
		_display displayCtrl 2002
	};
};

if (
	!(_vehicle in _list) ||
	 (isnull _checklist) ||
	!(ctrlShown _checklist) ||
	!(ctrlEnabled _checklist) ||
	 ((_display displayCtrl 1700) lbIsSelected 0) ||
	(
		(ctrlShown _TaskList) &&
		(_loop)
	) || (
		!(_vehicle isEqualTo ([] call BCE_fnc_get_TaskCurUnit)) &&
		(_skip)
	)
) exitWith {};

//-Clear First
lbClear _checklist;

[_checklist,_vehicle] call (uiNamespace getVariable "BCE_fnc_WPN_List_AIR");

if (_loop) then {
	_this set [3,true];
	[BCE_fnc_checkList, _this, 1] call CBA_fnc_WaitAndExecute;
};
