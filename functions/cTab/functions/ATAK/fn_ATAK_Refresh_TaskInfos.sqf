private ["_curType","_taskVar","_List","_curLine","_fnc"];

_TaskList = _display displayCtrl (17000+4661);
_components = _display displayCtrl (17000+4662);

_curType = uiNameSpace getVariable ["BCE_Current_TaskType",0];
_taskVar = uiNameSpace getVariable (["BCE_CAS_9Line_Var","BCE_CAS_5Line_Var"] # _curType);

_List = [
	[[2025,1],[2026,4],[2029,6],[2030,7],[2031,8],[2032,9],[3002,-1]],
	[[2041,1],[2042,2],[3002,-1]]
] # _curType;

//-Appling Infos
{
	_x params ["_idc","_index"];
	private _title = _TaskList controlsGroupCtrl ([17000 + _idc, _idc] select (_index < 0));
	_title ctrlSetStructuredText parseText (_taskVar # _index # 0);
} foreach _List;

//-Set DESC Infos
(["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings) params ["","_shown","_curLine"];
if (_curLine > count _taskVar) then {
	_curLine = (count _taskVar) - 1;
};

_fnc = [BCE_fnc_DblClick9line, BCE_fnc_DblClick5line] # _curType;
{
	if (_forEachIndex == 1) then {
		_curLine = [5,3] # _curType;
	};
	if (_curLine < 0) then {continue};
	
	private _shownCtrls = [_x,_curLine,1,false,true] call BCE_fnc_Show_CurTaskCtrls;
	call _fnc;
} foreach [_components,_TaskList];