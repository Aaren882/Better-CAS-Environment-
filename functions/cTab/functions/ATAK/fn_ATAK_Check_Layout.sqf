//- Get Basic Variable infos
  private _onSwitch = _backgroundGroup getVariable ["Anim_SwitchTool",false]; //- Check on switching Tool
  private _onToggle = _backgroundGroup getVariable ["Anim_ToggleMenu",_interfaceInit]; //- Check on toggling Menu
  if (_onSwitch) then {_backgroundGroup setVariable ["Anim_SwitchTool",false]};
  if (_onToggle) then {_backgroundGroup setVariable ["Anim_ToggleMenu",false]};

  (ctrlPosition _background) params ["","","_bgW","_bgH"];

//- Get Map Type and Arrange
  private _targetMapName = [_displayName,"mapType"] call cTab_fnc_getSettings;
  private _mapTypes = [_displayName,"mapTypes"] call cTab_fnc_getSettings;
  private _targetMapIDC = [_mapTypes,_targetMapName] call cTab_fnc_getFromPairs;
  private _targetMapCtrl = _display displayCtrl _targetMapIDC;
  (ctrlPosition _targetMapCtrl) params ["_MapX","_MapY","_MapW","_MapH"];
  private _result = _bgW / 2 * ([5, 3] select _show);
  [
    _targetMapCtrl, // - Ctrl
    [
      [],
      [
        _MapX,
        _MapY,
        _result
      ]
    ], // - [Start, End]
    ["Spring_Example",_interfaceInit, 1200, [3]] // - [Anim_Type, _instant, _BG_IDC, _ignore]
  ] call BCE_fnc_Anim_CustomOffset;
  _targetMapCtrl ctrlMapSetPosition [];

//- Self Info Box
  private _bat = _display displayCtrl 2;
  (ctrlPosition _bat) params ["_batX"];

  {
    private _ctrl = _display displayCtrl (17000 + _x);
    [
      _ctrl, // - Ctrl
      [
        [],
        [
          (_MapX + _result - (ctrlPosition _ctrl # 2) + (_MapX - _batX)),
          (ctrlPosition _ctrl) # 1
        ]
      ], // - [End]
      ["Spring_Example",_interfaceInit, 1200, [2,3]] // - [Anim_Type, _instant, _BG_IDC, _ignore]
    ] call BCE_fnc_Anim_CustomOffset;
  } count [
    2620,
    2621,
    2622
  ];
  private _callSign = _display displayCtrl (17000 + 2620);
  _callSign ctrlSetText ([groupId group cTab_player, [cTab_player] call CBA_fnc_getGroupIndex] joinString ":");

//- Marker Tool
  private _tool = _display displayCtrl (17000 + 1300);
  (ctrlPosition _tool) params ["","_POSY","_POSW","_POSH"];
  [
    _tool, // - Ctrl
    [[],[_MapX + _result - _POSW, _POSY]], // - [Start, End]
    ["Spring_Example",_interfaceInit, 1200, [2]] // - [Anim_Type, _instant, _BG_IDC, _ignore]
  ] call BCE_fnc_Anim_CustomOffset;

//- Set Background Animation
  {
    _x params ["_c",["_ignore_fade",true],["_skip",false]];
    
    //- need to ignore fade
    if !(_skip) then {
      private _fade = [0, nil] select _ignore_fade;
      [
        _c, // - Ctrl
        [
          [],
          [
            _MapX + _result,
            _POSY,
            [0, _bgW] select _show,
            nil,
            [1, _fade] select (_show || _ignore_fade)
          ]
        ], // - [Start, End]
        ["Spring_Example",_interfaceInit, 1200, [3]] // - [Anim_Type, _instant, _BG_IDC, _ignore]
      ] call BCE_fnc_Anim_CustomOffset;
    };
  } count [
    [_backgroundGroup],
    [_group, false, !_onToggle && !(_line < 0) && !_onSwitch]
  ];
  
  private _toolBnt = _display displayCtrl 46600;
  [
    _toolBnt, //- Tool Bnts
    [
      [],
      [
        _MapX + _result,
        _POSY + _bgH - (ctrlPosition _toolBnt) # 3,
        [0, _bgW] select _show
      ]
    ], // - [Start, End]
    ["Spring_Example",_interfaceInit, 1200, [3]] // - [Anim_Type, _instant, _BG_IDC, _ignore]
  ] call BCE_fnc_Anim_CustomOffset;