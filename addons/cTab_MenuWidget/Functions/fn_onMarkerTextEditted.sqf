params ["_ctrl", "_newText"];

_displayName = cTabIfOpen # 1;
_toggle = [_displayName,"MarkerWidget"] call cTab_fnc_getSettings;
_text = _toggle # 3;

//- Begins from 15
_display = ctrlParent _ctrl;
_sel = (ctrlIDC _ctrl) - 15;

//- Make sure index can only have i value
if (_sel == 1) then {
  if (count _newText > 1) then {
    _newText = _newText select [1];
  };
  _newText = trim toUpperANSI _newText;
  _ctrl ctrlSetText _newText;
};

_text set [_sel,[_newText,""] select isNil{_newText}];

_text params [["_prefix",""],["_index",""]];

private _group = _display displayCtrl (17000 + 1300);
private _preview = _group controlsGroupCtrl 18;
_preview ctrlSetStructuredText parseText format [
  "<t shadow='2'>%1%2<t align='right'>||</t></t>",
  _prefix + (["-",""] select (_index == "")),
  _index
];

//- Update Varible
_toggle set [3, _text];
[_displayName,[["MarkerWidget",_toggle]],false,true] call cTab_fnc_setSettings;
