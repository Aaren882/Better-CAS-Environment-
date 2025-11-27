params ["_control",["_IDC_offset",0],["_updateList",false],["_overwrite",-1]];

private _display = ctrlParent _control;
private _button_text = ctrlText _control;
private _NotAVT = _IDC_offset != 0;

//- Get Air Task Infos
	private _curType = [0] call BCE_fnc_get_TaskCurType;
	private _typeIndex = "AIR" call BCE_fnc_get_TaskCateIndex;
	private _vehicle = [nil, _typeIndex] call BCE_fnc_get_TaskCurUnit;

private _TaskList = switch _curType do {
	//-5 line
	case 1: {
		_display displayCtrl (_IDC_offset + 2005);
	};
	//-9 line
	default {
		_display displayCtrl (_IDC_offset + 2002);
	};
};

private _isOverwrite = _overwrite > -1;
private _curLine = [lbCurSel _taskList,_overwrite] select _isOverwrite;

//-Send Data
	if ((tolower _button_text) == localize "STR_BCE_SendData") exitWith {
		[_vehicle,_typeIndex] call BCE_fnc_SendTaskData;

		if !(_NotAVT) then {
			_control ctrlSetText localize "STR_BCE_Abort_Task";
		};

		//-Abort button
		(_display displayCtrl (_IDC_offset + 21050)) ctrlEnable ((_vehicle getVariable ["BCE_Task_Receiver",""]) != "");
	};

//-Abort Mission
	if ((localize "STR_BCE_Abort_Task") in (tolower _button_text)) exitWith {
		_vehicle setVariable ["BCE_Task_Receiver", "", true];
		_vehicle setVariable ["Module_CAS_Sound",false,true];

		//-Clear Waypoints
		_grp = group _vehicle;
		for "_i" from count waypoints _grp to 0 step -1 do {
			deleteWaypoint [_grp, _i];
		};
		_grp addWaypoint [getpos _vehicle, 0];

		//-Abort button
		switch _IDC_offset do {
			case 0: {
				_control ctrlSetText localize "STR_BCE_SendData";
			};
			case 17000: {
				(_display displayCtrl (_IDC_offset + 21050)) ctrlEnable false;
			};
		};
	};

//-Task Expressions
// ([_curLine, _varName] call BCE_fnc_getTaskComponents) params ["_shownCtrls","_desc_Sel"];

private _condition = [[],[0]] select (isNull _vehicle);
if !(_curLine in _condition) then {
	//- Enter info
  ["BCE_TaskBuilding_Enter", [_curLine,_isOverwrite]] call CBA_fnc_localEvent;
};

//-Task Expressions
	([_display,_curLine,[0,1] select _NotAVT,false,true,true] call BCE_fnc_Show_CurTaskCtrls) params ["_shownCtrls","_TextR"];
	private _taskVar = (_typeIndex call BCE_fnc_getTaskVar) # 0;
	private _curTask = _taskVar # _curLine # 0;

//-Update List
	if (_updateList) then {
		private _writeDown = (_TextR # _curLine) param [1,""];
		_TaskList lbSetTextRight [_curLine, [_curTask, _writeDown] select (_writeDown != "")];
	};

//-Set Clear button color (except AV Terminal)
if (_NotAVT) then {
	//-cTab
	if (_IDC_offset == 17000) then {
		private _msg = switch true do {
			case (_curLine in _condition): {
				"STR_BCE_Error_InputVal"
			};
			case (_curTask == "NA" && _isOverwrite): {
				"STR_BCE_Error_Vehicle"
			};
			default {""};
		};

		//- Send cTab Notification
		if (_msg != "") then {
			["Task_Builder",localize _msg,5] call cTab_fnc_addNotification;
		};
	};
};
//- Set button Color
	(_display displayCtrl (_IDC_offset + 2106)) ctrlSetBackgroundColor ([[1,0,0,0.5],[0,0,0,0.8]] select (_curTask == "NA"));
