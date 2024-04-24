params ["_ctrl","_selectedIndex"];

_display = ctrlParent _ctrl;
_cfg = configFile >> "CfgMarkers";
_classes = ("true" configClasses (configFile >> "cTab_CfgMarkers")) apply {configName _x};
_class = (uiNamespace getVariable "BCE_Marker_Map") get (_classes # _selectedIndex);

//- Update Varible for cTab
  _displayName = cTabIfOpen # 1;
  _toggle = [_displayName,"MarkerWidget"] call cTab_fnc_getSettings;
  _toggle set [1, _selectedIndex];
  [_displayName,[["MarkerWidget",_toggle]]] call cTab_fnc_setSettings;

_dropBox = (_display displayCtrl (17000 + 1300)) controlsGroupCtrl 10;
lbClear _dropBox;

_class params ["_Markers", "_color"];

{
  private ["_name","_icon","_index"];
  _name = getText (_cfg >> _x >> "name");
  _icon = getText (_cfg >> _x >> "icon");

  if (_color findif {true} < 0) then {
    private _colorLb = _display displayCtrl (17000 + 1090);
    _color = (call compile (_colorLb lbData lbCurSel _colorLb)) # 1;
  };

  _index = _dropBox lbAdd _name;
  _dropBox lbSetData [_index, _x];
  _dropBox lbSetPicture [_index, _icon];
  _dropBox lbSetPictureColor [_index, _color];
  _dropBox lbSetPictureColorSelected [_index, _color];
} forEach _Markers;

//- Update Drop Box Selection
_selectedIndex = _toggle # 2;
_dropBox lbSetCurSel ([_selectedIndex, (lbSize _dropBox) - 1] select (lbSize _dropBox < (_selectedIndex + 1)));