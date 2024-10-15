if ((ctrlShown _description) or (_Veh_Changed) or (_isOverwrite)) then {
	switch _curLine do {
		case 1:{
			_shownCtrls params ["_ctrl1","_ctrl2","_ctrl3","_ctrl4"];
			_taskVar set [1,["NA","",[],[0,0],""]];
			_ctrl3 ctrlSetText "NA";
			_ctrl4 ctrlSetText localize "STR_BCE_MarkWith";
		};
		//-DESC
		case 3:{
			_shownCtrls params ["_ctrl1","_ctrl2"];
			_ctrl1 ctrlSetText "";
			_ctrl2 ctrlSetText localize "STR_BCE_MarkWith";
			_taskVar set [3,["NA","--",""]];
		};
		default {
			_shownCtrls apply {
				if (ctrlIDC _x == (_IDC_offset + 2014)) then {
					_x ctrlSetText "NA";
					break;
				};
			};
			_taskVar set [_curLine, _default # _curLine];
		};
	};
	uiNamespace setVariable ["BCE_CAS_5Line_Var", _taskVar];
} else {
	uiNamespace setVariable ["BCE_CAS_5Line_Var", [["NA",0],["NA","",[],[0,0],""],["NA","111222"],["NA","--",""],["NA",-1,[]]]];
};
