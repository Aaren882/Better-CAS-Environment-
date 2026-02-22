#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cTab_fnc_Update_MarkerItems
Description:
		Description.

Parameters:
		_ctrl  					- Marker Toolbox UI control <CONTROL>
		_selectedIndex  - Selected Index <NUMBER>

Returns:
		<NONE>

Author:
		Aaren
---------------------------------------------------------------------------- */

private ["_display","_displayName","_toggle","_widgetMode","_dropBox","_MarkerColorCache"];

//-get Widget Vars
  _displayName = cTabIfOpen # 1;
  _toggle = [_displayName,"MarkerWidget"] call cTab_fnc_getSettings;
  _widgetMode = _toggle # 4;

params ["_ctrl","_selectedIndex"];
TRACE_1("fn_Update_MarkerItems",_this);

_display = ctrlParent _ctrl;
_group = _display displayCtrl (17000 + 1300);
_dropBox = _group controlsGroupCtrl 10;

lbClear _dropBox;

//- Arrange items
  switch _widgetMode do {
    //- Drawing Tools
    case 1: {
      private ["_Markers","_colorLb","_color","_cfg","_classes","_brushes"];
      _Markers = [
        ["STR_3den_attributes_shapetrigger_rectangle","a3\3den\data\cfg3den\marker\iconrectangle_ca.paa"],
        ["STR_3den_attributes_shapetrigger_ellipse","a3\3den\data\cfg3den\marker\iconEllipse_ca.paa"]
      ];

      _colorLb = _display displayCtrl (17000 + 1090);
      _color = (_colorLb lbData (lbCurSel _colorLb)) call BCE_fnc_getMarkerColor;
      _color set [3, 0.75];

      {
        _x params ["_name","_icon"];
        
        private _index = _dropBox lbAdd (localize _name);
        _dropBox lbSetPicture [_index, _icon];
        _dropBox lbSetPictureColor [_index, _color];
        _dropBox lbSetPictureColorSelected [_index, _color];
        
      } forEach _Markers;

      //- Get Brushes
      _cfg = configFile >> "CfgMarkerBrushes";
      _classes = ("true" configClasses _cfg) apply {configName _x};

      _brushes = _group controlsGroupCtrl 21;
      lbClear _brushes;
      
      {
        private ["_name","_icon","_index"];
        _name = getText (_cfg >> _x >> "name");
        _icon = getText (_cfg >> _x >> "texture");
        
        if (_icon == "" || "#" in _icon) then {
          _icon = "a3\3den\data\cfg3den\marker\iconrectangle_ca.paa";
        };
        
        _index = _brushes lbAdd _name;
        _brushes lbSetData [_index,_x];
        _brushes lbSetPicture [_index, _icon];
        _brushes lbSetPictureColor [_index, _color];
        _brushes lbSetPictureColorSelected [_index, _color];
        
        nil
      } count _classes;

      _brushes lbSetCurSel (_toggle # 5);
      (_group controlsGroupCtrl 22) ctrlSetText format [localize "STR_BCE_OPACITY_FORMAT",(_toggle # 6),"%"];
      (_group controlsGroupCtrl 23) sliderSetPosition (_toggle # 6);
    };

    //- Marker Dropper
    default {

      //- Update Varible for cTab
        _toggle set [1, _selectedIndex];
        [_displayName,[["MarkerWidget",_toggle]]] call cTab_fnc_setSettings;

      private _classes = ("true" configClasses (configFile >> "cTab_CfgMarkers")) apply {configName _x};
      private _class = (_classes # _selectedIndex) call BCE_fnc_getMarkerCategory;

      _class params ["_Markers", "_color"];

      {
				(_x call BCE_fnc_getMarkerItem) params ["_name","_icon"];

        if (_color findif {true} < 0) then {
          private _colorLb = _display displayCtrl (17000 + 1090);
					_color = (_colorLb lbData (lbCurSel _colorLb)) call BCE_fnc_getMarkerColor;
        };
				TRACE_4("Marker Dropper (Create List)",_x,_name,_icon,_color);

        private _index = _dropBox lbAdd _name;
        _dropBox lbSetData [_index, _x];
        _dropBox lbSetPicture [_index, _icon];
        _dropBox lbSetPictureColor [_index, _color];
        _dropBox lbSetPictureColorSelected [_index, _color];
      } forEach _Markers;
    };
  };

//- Update Drop Box Selection
_selectedIndex = _toggle # 2 # _widgetMode;
_dropBox lbSetCurSel ([_selectedIndex, (lbSize _dropBox) - 1] select (lbSize _dropBox < (_selectedIndex + 1)));
