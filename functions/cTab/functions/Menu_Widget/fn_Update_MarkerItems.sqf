params ["_ctrl","_selectedIndex",["_preload",false]];

_display = ctrlParent _ctrl;
_class = switch _selectedIndex do {
  case 0: {
    "OPFOR"
  };
  case 1: {
    "BLUFOR"
  };
  case 2: {
    "CIV"
  };
  case 3: {
    "Generic"
  };
};

//- Update Varible for cTab
  _displayName = cTabIfOpen # 1;
  _toggle = [_displayName,"MarkerWidget"] call cTab_fnc_getSettings;
  _toggle set [1, _selectedIndex];
  [_displayName,[["MarkerWidget",_toggle]]] call cTab_fnc_setSettings;

_dropBox = (_display displayCtrl (17000 + 1300)) controlsGroupCtrl 10;
lbClear _dropBox;

{
  private ["_name","_icon","_color","_index"];
  _name = getText (_x >> "name");
  _icon = getText (_x >> "icon");
  _color = (getArray (_x >> "color")) apply {
    if (_x isEqualType "") then {
      call compile _x
    } else {
      _x
    };
  };

  if (_color isEqualTo [0,0,0,0]) then {
    private _colorLb = _display displayCtrl (17000 + 1090);
    _color = (call compile (_colorLb lbData lbCurSel _colorLb)) # 1;
  };

  _index = _dropBox lbAdd _name;
  _dropBox lbSetPicture [_index, _icon];
  _dropBox lbSetPictureColor [_index, _color];
  _dropBox lbSetPictureColorSelected [_index, _color];
} forEach ("true" configClasses (configFile >> "cTab_CfgMarkers" >> _class));

//- Update Drop Box Selection
_selectedIndex = ([cTabIfOpen # 1,"MarkerWidget"] call cTab_fnc_getSettings) # 2;
_dropBox lbSetCurSel ([_selectedIndex, (lbSize _dropBox) - 1] select (lbSize _dropBox < (_selectedIndex + 1)));