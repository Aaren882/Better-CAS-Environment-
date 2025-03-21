/*
	NAME : BCE_fnc_ATAK_Refresh_TaskInfos
*/
privateAll;

private _group = (call BCE_fnc_ATAK_getCurrentAPP) # 1;
private _MissionCtrl = _group getVariable "Mission_Control";

private _curType = [] call BCE_fnc_get_TaskCurType;
private _curCate = ["Cate"] call BCE_fnc_get_TaskCurSetup;
private _taskVar = ([] call BCE_fnc_getTaskVar) # 0;

//- If "_curLine" isn't selected 
	private _List = [
		[
			[[2025,1],[2026,4],[2029,6],[2030,7],[2031,8],[2032,9],[3002,-1]],
			[[2041,1],[2042,2],[3002,-1]]
		],
		[
			[[2041,1],[2042,2],[3002,-1]]
		]
	] # _curCate # _curType;

//-Appling Infos to each line
	{
		_x params ["_idc","_index"];
		private _title = _MissionCtrl controlsGroupCtrl ([17000 + _idc, _idc] select (_index < 0));
		_title ctrlSetStructuredText parseText (_taskVar # _index # 0);
	} foreach _List;

//- Get description DropList Selection
	// private _ctrlDESC = _MissionCtrl controlsGroupCtrl (17000 + 2027);
	private _ctrlDESC = "New_Task_TG_DESC_Combo" call BCE_fnc_getTaskSingleComponent;
	private _DESC_Type = ["Desc",0] call BCE_fnc_get_TaskCurSetup;
	_ctrlDESC lbSetCurSel _DESC_Type;

//- Set DESC Infos -// "Game Plan" or so -//
		/* (["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings) params ["","","_subInfos"];
		_subInfos params ["_subMenu","_curLine"];

	if (_curLine > count _taskVar) then {
		_curLine = (count _taskVar) - 1;
	}; */

	//- Display TaskVar values
	private _descLine = [[5,3],[3]] # _curCate # _curType; //- Get Description Line
	{
		["BCE_TaskBuilding_Opened", [_x]] call CBA_fnc_localEvent;
	} count [0,_descLine];