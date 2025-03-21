[{
	params ["_control","_input",["_type",-1]];
	privateAll;

	_curType = []  call BCE_fnc_get_TaskCurType;
	_curCate = ["Cate"] call BCE_fnc_get_TaskCurSetup;

	//-5 line "Mark With"
	if (_type == 1) then {
		_type = 0;
	};

	_curLine = switch _type do {
		//-Save DESC
		case 0: {
			[[5,3],[3]] # _curCate # _curType; //- Get Description Line
		};
		//-Save Game Plan
		default {
			0
		};
	};

	//- Description Will update it self, base on the current value it has
		["BCE_TaskBuilding_Enter", [_curLine]] call CBA_fnc_localEvent;
	}, _this
] call CBA_fnc_execNextFrame;