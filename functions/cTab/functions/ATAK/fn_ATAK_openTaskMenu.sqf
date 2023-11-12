params ["_control","_PageIndex"];
private ["_display","_components","_curType","_all_lists","_Tasklist","_shownCtrls","_description","_desc"];

_display = ctrlParent _control;
_components = _display displayCtrl (17000+4662);

_curType = uiNameSpace getVariable ["BCE_Current_TaskType",0];

_shownCtrls = [_display,_PageIndex,1] call BCE_fnc_Show_CurTaskCtrls;

switch _PageIndex do {
	case 0: {
		
	};
	default { };
};

_description = _components controlsGroupCtrl (17000+2004);
_desc = ["STR_BCE_DECS_IPBP","STR_BCE_DECS_ELEV","STR_BCE_DECS_DESC","STR_BCE_DECS_GRID","STR_BCE_DECS_MARK","STR_BCE_DECS_FRND","STR_BCE_DECS_EGRS"];
_desc = format ["%1<br/>%2", localize "STR_BCE_Description", (localize (_description # _PageIndex)) call BCE_fnc_formatLanguage];
_description ctrlSetStructuredText parseText _desc;