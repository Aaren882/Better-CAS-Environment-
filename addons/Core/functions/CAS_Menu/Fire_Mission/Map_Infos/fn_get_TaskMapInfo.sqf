/* 
  NAME : BCE_fnc_get_TaskMapInfo

  params :
    _entry,   : The Class in #LINK - Mission_Map_Infos.hpp
    _key,     : Entry key for the Info Class
    
    _default, : (OPTIONAL) if Key is nil => ""
*/
params ["_entry","_key",["_default",""]];

//- Get Entry Varialbe Name
  private _props = _entry call BCE_fnc_get_TaskMapInfoEntry;

_props getOrDefault [_key, _default];
