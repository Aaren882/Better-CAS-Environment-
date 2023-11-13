params ["_display"];
private ["_display","_TaskList","_components","_curType","_taskVar","_curLine","_all_lists","_Tasklist","_shownCtrls","_TaskListPOS","_titlePOS","_description","_desc"];

_curType = uiNameSpace getVariable ["BCE_Current_TaskType",0];
_taskVar = uiNameSpace getVariable (["BCE_CAS_9Line_Var","BCE_CAS_5Line_Var"] # _curType);
if (isnil {_taskVar}) exitWith {hintSilent "Error Variable is empty"};

_curLine = ([cTabIfOpen # 1, "showMenu"] call cTab_fnc_getSettings) # 2;

_TaskList = _display displayCtrl (17000+4661);
_components = _display displayCtrl (17000+4662);
_description = _components controlsGroupCtrl (17000+2004);

_TaskList ctrlShow false;
[_description,_components] apply {_X ctrlShow true};

_shownCtrls = [_display,_curLine,1] call BCE_fnc_Show_CurTaskCtrls;

_TaskListPOS = ctrlPosition _TaskList;
_titlePOS = [0, 0, 0, 0];

_desc = switch (_curType) do {
	case 1: {
		call BCE_fnc_DblClick5line;
		["","STR_BCE_DECS_IPBP","STR_BCE_DECS_ELEV","STR_BCE_DECS_DESC","STR_BCE_DECS_GRID","STR_BCE_DECS_MARK","STR_BCE_DECS_FRND","STR_BCE_DECS_EGRS"]
	};
	default {
		call BCE_fnc_DblClick9line;
		["","STR_BCE_DECS_IPBP","STR_BCE_DECS_ELEV","STR_BCE_DECS_DESC","STR_BCE_DECS_GRID","STR_BCE_DECS_MARK","STR_BCE_DECS_FRND","STR_BCE_DECS_EGRS"]
	};
};
_description ctrlCommit 0;

_desc = format ["%1<br/>%2", localize "STR_BCE_Description", (localize (_desc # _curLine)) call BCE_fnc_formatLanguage];
_description ctrlSetStructuredText parseText _desc;