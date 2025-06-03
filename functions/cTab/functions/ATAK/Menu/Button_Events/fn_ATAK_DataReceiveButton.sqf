params ["_control","_MenuGroup","_settings"];
_ctrlBnts params ["_bnt_back","_bnt_Ent","_bnt_third","_bnt_result"];

//- Mission Builders
_settings params ["","","_subInfos"];
_subInfos params ["_subMenu","_curLine"];

private _display = ctrlParent _control;
private _ctrlTitle = ctrlText _control;


// private _bnt = (_display displayCtrl 46600) controlsGroupCtrl 11;
private _cateClass = [] call BCE_fnc_get_BCE_TaskCateClass; //- AIR, GND, OTH
private _vehicle = [] call BCE_fnc_get_TaskCurUnit;

//- Get task UI infos
  ([_display] call BCE_fnc_get_BCE_TaskUI) params ["_taskMenu","_displayName"];

//- Enter Infos (on Building Page)
	if (_subMenu == "Task_Building") exitWith {
		///-Enter Data
		["BCE_TaskBuilding_Enter", [_curLine]] call CBA_fnc_localEvent;
	};

///- Other Conditions
	//- Abort Mission
		if (_ctrlTitle == localize "STR_BCE_Abort_Task") exitWith {
			_vehicle setVariable ["BCE_Task_Receiver","", true];
			_vehicle setVariable ["Module_CAS_Sound",false,true];

			//-Clear Waypoints
			private _grp = group _vehicle;
			for "_i" from count waypoints _grp to 0 step -1 do {
				deleteWaypoint [_grp, _i];
			};
			_grp addWaypoint [getpos _vehicle, 0];
			
			_bnt_Ent ctrlSetText localize "STR_BCE_SendData";
			_bnt_Ent ctrlSetBackgroundColor ([
				(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77]),
				(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51]),
				(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08]),
				0.8
			]);
		};

	//- Send Data
		//- Check Vehicle Availability
			if (
				(isnull _vehicle) || 
				((_vehicle getVariable ["BCE_Task_Receiver",""])) != ""
			) exitWith {
				[
					"BFT",
					localize ("STR_BCE_Error_" + (["Unavailable","Vehicle"] select (isnull _vehicle))),
					5
				] call cTab_fnc_addNotification;
			};
		
		//- Finally Send
		if ([_vehicle] call BCE_fnc_SendTaskData && _cateClass == "AIR") then {
			_bnt_Ent ctrlSetText localize "STR_BCE_Abort_Task";
			_bnt_Ent ctrlSetBackgroundColor [1,0,0,0.5];
		};