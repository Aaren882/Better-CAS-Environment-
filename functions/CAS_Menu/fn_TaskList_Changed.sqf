params ["_control", "_curLine","_IDCs","_IDC_offset",["_type_changed",false]];

private _display = ctrlParent _control;
private _curType = [0] call BCE_fnc_get_TaskCurType;
private _typeIndex = "AIR" call BCE_fnc_get_TaskCateIndex;
private _taskVar = (_typeIndex call BCE_fnc_getTaskVar) # 0;
private _vehicle = [nil, _typeIndex] call BCE_fnc_get_TaskCurUnit;

private _title = _display displayCtrl (_IDC_offset + 2003);
private _abort = _display displayCtrl (_IDC_offset + 21050);

private _titlePOS = ctrlPosition _title;
_title ctrlSetText (_control lbtext _curLine);

//-Task Expressions
private _shownCtrls = [_display,_curLine,1,_type_changed] call BCE_fnc_Show_CurTaskCtrls;

// - ["_9line","_5line"]
private _TaskList = _display displayCtrl (_IDCs # _curType);
switch _curType do {
	//-5 line
	case 1: {
		call BCE_fnc_DblClick5line_OLD;
	};
	//-9 line
	default {
		call BCE_fnc_DblClick9line_OLD;
	};
};
// #TODO - Implement the new framework
// ["BCE_TaskBuilding_Opened", [_curLine]] call CBA_fnc_localEvent;

//-Write down Description
private _description = "taskDesc" call BCE_fnc_getTaskSingleComponent;
private _text = format ["<t size='1'>%2</t>",[0.6,0.8] select ("chinese" in language),_TaskList lbData _curLine];
_description ctrlSetStructuredText parseText _text;

//-hide "Clear" + "Abort Mission" + "Enter" buttons
{(_display displayCtrl (_IDC_offset + _x)) ctrlshow (count _shownCtrls > 0)} forEach [2106,21050,21051];
(_display displayCtrl (_IDC_offset + 2106)) ctrlSetBackgroundColor ([[1,0,0,0.5],[0,0,0,0.8]] select ((_taskVar # _curLine # 0) == "NA"));
_abort ctrlEnable ((_vehicle getVariable ["BCE_Task_Receiver",""]) != "");
