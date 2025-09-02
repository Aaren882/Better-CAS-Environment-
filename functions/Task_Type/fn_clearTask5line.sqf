params ["_clearPool"];

switch _curLine do {
		case 1:{
			_shownCtrls params ["_ctrl1","_ctrl2","_ctrl3","_ctrl4"];
			_clearPool pushBack [1,["NA","",[],[0,0],""]];
			_ctrl3 ctrlSetText "NA";
			_ctrl4 ctrlSetText localize "STR_BCE_MarkWith";
		};
		//-DESC
		case 3:{
			_shownCtrls params ["_ctrl1","_ctrl2"];
			_clearPool pushBack [3,["NA","--",""]];
			_ctrl1 ctrlSetText "";
			_ctrl2 ctrlSetText localize "STR_BCE_MarkWith";
		};
		default {
			_clearPool pushBack [_curLine, _default # _curLine];
			private _displayEdit = "New_Task_IPExpression" call BCE_fnc_getTaskSingleComponent;
			_displayEdit ctrlSetText "NA";
		};
	};