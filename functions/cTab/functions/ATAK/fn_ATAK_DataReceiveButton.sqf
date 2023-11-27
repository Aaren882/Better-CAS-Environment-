params ["_control"];
private ["_curType","_taskVar","_display","_TaskList","_components","_isOverwrite","_DESC_Type"];

(["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings) params ["","_shown","_curLine"];

if !(_shown) exitwith {};

_curType = uiNameSpace getVariable ["BCE_Current_TaskType",0];
_taskVar = uiNameSpace getVariable (["BCE_CAS_9Line_Var","BCE_CAS_5Line_Var"] # _curType);

if (isnil {_taskVar}) exitWith {hintSilent "Error Variable is empty"};

_display = ctrlParent _control;

_TaskList = _display displayCtrl (17000+4661);
_components = _display displayCtrl (17000+4662);

//-get Title IDC
if (_curLine > count _taskVar) then {
	_curLine = (count _taskVar) - 1;
};
_isOverwrite = false;
_DESC_Type= uiNamespace getVariable ["BCE_ATAK_Desc_Type",0];

// {
// 	private ["_text","_shownCtrls"];
// 	_text = nil;
// 	//-For ATAK DESC Lines
// 	if (_forEachIndex == 1) then {
// 		_curLine = [5,3] # _curType;
// 		if (_DESC_Type != 0) then {
// 			_text = (_TaskList controlsGroupCtrl (17000 + ([2027,2043] # _curType))) lbText _DESC_Type;
// 		};
// 	};
// 	if (_curLine < 0) then {continue};

// 	_shownCtrls = [_x,_curLine,1,false,true] call BCE_fnc_Show_CurTaskCtrls;
// 	call _fnc;
// } foreach [_components,_TaskList];
_shownCtrls = [_components,_curLine,1,false,true] call BCE_fnc_Show_CurTaskCtrls;
call ([BCE_fnc_DataReceive9line, BCE_fnc_DataReceive5line] # _curType);

call BCE_fnc_ATAK_Refresh_TaskInfos;