//-Check what last page is
private _setting = ["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings;
_setting params ["_page","","_subInfos"];
_subInfos params ["_subMenu","_curLine"];

private _toMenu = _subMenu call BCE_fnc_ATAK_getLastAPP;
private _toSubPage = 0 > (([_toMenu] call BCE_fnc_ATAK_getAPPs_props) findIf {true});

//- If no subPage
if (_subMenu == "") then {
	_setting set [0,"main"]; //- "main" doesn't exist in APP_Props
} else {
	//- SubMenu Infos
		_subInfos set [0, ["",_toMenu] select _toSubPage]; //- "_subMenu"
};
/* private _return = switch _subMenu do {
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
}; */

_subInfos set [1, -1]; //- "_curline"

_setting set [2,_subInfos];
["cTab_Android_dlg",[["showMenu",_setting]],true,true] call cTab_fnc_setSettings;