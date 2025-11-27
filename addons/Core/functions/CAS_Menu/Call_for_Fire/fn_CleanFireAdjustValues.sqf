/*
  NAME : BCE_fnc_CleanFireAdjustValues

  Return : [0,0]
*/
params ["_control"];

//- Make sure Fire Adjust values back to default
	private _AdjustToolbox = "New_Task_Adjust_Method_CFF" call BCE_fnc_getTaskSingleComponent;
	private _default = ([_AdjustToolbox,"Default",[]] call BCE_fnc_get_Control_Data) # (lbCurSel _AdjustToolbox);

	private _current = ["CURRENT", ""] call BCE_fnc_get_FireAdjustValues;
	private _curValue = [_current] call BCE_fnc_get_FireAdjustValues;
	
//- Save the value
	private _result = switch (_current) do {
		case "IMPACT": {
			private _group = ctrlParentControlsGroup _control;
			private _edit_DIR = _group controlsGroupCtrl 150;
			private _edit_DIST = _group controlsGroupCtrl 160;

			_edit_DIR ctrlSetText (_default # 0);
			_edit_DIST ctrlSetText (_default # 1);

			_default
		};
		default {
			_curValue set [0, _default # 0];
			[_current, _curValue] call BCE_fnc_set_FireAdjustValues;

			[0,0]
		};
	};

[_control, _result] call BCE_fnc_UpdateFireAdjust; //- with Vector Return
