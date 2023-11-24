params ["_control"];
(["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings) params ["","_shown","_curLine"];

if !(_shown) exitwith {};

_curType = uiNameSpace getVariable ["BCE_Current_TaskType",0];
_taskVar = uiNameSpace getVariable (["BCE_CAS_9Line_Var","BCE_CAS_5Line_Var"] # _curType);

if (isnil {_taskVar}) exitWith {hintSilent "Error Variable is empty"};

_display = ctrlParent _control;

_TaskList = _display displayCtrl (17000+4661);
_components = _display displayCtrl (17000+4662);
_fnc = [BCE_fnc_DataReceive9line, BCE_fnc_DataReceive5line] # _curType;

//-get Title IDC
if (_curLine > count _taskVar) then {
	_curLine = (count _taskVar)-1;
	//_title = 3002;
};
// else {
// 	private _titles = switch (_curType) do {
// 		case 1: {
// 			[2025,2026,2029,2030,2031,2032]
// 		};
// 		default {
// 			[2041,2042]
// 		};
// 	};
// 	_title = _titles # _curLine;
// };

_shownCtrls = [_components,_curLine,1,false,true,true] call BCE_fnc_Show_CurTaskCtrls;

call _fnc;

_DESC = _TaskList controlsGroupCtrl (17000 + ([2027, 2043] # _curType));
_DESC_type = lbCurSel _DESC;
_curLine = [5,4] # _curType;
_shownCtrls = [_TaskList,_curLine,1,false,true,true] call BCE_fnc_Show_CurTaskCtrls;

//-Get DESC [5,4] line
// _Text = if (_DESC_type == 0) then {
// 	ctrlText (_TaskList controlsGroupCtrl (17000 + ([2015, 2044] # _curType)));
// } else {
// 	_DESC lbText _DESC_type;
// };

call _fnc;
// _title = _TaskList controlsGroupCtrl ([17000 + _title, _title] select (_curLine > count _taskVar));
// _title ctrlSetStructuredText parseText (_taskVar # _curLine # 0);