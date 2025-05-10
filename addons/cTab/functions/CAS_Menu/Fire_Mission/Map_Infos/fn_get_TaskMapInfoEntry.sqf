/* 
  NAME : BCE_fnc_get_TaskMapInfoEntry

  params :
    _entry,   : The Class in #LINK - Mission_Map_Infos.hpp

  Return :
    Variable Name : Entry Varialbe Name e.g. "#ClassName"
*/
params ["_entry"];

//- HashMap
private _variable = localNamespace getVariable "BCE_Mission_MapInfo_Components";

//- Build Variable Entries
  if (isnil {_variable}) then {
    private _Map_Info_Map = createHashMap; //- Hashmap of Map Infos

    /*
      Get Map Infos
      #LINK - Mission_Map_Infos.hpp
    */
      private _mapInfoCfg = configFile >> "Mission_Map_Infos";
      {
        private _cfg = _x;
        private _cfgName = configName _cfg;
        private _varName = format ["#%1", _cfgName];
        
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
        
        //- Save Props as "#ClassName"
        localNamespace setVariable [_varName, createHashMapFromArray _result];

        _Map_Info_Map set [_cfgName, _varName];

      } forEach (configProperties [_mapInfoCfg]);

    localNamespace setVariable ["BCE_Mission_MapInfo_Components", _Map_Info_Map];
    
    _variable = _Map_Info_Map;
  };

_variable getOrDefault [_entry, ""]
