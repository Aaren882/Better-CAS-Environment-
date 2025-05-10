params ["_displayName",["_IDC",-1]];

private _display = uiNamespace getVariable _displayName;
private _ctrl = _display displayCtrl _IDC;

if (isNull _ctrl) exitWith {
  ["Invalid Control ""_ctrl = %1""",_ctrl] call BIS_fnc_error;
};
//- setVariable (Make this VAR "true" ,so it can update the interface)
  _ctrl setVariable ["Anim_Activation",true];

_toggle = [_displayName,"MarkerWidget"] call cTab_fnc_getSettings;

_toggle set [0, !(_toggle # 0)];
[_displayName,[["MarkerWidget",_toggle]],true,true] call cTab_fnc_setSettings;
_toggle