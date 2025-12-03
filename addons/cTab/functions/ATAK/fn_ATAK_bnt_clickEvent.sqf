/*
  NAME : BCE_fnc_ATAK_bnt_clickEvent
*/
params ["_control"];

private _function = _control getVariable ["clickEvent",""];
if (_function == "") exitWith {};

private _MenuGroup = (call BCE_fnc_ATAK_getCurrentAPP) # 1;
private _settings = ["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings;

//- #NOTE - Pass "showMenu" settings into button function
[_control,_MenuGroup,_settings] call {
  privateAll;
  import ["_function"];
  _this call (missionNamespace getVariable [_function,{}]);
};
