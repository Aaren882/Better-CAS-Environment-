params ["_option"];
private _displayName = cTabIfOpen # 1;
private _setting = [_displayName, _option] call cTab_fnc_getSettings;
[_displayName,[[_option,_setting]],true,true] call cTab_fnc_setSettings;