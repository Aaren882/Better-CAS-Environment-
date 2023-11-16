params ["_display"];
private ["_showMenu","_TaskList","_components","_curType","_taskVar","_curLine","_all_lists","_Tasklist","_shownCtrls","_TaskListPOS","_titlePOS","_description","_desc"];

_showMenu = ["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings;
if (!(_showMenu # 1)) exitwith {};

_curType = uiNameSpace getVariable ["BCE_Current_TaskType",0];
_taskVar = uiNameSpace getVariable (["BCE_CAS_9Line_Var","BCE_CAS_5Line_Var"] # _curType);
if (isnil {_taskVar}) exitWith {hintSilent "Error Variable is empty"};

_curLine = _showMenu # 2;

_TaskList = _display displayCtrl (17000+4661);
_components = _display displayCtrl (17000+4662);
_description = _components controlsGroupCtrl (17000+2004);

_TaskList ctrlShow false;
[_description,_components] apply {_x ctrlShow true};

_shownCtrls = [_components,_curLine,1] call BCE_fnc_Show_CurTaskCtrls;

_TaskListPOS = ctrlPosition (_components controlsGroupCtrl (17000+2011));
_titlePOS = [0, _TaskListPOS # 1, 0, (_TaskListPOS # 3) * 0.01];

_desc = switch (_curType) do {
	case 1: {
		["","STR_BCE_DECS_IPBP","","","STR_BCE_DECS_ELEV","STR_BCE_DECS_DESC","STR_BCE_DECS_GRID","STR_BCE_DECS_MARK","STR_BCE_DECS_FRND","STR_BCE_DECS_EGRS"]
	};
	default {
		["","STR_BCE_DECS_IPBP","","","STR_BCE_DECS_ELEV","STR_BCE_DECS_DESC","STR_BCE_DECS_GRID","STR_BCE_DECS_MARK","STR_BCE_DECS_FRND","STR_BCE_DECS_EGRS"]
	};
};

//-Formatting
call ([BCE_fnc_DblClick9line, BCE_fnc_DblClick5line] # _curType);

_description ctrlCommit 0;

_desc = format ["%1<br/>%2", localize "STR_BCE_Description", (localize (_desc # _curLine)) call BCE_fnc_formatLanguage];
_description ctrlSetStructuredText parseText _desc;