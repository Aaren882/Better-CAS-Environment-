params ["_displayOrControl","_index"];

#define PLP_TOOL 0

//-POLPOX map tools
#if __has_include("\PLP_MapTools\config.bin")
  #define PLP_TOOL 1
#endif

#if __has_include("\plp\plp_mapToolsRemastered\config.bin")
  #if PLP_TOOL > 0
    #define PLP_TOOL 3
  #else
    #define PLP_TOOL 2
  #endif
#endif

private _vars = uiNameSpace getVariable ["BCE_MainMap_Widget",[true,true,true,true]];
if (_index < 0) exitWith {
  {
    private ["_condition","_ctrl","_color"];
    // - ACE map flashlight
    #if __has_include("\z\ace\addons\map\config.bin")
      _condition = [
        _vars # _forEachIndex,
        [
          isnull ((ace_player getVariable ["ace_map_flashlight", ["", objNull]]) # 1),
          false
        ] select ((count ([ace_player] call ace_map_fnc_getUnitFlashlights) == 0) || !(ace_map_mapillumination))
      ] select (_forEachIndex == 2);
    #else
      _condition = _vars # _forEachIndex;
    #endif

    _ctrl = _displayOrControl displayCtrl _x;
    _ctrl ctrlSetBackgroundColor ([0,0,0,[0.5,1] select _condition]);
    _ctrl ctrlSetTextColor ([1,1,1,[0.5,1] select _condition]);

    //-POLPOX map tools
    #if PLP_TOOL > 0
      if (_forEachIndex == 3) then {
        private ["_image","_h","_text"];

        _image = '<img image="\a3\3den\data\displays\display3den\toolbar\grid_rotation_off_ca.paa" align="center" size="1.0" />';
        #if PLP_TOOL == 1
          _h = 2.3 * (0.85 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25));
          _text = format [
            '%1POLPOX Tools <br/><t align="left">Simple :<t align="right" color="#edff24">“%3”</t></t>',
            _image,
            localize "STR_BCE_Ctrl_R_Click"
          ];
        #endif
        #if PLP_TOOL == 2
          _h = 2.3 * (0.85 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25));
          _text = format [
            '%1POLPOX Tools <br/><t align="left">Remastered :<t align="right" color="#edff24">%2</t></t>',
            _image,
            keyImage ((actionKeys "PLP_SMT_OpenTools") # 0)
          ];
        #endif
        #if PLP_TOOL == 3
          _h = 3.3 * (0.85 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25));
          _text = format [
            '%1POLPOX Tools <br/><t align="left">Remastered :<t align="right" color="#edff24">%2</t><br/>Simple :<t align="right" color="#edff24">“%3”</t></t>',
            _image,
            keyImage ((actionKeys "PLP_SMT_OpenTools") # 0),
            localize "STR_BCE_Ctrl_R_Click"
          ];
        #endif
        _ctrl ctrlSetPositionH _h;
        _ctrl ctrlCommit 0;

        _ctrl ctrlEnable false;
        _ctrl ctrlSetBackgroundColor [0,0,0,0.3];
        _ctrl ctrlSetStructuredText parsetext _text;
      };
    #endif

  } forEach [1606,1607,1608,1609];
};

//-Set Variable
// - ACE map flashlight
#if __has_include("\z\ace\addons\map\config.bin")
  private _cur = [
    !(_vars # _index),
    [
      !isnull ((ace_player getVariable ["ace_map_flashlight", ["", objNull]]) # 1),
      false
    ] select ((count ([ace_player] call ace_map_fnc_getUnitFlashlights) == 0) || !(ace_map_mapillumination))
  ] select (_index == 2);

  //-Exit if there map illumination is disabled or no flashlight available
  if ((_index == 2) && ((count ([ace_player] call ace_map_fnc_getUnitFlashlights) == 0) || !(ace_map_mapillumination))) exitWith {
    systemchat localize "STR_BCE_Map_No_FlashLight";
  };

  if (_index == 2) then {
    [ace_player, [([ace_player] call ace_map_fnc_getUnitFlashlights) # 0, ""] select _cur] call ace_map_fnc_switchFlashlight;
  };
#else
  private _cur = !(_vars # _index);
#endif

_vars set [_index, _cur];
uiNamespace setVariable ["BCE_MainMap_Widget",_vars];

//-Set Color
_displayOrControl ctrlSetBackgroundColor ([0,0,0,[0.5,1] select _cur]);
_displayOrControl ctrlSetTextColor ([1,1,1,[0.5,1] select _cur]);
