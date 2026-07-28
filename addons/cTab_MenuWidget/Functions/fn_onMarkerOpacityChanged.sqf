params ["_control", "_newValue"];

_display = ctrlParent _control;

_displayName = cTabIfOpen # 1;
_toggle = [_displayName,"MarkerWidget"] call cTab_fnc_getSettings;
_toggle set [6, _newValue];
[_displayName,[["MarkerWidget",_toggle]],false,true] call cTab_fnc_setSettings;

_group = _display displayCtrl (17000 + 1300);
_title = _group controlsGroupCtrl 22;

_title ctrlSetText format [localize "STR_BCE_OPACITY_FORMAT",_newValue,"%"];
