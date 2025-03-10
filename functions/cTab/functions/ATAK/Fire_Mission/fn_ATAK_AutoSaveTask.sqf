[{
	params ["_control","_input",["_type",-1]];
	private ["_TaskList","_curType","_text","_curLine","_shownCtrls"];
	
	_TaskList = ctrlParentControlsGroup _control;
	if !(ctrlshown _TaskList) exitWith {};

	_curType = ["Type",0] call BCE_fnc_get_TaskCurSetup;
	_taskVar = uiNameSpace getVariable (["BCE_CAS_9Line_Var","BCE_CAS_5Line_Var"] # _curType);

	_isOverwrite = false;
	_text = nil;
	if (_type == 0) then {
		_text = _input;
	};
	//-5 line "Mark With"
	if (_type == 1) then {
		_text = nil;
		_type = 0;
	};

	_curLine = switch _type do {
		//-Save DESC
		case 0: {
			([5,3] # _curType)
		};
		//-Save Game Plan
		default {
			0
		};
	};
	
	_shownCtrls = [_TaskList,_curLine,1,false,true] call BCE_fnc_Show_CurTaskCtrls;
	
	private _fnc = ["BCE_fnc_DataReceive9line", "BCE_fnc_DataReceive5line"] # _curType;
	call (uiNamespace getVariable _fnc);
	}, _this
] call CBA_fnc_execNextFrame;