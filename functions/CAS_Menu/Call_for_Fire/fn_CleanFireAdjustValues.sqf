/*
  NAME : BCE_fnc_CleanFireAdjustValues

  Return : [0,0]
*/
params ["_control"];

//- Make sure Fire Adjust values back to default
	private _AdjustToolbox = "New_Task_Adjust_Method_CFF" call BCE_fnc_getTaskSingleComponent;
	private _default = [_AdjustToolbox,"Default",[]] call BCE_fnc_get_Control_Data;

	private _current = ["CURRENT", ""] call BCE_fnc_get_FireAdjustValues;
	private _curValue = [_current] call BCE_fnc_get_FireAdjustValues;
	
//- Save the value
	_curValue set [0, _default # (lbCurSel _AdjustToolbox) # 0];
	[_current, _curValue] call BCE_fnc_set_FireAdjustValues;

[_control, [0,0]] call BCE_fnc_UpdateFireAdjust; //- with Vector Return