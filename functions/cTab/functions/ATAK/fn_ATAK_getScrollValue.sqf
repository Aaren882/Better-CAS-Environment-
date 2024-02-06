params ["_display"];

(["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings) params ["_page","_show"];

if !(_show) exitWith {};

private _idc = switch _page do {
	case "mission": {4661};
	case "mission_Build": {nil};
	default {4660};
};

if (_show && !isnil{_idc}) then {
	private _ctrl = _display displayCtrl (17000 + _idc);
	uiNamespace setVariable ["BCE_ATAK_Scroll_Value",(ctrlScrollValues _ctrl) # 0];
};