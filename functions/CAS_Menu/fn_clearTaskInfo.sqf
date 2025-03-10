params ["_control",["_Veh_Changed",false],["_config","RscDisplayAVTerminal"],["_IDC_offset",0],["_overwrite",-1]];

_display = ctrlparent _control;
_isAVT = _IDC_offset == 0;

//-get Which interface should be applied
_curInterface = switch _IDC_offset do {
	case 17000: {1};
	default {0};
};

_clearAction = {
	_description = _display displayctrl (_IDC_offset + 2004);
	_Task_Type = _display displayCtrl (_IDC_offset + 2107);

	_curType = ["Type",0] call BCE_fnc_get_TaskCurSetup;

	_list_result = switch _curType do {
		//-5 line
		case 1: {
			_TaskList = _display displayCtrl (_IDC_offset + 2005);
			_name = "BCE_CAS_5Line_Var";
			_default = [["NA",0],["NA","",[],[0,0],""],["NA","111222"],["NA","--",""],["NA",-1,[]]];
			_taskVar = uiNamespace getVariable [_name, _default];

			[_TaskList,_taskVar,_default,_name]
		};
		//-9 line
		default {
			_TaskList = _display displayCtrl (_IDC_offset + 2002);
			_name = "BCE_CAS_9Line_Var";
			_default = [["NA",0],["NA","",[],[0,0]],["NA",180],["NA",200],["NA",15],["NA","--"],["NA","",[],[0,0],[]],["NA","1111"],["NA","",[],[0,0],""],["NA",0,[],nil,nil],["NA",-1,[]]];
			_taskVar = uiNamespace getVariable [_name, _default];
			[_TaskList,_taskVar,_default,_name]
		};
	};
	_list_result params ["_TaskList","_taskVar","_default","_TaskVarName"];

	_isOverwrite = _overwrite > -1;
	_curLine = if (_isOverwrite) then {
		_overwrite
	} else {
		[lbCurSel _taskList,0] select _Veh_Changed;
	};


	//-check current Controls
	([_display,_curLine,_curInterface,false,true,true] call BCE_fnc_Show_CurTaskCtrls) params ["_shownCtrls","_TextR"];

	private _fnc = ["BCE_fnc_clearTask5line", "BCE_fnc_clearTask9line"] # _curType;
	call (uiNamespace getVariable _fnc);

	//-Set Clear button color (except AV Terminal)
	if (_IDC_offset != 0) then {
		(_display displayCtrl (_IDC_offset + 2106)) ctrlSetBackgroundColor ([[1,0,0,0.5],[0,0,0,0.8]] select ((_taskVar # _curLine # 0) == "NA"));
	};

	//-Task Status
	{
		if ((_x # 0) != "NA") then {
			private _writeDown = (_TextR # _forEachIndex) param [1,""];

			_TaskList lbSetTextRight [_forEachIndex, [_x # 0, _writeDown] select (_writeDown != "")];
			if (_isAVT) then {
				_TaskList lbSetPictureRight [_forEachIndex,"\a3\ui_f\data\Map\Diary\Icons\diaryAssignTask_ca.paa"];
			};
			_TaskList lbSetPictureRightColor [_forEachIndex, [0, 1, 0, 1]];
			_TaskList lbSetPictureRightColorSelected [_forEachIndex, [0, 1, 0, 1]];
		} else {

			if (_isAVT) then {
				_TaskList lbSetPictureRight [_forEachIndex,"\a3\ui_f\data\IGUI\Cfg\Targeting\Empty_ca.paa"];
			};
			_TaskList lbSetPictureRightColor [_forEachIndex, [0, 0, 0, 0]];
			_TaskList lbSetPictureRightColorSelected [_forEachIndex, [0, 0, 0, 0]];
			_TaskList lbSetTextRight [_forEachIndex, _TextR # _forEachIndex # 0];
		};
	} forEach (uiNamespace getVariable _TaskVarName);
};

_MenuChanged = {
	private ["_curStateText","_desc","_code_list","_page","_lastPage","_text_list","_text"];
	_curStateText = ctrlText _control;
	_desc = _display displayCtrl 2004;
	_code_list = getArray (configFile >> _config >> "Brevity_Code");
	_page = false;

	_lastPage = _curStateText == "<";

	if (_lastPage) then {
		reverse _code_list;
	};

	//filter out next page
	_text_list = _code_list apply {
		if (_x isEqualTo "-") then {
			_page = true;
		};
		[nil,_x] select _page;
	} select {!((isnil {_x}) or (_x isEqualTo "-"))};

	if (_lastPage) then {
		reverse _text_list;
		_control ctrlSetText ">";
	} else {
		_control ctrlSetText "<";
	};

	_text = _text_list apply {
		_x params [["_title",""],["_sub",""]];
		[
			format ["<t size='1.1' align='center' font='PuristaSemibold'>%1</t>",_title],
			format ["<t size='1.1' font='RobotoCondensedBold_BCE'>%1</t> : <t size='1.1' color='#FFD9D9D9'>%2</t>",_title,_sub]
		] select (_x isEqualType []);
	};
	_desc ctrlSetStructuredText parseText (_text joinString "<br/>");
};

_ismenu = lbCurSel (_display displayCtrl 2102) == 1;

call ([_clearAction,_MenuChanged] select _ismenu);
