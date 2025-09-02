params ["_clearPool"];

switch _curLine do {
	//-IP/BP
	case 1:{
		_shownCtrls params ["_ctrl1","_ctrl2","_ctrl3"];
		_clearPool pushBack [1,["NA","",[],[0,0]]];
		//-Erase 2~4 line
		_clearPool pushBack [2,["NA",180]];
		_clearPool pushBack [3,["NA",200]];
		_clearPool pushBack [4,["NA",15]];

		_ctrl3 ctrlSetText "NA";
	};

	//-DESC
	case 5:{
		_shownCtrls params ["_ctrl1"];
		_ctrl1 ctrlSetText "";
		_clearPool pushBack [5,["NA",[]]];
	};

	//-GRID
	case 6:{
		_shownCtrls params ["_ctrl1","_ctrl2","_ctrl3"];

		//-Erase 2~4 line
		_clearPool pushBack [2,["NA",180]];
		_clearPool pushBack [3,["NA",200]];
		_clearPool pushBack [4,["NA",15]];

		_clearPool pushBack [6,["NA","",[],[0,0],[]]];
		_ctrl3 ctrlSetText "NA";
	};

	//-MARK
	case 7:{
		_shownCtrls params ["_ctrl1"];
		_clearPool pushBack [7,["NA"]];
		_ctrl1 ctrlSetText localize "STR_BCE_MarkWith";
	};

	//-Friendlies
	case 8:{
		_shownCtrls params ["_ctrl1","_ctrl2","_ctrl3","_ctrl4"];
		_clearPool pushBack [8,["NA","",[],[0,0],""]];
		_ctrl3 ctrlSetText "NA";
		_ctrl4 ctrlSetText localize "STR_BCE_MarkWith";
	};

	//-EGRS [Toolbox, EditBox, output, Toolbox(Azimuth)]
	case 8:{
		_shownCtrls params ["_ctrl1","_ctrl2","_ctrl3","_ctrl4","_ctrl5"];
		_clearPool pushBack [9,["NA",0,[],nil,nil]];
		_ctrl2 ctrlSetText localize "STR_BCE_Bearing_ENT";
		_ctrl3 ctrlSetText "NA";
	};
	default {
		_clearPool pushBack [_curLine, _default # _curLine];
		private _displayEdit = "New_Task_IPExpression" call BCE_fnc_getTaskSingleComponent;
		_displayEdit ctrlSetText "NA";
	};
};