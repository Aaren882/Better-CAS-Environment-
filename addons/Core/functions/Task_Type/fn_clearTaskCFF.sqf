params ["_clearPool"];

switch _curLine do {
		default {
			_clearPool pushBack [_curLine, _default # _curLine];
			private _displayEdit = "New_Task_IPExpression" call BCE_fnc_getTaskSingleComponent;
			_displayEdit ctrlSetText "NA";
		};
	};
