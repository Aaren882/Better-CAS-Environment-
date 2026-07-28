// - BCE_fnc_ATAK_setAPPs_props
params ["_configNames"];

private _result = _configNames apply {
  private _cfg = configFile >> "ATAK_APPs" >> _x >> "Menu_Property";
  private _page = getText (_cfg >> "PAGE_CTRL");
  private _Opened = getText (_cfg >> "Opened");
  
  private _pages_props = (configProperties [_cfg >> "Pages"]) apply {
    [configName _x, [getText (_x >> "Opened"),_x]]
  };
  private _pages = createHashMapFromArray _pages_props;
  
  [_x, [_page,_Opened,_pages,_cfg]]
};

localNamespace setVariable ["BCE_ATAK_APPs_HashMap", createHashMapFromArray _result];
