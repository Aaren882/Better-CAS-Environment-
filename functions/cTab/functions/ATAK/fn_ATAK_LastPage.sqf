//-Check what last page is
private _setting = ["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings;
_setting params ["_page","","_subInfos"];
_subInfos params ["_subMenu","_curLine"];
private _return = switch _subMenu do {
	case "Task_Building": {
		_subMenu = "";
		_curline = -1;
		"mission"
	};
	case "Task_Result": {
		_subMenu = "";
		_curline = -1;
		"mission"
	};
	default {
		_curline = -1;
		"main"
	};
};
_setting set [0,_return];

//- SubMenu Infos
	_subInfos set [0,_subMenu];
	_subInfos set [1,_curline];

_setting set [2,_subInfos];
["cTab_Android_dlg",[["showMenu",_setting]],true,true] call cTab_fnc_setSettings;