params [
	"_control",
	"_lbCurSel",
	["_IDC_offset",0]
];

private _display = ctrlParent _control;
private _NotAVT = _IDC_offset != 0;
private _IDCs = [2002,2005] apply {_x + _IDC_offset};
private _vehicle = [nil,"AIR" call BCE_fnc_get_TaskCateIndex] call BCE_fnc_get_TaskCurUnit;
_lbCurSel call BCE_fnc_set_TaskCurType;

// - ["_9line","_5line"]
//- Output all + hide them all
private _ctrls = _IDCs apply {
	private _ctrl = _display displayctrl _x;
	_ctrl ctrlShow false;
	_ctrl
};

private _TaskList = _ctrls # _lbCurSel;

// - for other mods
if (_NotAVT) then {
	[_TaskList,lbCurSel _TaskList,_IDCs,_IDC_offset,true] call BCE_fnc_TaskList_Changed;

	//- Air 5 Line
	if (_lbCurSel == 1) then {
		_TaskList lbSetText [0, format ["1: “%1”/“%2” :", groupId group _vehicle, groupId group player]];
	};

	{
		_x ctrlshow (_TaskList isEqualTo _x);
	} forEach _ctrls;
} else {
	if (ctrlShown _TaskList) then {
		_TaskList ctrlShow false;
	};
};
