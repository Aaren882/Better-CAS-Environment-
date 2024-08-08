//-Check what last page is
private _setting = ["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings;
_setting params ["_page","","_curline"];
private _return = switch _page do {
	case "mission_Build": {
		_curline = -1;
		"mission"
	};
	case "Task_Result": {
		_curline = -1;
		"mission"
	};
	default {
		_curline = -1;
		"main"
	};
};
_setting set [0,_return];
_setting set [2,_curline];
["cTab_Android_dlg",[["showMenu",_setting]],true,true] call cTab_fnc_setSettings;