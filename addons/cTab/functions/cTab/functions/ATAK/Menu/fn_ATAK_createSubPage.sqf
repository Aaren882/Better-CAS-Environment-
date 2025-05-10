/*
  NAME : BCE_fnc_ATAK_createSubPage

  Create page/control inside ATAK panel
*/

params ["_currentMenu","_menuIDC","_Apps_Group","_isDialog",["_reset",false]];

// private _ctrl = (call BCE_fnc_ATAK_getCurrentAPP) # 1;
private _ctrl = _Apps_Group controlsGroupCtrl _menuIDC;

//- if selected "_page" isn't current "_page"
if (ctrlClassName _ctrl != _currentMenu) then {
  
  private _display = ctrlParent _Apps_Group;
  private _config = [_currentMenu,_isDialog] call BCE_fnc_ATAK_getAPP_Config;

  if (_reset) then {
    private _allCtrls = allControls _Apps_Group;
    {ctrlDelete _x} count _allCtrls; //- Reset ControlsGroup
  };
  
  _ctrl = _display ctrlCreate [_config, _menuIDC, _Apps_Group];
};

//- Return
_ctrl