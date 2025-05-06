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
    private _pages = configProperties [_cfg >> "Pages"];
    {
      //- #NOTE - [PAGE_NAME, MAIN_PAGE_NAME]
      private _pageName = [
        _name,
        getText (_x >> "LastPage")
      ] select isText(_x >> "LastPage");

      _map set [configName _x, _pageName];
    } forEach _pages;
  } forEach _configNames;

  localNamespace setVariable ["BCE_ATAK_SubMenu_HashMap", _map];
};

//- Default "main" that's the main menu
_map getOrDefault [_key, _default];