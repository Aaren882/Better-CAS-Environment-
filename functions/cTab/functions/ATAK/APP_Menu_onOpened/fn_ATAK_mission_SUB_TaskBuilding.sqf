//- call BCE_fnc_ATAK_mission_SUB_TaskBuilding;
params ["_group",["_interfaceInit",false],"_isDialog","_settings"];

privateAll;

(["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings) params ["","_shown","_subInfos"];
_subInfos params ["_subMenu","_curLine"];

if !(_shown) exitwith {};

_curType = ["Type",0] call BCE_fnc_get_TaskCurSetup;
_taskVar = (["9Line","5Line"] # _curType) call BCE_fnc_getTaskVar;

if (isnil {_taskVar}) exitWith {
	["Error ""_taskVar"" Variable is empty"] call BIS_fnc_error;
};

// _TaskList = _display displayCtrl (17000+4661);
// _group = _display displayCtrl (17000+4662);
// _group = (call BCE_fnc_ATAK_getCurrentAPP) # 1; //- current Control
_description = _group controlsGroupCtrl (17000+2004);

// _TaskList ctrlShow false;
{_x ctrlShow true} count [_group,_description];
_group ctrlSetFade 0;
_group ctrlCommit 0.3;

_TaskListPOS = ctrlPosition (_group controlsGroupCtrl (17000+2011));
_titlePOS = [0, _TaskListPOS # 1, 0, (_TaskListPOS # 3) * 0.01];

_desc = switch (_curType) do {
	case 0: {
		["","IPBP","","","ELEV","DESC","GRID","MARK","FRND","EGRS","Remarks"]
	};
	case 1: {
		["","FRNDMark","TGT","","Remarks"]
	};
	default {
		nil
	};
};

if (isNil{_desc}) exitWith {
	["Error no Task Found."] call BIS_fnc_error;
};

_curLine = [_curLine, (count _taskVar)-1] select (_curLine > count _taskVar);
_shownCtrls = [_group,_curLine,1,true] call BCE_fnc_Show_CurTaskCtrls;
private _fnc = ["BCE_fnc_DblClick9line", "BCE_fnc_DblClick5line"] # _curType;

//-Formatting
call (uiNamespace getVariable _fnc);

_description ctrlCommit 0;
_description ctrlSetStructuredText parseText ([
	localize "STR_BCE_Description",
	localize ("STR_BCE_DECS_" + (_desc # _curLine))
] joinString "<br/>");