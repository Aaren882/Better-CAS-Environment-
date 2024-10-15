params ["_display"];

(["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings) params ["_page","_show"];

if !(_show) exitWith {};

private _ctrl = switch _page do {
	case "mission": {
		_display displayCtrl (17000 + 4660)
	};
	case "message": {
		private _group = _display displayCtrl (17000 + 4650);
		_group controlsGroupCtrl 10;
	};
	case "mission_Build": {controlNull};
	default {
		_display displayCtrl (17000 + 4660)
	};
};

if !(isnull _ctrl) then {
	uiNamespace setVariable ["BCE_ATAK_Scroll_Value",(ctrlScrollValues _ctrl) # 0];
};