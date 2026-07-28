params ["_menu","_isDialog"];

private _config = [
  configFile >> "RscTitles",
  configFile
] select _isDialog;

//- Return Menu Ctrl "config"
  _config >> _menu
