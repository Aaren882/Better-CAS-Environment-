params ["_display"];

(["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings) params ["_page","_show"];
(call BCE_fnc_ATAK_getCurrentAPP) params ["_APP_page","_APP_Ctrl"];

if (!_show || _APP_page != _page) exitWith {};

private _ctrl = switch _page do {
	case "mission": {
		_APP_Ctrl
	};
	case "message": {
		_APP_Ctrl controlsGroupCtrl 10;
	};
	case "mission_Build": {controlNull};
	default {
		_APP_Ctrl
	};
};

if !(isnull _ctrl) then {
	uiNamespace setVariable ["BCE_ATAK_Scroll_Value",(ctrlScrollValues _ctrl) # 0];
};