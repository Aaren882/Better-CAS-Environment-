private ["_curType","_taskVar","_List"];

_TaskList = _display displayCtrl (17000+4661);
_curType = uiNameSpace getVariable ["BCE_Current_TaskType",0];
_taskVar = uiNameSpace getVariable (["BCE_CAS_9Line_Var","BCE_CAS_5Line_Var"] # _curType);

_List = [
	[[2025,1],[2026,4],[2029,6],[2030,7],[2031,8],[2032,9],[3002,-1]],
	[[2041,2],[2042,3],[3002,-1]]
] # _curType;

//-Appling Infos
{
	_x params ["_idc","_index","_expt"];
	_title = _TaskList controlsGroupCtrl ([17000 + _title, _title] select (_curLine > count _taskVar));
	_title ctrlSetStructuredText parseText (_taskVar # _index # 0);
} foreach _List;