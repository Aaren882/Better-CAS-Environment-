private _displayName = cTabIfOpen param [1,""];
if (_displayName == "") exitWith {["",controlNull]};

//- Don't Run this onEachFrame or similar
  private _display = uiNamespace getVariable _displayName;
  private _order = [] call BCE_fnc_ATAK_getAPPs;
  private _settings = ["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings;
  private _page = _settings param [0, ""];

private _Apps_Group = _display displayCtrl (17000 + 4650);
private _menuIDC = 15000 + (_order find _page);

[_page, _Apps_Group controlsGroupCtrl _menuIDC];