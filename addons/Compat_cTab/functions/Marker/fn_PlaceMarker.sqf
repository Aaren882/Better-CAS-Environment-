#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cTab_fnc_PlaceMarker
Description:
  This function is used to place a marker on the map.

Parameters:
  _position -  Position of the marker will be placed <ARRAY>
  _toggle -  "MarkerWidget" <cTab_fnc_getSettings>

Returns:
  Return <NONE>

Examples:
  [[0,0,0], ["_toggle", [cTabIfOpen # 1,"MarkerWidget"] call cTab_fnc_getSettings] call cTab_fnc_PlaceMarker;

Author:
  Aaren
---------------------------------------------------------------------------- */

private _displayName = cTabIfOpen # 1;
params ["_position", ["_toggle", [_displayName,"MarkerWidget"] call cTab_fnc_getSettings]];

_toggle params ["_show","_curSel","_BoxSel","_texts","_widgetMode"];

//////////////// #TODO : Clean up /////////////////////////

TRACE_1("fn_PlaceMarker",_this);

private [
  "_id",
  "_group","_dropBox",
  "_MarkerColorArr","_class","_color",
  "_name","_markerData","_marker"
];

//- Marker ID
  _id = [] call cTab_fnc_NextMarkerID;

//- From Marker placer
_group = _display displayCtrl (17000 + 1300);
_dropBox = _group controlsGroupCtrl 10;

_MarkerColorArr = uiNamespace getVariable ["BCE_Marker_Color_Array", []];
_class = ("true" configClasses (configFile >> "cTab_CfgMarkers")) # _curSel;
_color = getText (_class >> "MarkerColor");

//- For generic Markers
private _colorSel = if (_color == "") then {
  private _colorSel = [_displayName,"markerColor"] call cTab_fnc_getSettings;
  _color = _MarkerColorArr # _colorSel;
  _colorSel
} else {
  _MarkerColorArr findIf {_x == _color}
};

//- MARKER #<PlayerID>/<MarkerID>/#<SEPARATOR>#/<Hide Direction> .. /<ChannelID> must Be last
_name = format [BCE_cTab_Marker_Sync + "_DEFINED #%1/%2/-1/%3/0/%4", clientOwner, _id, getNumber (_class >> "Hide_Direction"),currentChannel];
_markerData = [_dropBox lbData (_BoxSel # 0),"ICON","[1,1]",0,"Solid",_color,1];

_markerData params [
  "_markerType",
  "_markerShape",
  "_markerSize",
  "_markerDir",
  "_markerBrush",
  "_markerColor",
  "_markerAlpha"
];

_markerSize = parseSimpleArray _markerSize;
_marker = createMarker [_name, _position, currentChannel, player];

_marker setMarkerType _markerType;
_marker setMarkerShape _markerShape;
_marker setMarkerSize _markerSize;
_marker setMarkerDir _markerDir;
_marker setMarkerBrush _markerBrush;
_marker setMarkerColor _markerColor;
_marker setMarkerAlpha _markerAlpha;
_marker setMarkerDrawPriority 0;
_marker setMarkerShadow (0 < getNumber (configFile >> "CfgMarkers" >> _markerType >> "shadow"));

_texts params [["_prefix",""],["_index",""],["_DESC",""]];

_marker setMarkerText ([
  _prefix + (["-",""] select (_index == "")),
  _index,
  [" || " + _DESC, _DESC] select (_DESC == "" || (_prefix == "" && _index == ""))
] joinString "");

_position resize 2;
[_position,_curSel,_BoxSel # 0,_id,_colorSel] call cTab_fnc_Add_to_MarkerList;
//- update "Index" value
  if (_index != "") then {
    private _id= (toArray _index) # 0;
    
    _id = switch true do {
      //- Between 65 - 90 (A-Z)
      case (_id > 64 && _id <= 91) : {
        call {
          if (_id >= 90) exitwith {65};
          _id + 1
        };
      };

      //- Between 48 - 57 (0-9)
      case (_id > 47 &&_id <= 58) : {
        call {
          if (_id >= 57) exitwith {48};
          _id + 1
        };
      };

      default {_id};
    };

    //- Update "Index" EditBox
    [_group controlsGroupCtrl 16, toString [_id]] call cTab_fnc_onMarkerTextEditted;
  };
