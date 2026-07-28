#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_cTab_ATAK_missions_fnc_ATAK_Refresh_TaskInfos
Description:
		Refreshes task information displayed in the cTab_ATAK_missions interface. It updates titles, backgrounds, and selection states for various task lines based on current mission data and settings.

Parameters:
		[] - No input parameters. Operates on mission control and current task variables.

Returns:
		<NONE>

Author:
		Aaren
---------------------------------------------------------------------------- */

TRACE_1("fnc_ATAK_Refresh_TaskInfos",_this);

private _group = (call BCE_fnc_ATAK_getCurrentAPP) # 1;
private _MissionCtrl = _group getVariable "Mission_Control";

private _curType = [] call BCE_fnc_get_TaskCurType;
private _curCate = ["Cate"] call BCE_fnc_get_TaskCurSetup;
private _taskVar = ([] call BCE_fnc_getTaskVar) # 0;

//- If "_curLine" isn't selected 
	private _List = [
		[
			[[2025,1],[2026,4,true],[2029,6,true],[2030,7],[2031,8,true],[2032,9],[3002,-1,true]],
			[[2041,1],[2042,2],[3002,-1,true]]
		],
		[
			[[2039,1],[2041,2],[3002,-1]],
			[[2039,1],[2041,2],[2042,3],[3002,-1]],
			[[2039,1],[2041,2]]
		]
	] # _curCate # _curType;
	
//- Apply Infos to each line
	{
		_x params ["_idc","_index",["_readBack",false]];
		private _title = _MissionCtrl controlsGroupCtrl ([17000 + _idc, _idc] select (_index < 0));
		//- #NOTE : https://community.bistudio.com/wiki/ctrlSetStructuredText
		private _text = "<t size='1'>"+ (_taskVar # _index # 0) + "</t>";
		_title ctrlSetStructuredText parseText _text;
		
		if (_readBack) then {
			_title ctrlSetBackgroundColor [0.19,0.61,0.34,0.65];
		};
	} foreach _List;

//- Get description DropList Selection
	private _ctrlDESC = "New_Task_TG_DESC_Combo" call BCE_fnc_getTaskSingleComponent;
	if !(isNull _ctrlDESC) then {
		private _DESC_Type = ["Desc",0] call BCE_fnc_get_TaskCurSetup;
		_ctrlDESC lbSetCurSel _DESC_Type;
	};
//- Display TaskVar values
	private _descLine = ([[5,3],[3]] # _curCate) param [_curType, -1]; //- Get Description Line
	{
		if (_x < 0) exitWith {};
		["BCE_TaskBuilding_Opened", [_x]] call CBA_fnc_localEvent;
	} count [0,_descLine];
