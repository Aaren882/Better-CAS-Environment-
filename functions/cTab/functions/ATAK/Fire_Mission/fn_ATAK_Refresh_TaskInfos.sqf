/*
	NAME : BCE_fnc_ATAK_Refresh_TaskInfos
*/
privateAll;

private _group = (call BCE_fnc_ATAK_getCurrentAPP) # 1;
private _MissionCtrl = _group getVariable "Mission_Control";

private _curType = ["Type",0] call BCE_fnc_get_TaskCurSetup;
private _taskVar = ((["9Line","5Line"] # _curType) call BCE_fnc_getTaskVar) # 0;

//- If "_curLine" isn't selected 
	// _components = _display displayCtrl (17000+4662);

	private _List = [
		[[2025,1],[2026,4],[2029,6],[2030,7],[2031,8],[2032,9],[3002,-1]],
		[[2041,1],[2042,2],[3002,-1]]
	] # _curType;

//-Appling Infos to each line
	{
		_x params ["_idc","_index"];
		private _title = _MissionCtrl controlsGroupCtrl ([17000 + _idc, _idc] select (_index < 0));
		_title ctrlSetStructuredText parseText (_taskVar # _index # 0);
	} foreach _List;

//- Set DESC Infos -// "Game Plan" or so
		(["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings) params ["","","_subInfos"];
		_subInfos params ["_subMenu","_curLine"];

	if (_curLine > count _taskVar) then {
		_curLine = (count _taskVar) - 1;
	};

	//- Task Building (Values)
	_MissionCtrlPOS = ctrlPosition (_group controlsGroupCtrl (17000 + 2011));
	_titlePOS = [0, _MissionCtrlPOS # 1, 0, (_MissionCtrlPOS # 3) * 0.01];
	_description = _group controlsGroupCtrl (17000 + 2004);

//- Get description DropList Selection
	private _ctrlDESC = _MissionCtrl controlsGroupCtrl (17000 + 2027);
	private _DESC_Type = ["Desc",0] call BCE_fnc_get_TaskCurSetup;
	_ctrlDESC lbSetCurSel _DESC_Type;

	private _fnc = ["BCE_fnc_DblClick9line", "BCE_fnc_DblClick5line"] # _curType;
	{
		if (_forEachIndex == 1) then {
			_curLine = [5,3] # _curType;
		};

		//- if on Task Builder Menu
		if (_curLine < 0) then {_curLine = 0};
		
		private _shownCtrls = [_x,_curLine,1,false,true] call BCE_fnc_Show_CurTaskCtrls;
		call (uiNamespace getVariable _fnc);
	} foreach [_group,_MissionCtrl];