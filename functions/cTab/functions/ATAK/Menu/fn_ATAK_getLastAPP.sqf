/*
  NAME : BCE_fnc_ATAK_getLastAPP

  Params :
    ["_key","_default"]

  ==========================================
  Get "BCE_ATAK_APPs_HashMap" Values
  from => configFile >> "ATAK_APPs" >> _NAME >> "Menu_Property" >> "Pages"

  Return : 
    <STRING>
  ==========================================
  
  Examples :
  [
    ["Task_Building","mission"],
    ["Task_CFF_List","mission"],
    ["Task_Result","mission"]
  ]
*/
params ["_key",["_default","main"]];

private _map = localNamespace getVariable ["BCE_ATAK_SubMenu_HashMap", createHashMap];

if (count _map == 0) then {
  private _configNames = [] call BCE_fnc_ATAK_getAPPs;

  {
    private _name = _x;
    private _cfg = configFile >> "ATAK_APPs" >> _x >> "Menu_Property";
    {
      _map set [_x param [0,""], _name];
    } forEach (getArray (_cfg >> "Pages"));
  } forEach _configNames;

  localNamespace setVariable ["BCE_ATAK_SubMenu_HashMap", _map];
};

//- Default "main" that's the main menu
_map getOrDefault [_key, _default];