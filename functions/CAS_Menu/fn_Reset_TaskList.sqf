params ["_display",["_IDC_offset",0],["_clear_index",-1]];
private ["_items","_all_lists","_curType","_TaskType","_description","_Tasklist","_all_Tasks","_TextR"];

_items = switch _IDC_offset do {
	case 17000: {
		cTab_Task_TaskItems
	};
	default {
		AVT_Task_TaskItems
	};
};

_all_lists = [_IDC_offset + 2002,_IDC_offset + 2005];
_all_lists apply {
	(_display displayctrl _x) ctrlshow false;
};

_curType = uiNameSpace getVariable ["BCE_Current_TaskType",0];

_TaskType = _display displayctrl (_IDC_offset + 2107);
_description = _display displayctrl (_IDC_offset + 2004);
_Tasklist = _display displayctrl (_all_lists # _curType);

_TaskType lbSetCurSel _curType;
_Tasklist lbSetCurSel 0;

//-All Tasks
_all_Tasks = ["BCE_CAS_9Line_Var","BCE_CAS_5Line_Var"];

//-Clear Select index value
if (_clear_index > -1) then {
	[(_display displayCtrl (17000 + 12010)), false, 'cTab_Tablet_dlg', 17000, _clear_index] call BCE_fnc_clearTaskInfo;
} else {
	private _text = format ["<t size='%1'>%2</t>",[0.6,0.8] select ("chinese" in language),_Tasklist lbdata (lbCurSel _Tasklist)];

	//-Set Description
	_description ctrlSetStructuredText parseText _text;
};

//-Update Contents for all lists
_TextR = _items # 1;
{
	private ["_TaskList","_text"];
	_TaskList = _display displayctrl (_all_lists # _forEachIndex);
	_text = _TextR # _forEachIndex;
	{
		private ["_writeDown","_txt"];
		_writeDown = (_text # _forEachIndex) param [1,""];
		_txt = if ((_x # 0) == "NA") then {
			_text # _forEachIndex # 0
		} else {
			[_x # 0, _writeDown] select (_writeDown != "")
		};

		_TaskList lbSetTextRight [_forEachIndex, _txt];
	} forEach (uiNameSpace getVariable _x);
} forEach _all_Tasks;
