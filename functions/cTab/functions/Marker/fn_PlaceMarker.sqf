params ["_control", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];

private [
  "_display","_displayName","_markers","_id",
  "_group","_dropBox","_Color",
  "_name","_markerData","_marker"
];

_display = ctrlParent _control;
_displayName = cTabIfOpen # 1;
([_displayName,"MarkerWidget"] call cTab_fnc_getSettings) params ["_show","_curSel","_BoxSel","_texts"];

if !(_show) exitWith {};

_markers = if (isMultiplayer) then {
	allMapMarkers select {markerChannel _x == currentChannel}
} else {
	allMapMarkers
};

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

_Color = (("true" configClasses (configFile >> "cTab_CfgMarkers")) apply {getText (_x >> "MarkerColor")}) # _curSel;

if (_color == "") then {
  private ["_colorSel","_markerColor"];
  _colorSel = [_displayName,"markerColor"] call cTab_fnc_getSettings;
  _markerColor = _display displayCtrl (17000 + 1090);
  _color = (call compile (_markerColor lbData _colorSel)) # 0
};


//- MARKER #<PlayerID>/<MarkerID>/<ChannelID>
_name = format ["_cTab_DEFINED #%1:%2:%3",clientOwner,_id,currentChannel];
_markerData = format ["|%1|%2|%3|%4|%5|%6",_dropBox lbData _BoxSel,"ICON","[1,1]","Solid",_color,1];

if (_markerData isEqualTo "") exitWith {
  ["Marker data is empty"] call BIS_fnc_error;
};

_markerData splitString (_markerData select [0,1]) params [
  "_markerType",
  "_markerShape",
  "_markerSize",
  "_markerBrush",
  "_markerColor",
  "_markerAlpha"
];

_marker = createMarker [_name, _control posScreenToWorld [_xPos,_yPos], currentChannel, cTab_player];

_marker setMarkerType _markerType;
_marker setMarkerShape _markerShape;
_marker setMarkerSize parseSimpleArray _markerSize;
_marker setMarkerBrush _markerBrush;
_marker setMarkerColor _markerColor;
_marker setMarkerAlpha parseNumber _markerAlpha;

_texts params [["_prefix",""],["_index",""],["_DESC",""]];

_marker setMarkerText format [
  "%1%2%3",
  _prefix,
  ["-" + _index,""] select (_index == ""),
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