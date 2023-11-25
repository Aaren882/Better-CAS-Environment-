//-Check what last page is
(["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings) params ["_page","","_curline"];

private _return = switch _page do {
	case "mission_Build": {
		_curline = -1;
		"mission"
	};
	default {
		_curline = -1;
		"main"
	};
};

["cTab_Android_dlg",[["showMenu",[_return,true,_curline]]]] call cTab_fnc_setSettings;