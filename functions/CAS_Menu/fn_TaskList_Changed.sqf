params ["_control", "_curLine","_IDCs","_IDC_offset",["_type_changed",false]];

_display = ctrlParent _control;
_curType = ["Type",0] call BCE_fnc_get_TaskCurSetup;
_taskVar = ((["9Line","5Line"] # _curType) call BCE_fnc_getTaskVar) # 0;

_title = _display displayCtrl (_IDC_offset + 2003);
_abort = _display displayCtrl (_IDC_offset + 21050);

_titlePOS = ctrlPosition _title;
_title ctrlSetText (_control lbtext _curLine);

//-Task Expressions
_shownCtrls = [_display,_curLine,1,_type_changed] call BCE_fnc_Show_CurTaskCtrls;

// - ["_9line","_5line"]
_TaskList = _display displayCtrl (_IDCs # _curType);
switch _curType do {
	//-5 line
	case 1: {
		call BCE_fnc_cTab_5_TaskChanged;
	};
	//-9 line
	default {
		call BCE_fnc_cTab_9_TaskChanged;
	};
};

//-Write down Description
_description = _display displayctrl (_IDC_offset + 2004);
_text = format ["<t size='%1'>%2</t>",[0.6,0.8] select ("chinese" in language),_TaskList lbData _curLine];
_description ctrlSetStructuredText parseText _text;

//-hide "Clear" + "Abort Mission" + "Enter" buttons
{(_display displayCtrl (_IDC_offset + _x)) ctrlshow (count _shownCtrls > 0)} forEach [2106,21050,21051];
(_display displayCtrl (_IDC_offset + 2106)) ctrlSetBackgroundColor ([[1,0,0,0.5],[0,0,0,0.8]] select ((_taskVar # _curLine # 0) == "NA"));
