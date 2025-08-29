params ["_group",["_interfaceInit",false],"_isDialog","_settings"];

private _groupClass = ctrlClassName _group;
private _listGroup = _group controlsGroupCtrl 10;
private _Category = _group controlsGroupCtrl (17000 + 2102);

//- Check Category Selection
private _PgComponents = _settings param [3, createHashMap];
(_PgComponents getOrDefault [_groupClass, []]) params [["_cateSel",0]];

if (_Category getVariable ["LBChanged_EH",-1] < 0) then {
  _Category lbSetCurSel _cateSel; //- Set Current Category Selection

  //- Set Event Handler for Category Selection
  _Category setVariable ["LBChanged_EH", _Category ctrlAddEventHandler [
    "ToolBoxSelChanged", {
      params ["_ctrl","_lbCurSel"];
    
      //- Update Category Selection
      [nil,"Task_CFF_List",_lbCurSel,true] call BCE_fnc_ATAK_ChangeTool; 
    }]
  ];
};

private _taskUnit = [nil,"GND" call BCE_fnc_get_TaskCateIndex] call BCE_fnc_get_TaskCurUnit;
private _grp = group _taskUnit;

//- #TODO - Async missions
//  : #LINK - functions/CAS_Menu/Call_for_Fire/fn_CFF_Mission_Set_Values.sqf
	/* [
		"RequestTasks",
		[_grp, call CBA_fnc_currentUnit],
		_taskUnit
	] call BCE_fnc_Send_MSN_CFF; */

//- get custom Groups
	[{
		params ["_grp","_cateSel","_listGroup","_isDialog"];
		private _CFF_Missions = (
			[
				_grp getVariable ["BCE_CFF_Task_Pool",createHashMap],
				localNamespace getVariable ["#BCE_CFF_Task_RAT_Pool",createHashMap]
			] # _cateSel
					
			/* createHashMapFromArray [
				["AB0001",["Adjust Fire","11112222", player, 5]],
				["AB0002",["Suppress","33334456", player,5,3]]
			] */
		) toArray false;
		// reverse _CFF_Missions;

		//- Create DropMenu 
			[
				["ATAK_CFF_STD","ATAK_CFF_RAT"] # _cateSel,
				_listGroup,
				_isDialog,
				_CFF_Missions
			] call BCE_fnc_Create_ATAK_Custom_DropMenu;

	}, [_grp,_cateSel,_listGroup,_isDialog]] call CBA_fnc_execNextFrame;