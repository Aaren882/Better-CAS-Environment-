params ["_display","_marker"];
private _displayName = cTabIfOpen # 1;
private _group = _display displayCtrl (17000 + 1301);

private _desc = _group controlsGroupCtrl 10;
private _EDIT_Type = _group controlsGroupCtrl 50;
private _EDIT_color = _group controlsGroupCtrl 51;
private _channel = _group controlsGroupCtrl 110;

//- Marker Color Data
  private _markerColor = _display displayCtrl (17000 + 1090);

//- Marker Data
  private _selectColor = markerColor _marker;
  private _selectType = markerType _marker;
  _desc ctrlSetText markerText _marker;

  lbClear _EDIT_Type;

//- Select Marker Shape
  #if __has_include("\z\ace\addons\map_gestures\config.bin")
    if (ace_markers_MarkersCache findIf {_selectType == (_x # 3)} > -1) then {
      {
        _x params ["_name", "", "_icon", "_classname"];

        private _index = _EDIT_Type lbAdd _name;
        _EDIT_Type lbSetPicture [_index, _icon];
        _EDIT_Type lbSetData [_index, _classname];
        
        if (_selectType == _classname) then {
          _EDIT_Type lbSetCurSel _index;
        };
        false
      } count ace_markers_MarkersCache;
      _EDIT_Type ctrlEnable true;
    } else {
      _EDIT_Type ctrlEnable false;
    };
  #else
    private _cfg = "getnumber (_x >> 'scope') == 2" configClasses (configFile >> "CfgMarkers");
    private _typeCount = {
      private _Same = _selectType == configName _x;
      private _name = getText (_x >> "name");
      private _icon = getText (_x >> "icon");

      private _index = _EDIT_Type lbAdd _name;
      _EDIT_Type lbSetPicture [_index, _icon];
      
      if (_Same) then {
        _EDIT_Type lbSetCurSel _index;
      };
      _Same
    } count _cfg;
    _EDIT_Type ctrlEnable (_typeCount > 0);

  #endif

//- Select Color
  for "_i" from 0 to lbSize _markerColor - 1 do {
    private _color = (call compile (_markerColor lbData _i)) # 0;
    if (_color == _selectColor) exitWith {
      _EDIT_color lbSetCurSel _i;
    };
  };

//- Setup Channels
if (isMultiplayer) then {

  private _currentChannel = currentChannel;
  private _selectChannel = markerChannel _marker;

  //- Clear List first
  lbClear _channel;

  private _engineChannels = [ 
    [localize "str_channel_global", [0.847059,0.847059,0.847059]],
    [localize "str_channel_side", [0.27451,0.827451,0.988235]],
    [localize "str_channel_command", [1,1,0.27451]],
    [localize "str_channel_group", [0.709804,0.972549,0.384314]],
    [localize "str_channel_vehicle", [1,0.815686,0]]
  ];

  //- Check Channel
  for "_Id" from 0 to 15 do {
    if (_Id == 5) then {continue}; // Direct channel, ignore
    if (setCurrentChannel _Id) then {
      private _ch = _engineChannels # _Id;

      private _ChannelName = _ch param [0, (radioChannelInfo (_Id - 5)) # 1];
      private _color = _ch param [1, (radioChannelInfo (_Id - 5)) # 0];
      _color set [3, 1]; //- set Alpha

      private _index = _channel lbAdd _ChannelName;
      _channel lbSetColor [_index,_color];

      if (_Id == _selectChannel) then {
        _channel lbSetCurSel _index;
      };
    };
  };
  setCurrentChannel _currentChannel;

} else {
  _channel ctrlEnable false;
};

// - Add waitUntil handler (every 3 sec)
[
  //- "_this": [_args, _handle]
  {
    _args params ["_marker","_group","_displayName"];

    _EDIT_Marker = [_displayName,"MarkerEDIT"] call cTab_fnc_getSettings;
    _shape = markerShape _marker;

    //- Exit Handler
    if (
      _shape == "" || 
      !ctrlEnabled _group || 
      _EDIT_Marker != _marker
    ) exitwith {
      if (_shape == "") then {
        [_displayName,[["MarkerEDIT",""]],false] call cTab_fnc_setSettings;
      };

      [_handle] call CBA_fnc_removePerFrameHandler;
    };

    _pos = markerPos _marker;
    
    _PlaceDesc = _group controlsGroupCtrl 100;
    _direction = _group controlsGroupCtrl 120;
    _grid = _group controlsGroupCtrl 121;

    _PlaceDesc ctrlSetStructuredText parseText ((_pos call BIS_fnc_locationDescription) splitString " " joinString toString [160]);
    _direction ctrlSetStructuredText parseText format ["%1 <t align='center'>%2°</t>",localize "STR_A3_RscDisplayAVTerminal_AVT_Text_AZT" , round markerDir _marker];
    _grid ctrlSetStructuredText parseText format ["%1 <t align='center'>”%2”</t>",localize "STR_A3_RscDisplayAVTerminal_AVT_Text_POS" , [_pos,8] call BCE_fnc_POS2Grid];
    
  }, 3, [_marker,_group,_displayName]
] call CBA_fnc_addPerFrameHandler;