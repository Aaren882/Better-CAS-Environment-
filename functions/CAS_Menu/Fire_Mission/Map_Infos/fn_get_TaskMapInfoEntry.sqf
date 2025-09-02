/* 
  NAME : BCE_fnc_get_TaskMapInfoEntry

  params :
    _entry,   : The Class in #LINK - Mission_Map_Infos.hpp

  Return :
    Variable Name : Entry Variable Name e.g. "#ClassName"*/
params ["_entry"];

//- HashMap
private _variable = localNamespace getVariable "BCE_Mission_MapInfo_Components";

//- Build Variable Entries
  if (isnil {_variable}) then {
    _variable = createHashMap; //- Hashmap of Map Infos

    /*
      Get Map Infos
      #LINK - Mission_Map_Infos.hpp
    */
      private _mapInfoCfg = configFile >> "Mission_Map_Infos_Icons";
      {
        private _cfg = _x;
        private _cfgName = configName _cfg;
        
        private _result = [
          "display",
          "Icon",
          "color",
          "font",
          "shadow",
          "textSize",
          "align",
          "sizeW",
          "sizeH"
        ] apply {
          [
            _x,
            [_cfg, _x] call BIS_fnc_returnConfigEntry
          ]
        };

        _variable set [_cfgName, createHashMapFromArray _result];
      } forEach (configProperties [_mapInfoCfg]);

    localNamespace setVariable ["BCE_Mission_MapInfo_Components", _variable];
  };

_variable getOrDefault [_entry, createHashMap]
