private ["_components","_List","_fnc"];

_components = _display displayCtrl (17000+4662);

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
(["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings) params ["","","_subInfos"];
_subInfos params ["_subMenu","_curLine"];

if (_curLine > count _taskVar) then {
	_curLine = (count _taskVar) - 1;
};

_TaskListPOS = ctrlPosition (_components controlsGroupCtrl (17000 + 2011));
_titlePOS = [0, _TaskListPOS # 1, 0, (_TaskListPOS # 3) * 0.01];
_description = _components controlsGroupCtrl (17000 + 2004);

_fnc = [BCE_fnc_DblClick9line, BCE_fnc_DblClick5line] # _curType;
{
	if (_forEachIndex == 1) then {
		_curLine = [5,3] # _curType;
	};
	if (_curLine < 0) then {_curLine = 0};
	
	private _shownCtrls = [_x,_curLine,1,false,true] call BCE_fnc_Show_CurTaskCtrls;
	call _fnc;
} foreach [_components,_TaskList];