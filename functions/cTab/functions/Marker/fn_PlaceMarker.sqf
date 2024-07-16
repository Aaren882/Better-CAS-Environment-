params ["_control", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];

private [
  "_display","_displayName","_markers","_id",
  "_group","_dropBox","_class","_color",
  "_name","_markerData","_marker"
];

_display = ctrlParent _control;
_displayName = cTabIfOpen # 1;
([_displayName,"MarkerWidget"] call cTab_fnc_getSettings) params ["_show","_curSel","_BoxSel","_texts","_widgetMode"];

if (!_show || _widgetMode != 0) exitWith {};

_markers = (if (isMultiplayer) then {
	allMapMarkers select {markerChannel _x == currentChannel}
} else {
	allMapMarkers
}) select {"_cTab_DEFINED" in _x};

_id = (selectMax (_markers apply {
  private _a = _x select [15];
  parseNumber ((_a splitString ":") # 1);
})) + 1;

if (isNil{_id}) then {
  _id = 0;
};

//- From Marker placer
_group = _display displayCtrl (17000 + 1300);
_dropBox = _group controlsGroupCtrl 10;

_class = ("true" configClasses (configFile >> "cTab_CfgMarkers")) # _curSel;
_color = getText (_class >> "MarkerColor");

if (_color == "") then {
  private ["_colorSel","_markerColor"];
  _colorSel = [_displayName,"markerColor"] call cTab_fnc_getSettings;
  _markerColor = _display displayCtrl (17000 + 1090);
  _color = (call compile (_markerColor lbData _colorSel)) # 0
};


//- MARKER #<PlayerID>/<MarkerID>/<ChannelID>/<Hide Direction>
_name = format ["_cTab_DEFINED #%1:%2:%3:%4:0", clientOwner, _id, currentChannel, getNumber (_class >> "Hide_Direction")];
_markerData = format ["|%1|%2|%3|%4|%5|%6|%7",_dropBox lbData _BoxSel,"ICON","[1,1]",0,"Solid",_color,1];

if (_markerData isEqualTo "") exitWith {
  ["Marker data is empty"] call BIS_fnc_error;
};

_markerData splitString (_markerData select [0,1]) params [
  "_markerType",
  "_markerShape",
  "_markerSize",
  "_markerDir",
  "_markerBrush",
  "_markerColor",
  "_markerAlpha"
];

_marker = createMarker [_name, _control posScreenToWorld [_xPos,_yPos], currentChannel, cTab_player];

_marker setMarkerType _markerType;
_marker setMarkerShape _markerShape;
_marker setMarkerSize parseSimpleArray _markerSize;
_marker setmarkerDir parseNumber _markerDir;
_marker setMarkerBrush _markerBrush;
_marker setMarkerColor _markerColor;
_marker setMarkerAlpha parseNumber _markerAlpha;
_marker setMarkerDrawPriority 0;
_marker setMarkerShadow true;

_texts params [["_prefix",""],["_index",""],["_DESC",""]];

_marker setMarkerText format [
  "%1%2%3",
  _prefix + (["-",""] select (_index == "")),
  _index,
  [" || " + _DESC, _DESC] select (_DESC == "" || (_prefix == "" && _index == ""))
];

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