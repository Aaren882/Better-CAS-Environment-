// - "BCE_fnc_ATAK_openMenu" (in "BCE_fnc_ATAK_openPage")
params ["_page","_subMenu","_HomePage"];

private _order = [] call BCE_fnc_ATAK_getAPPs;
private _isDialog = [cTabIfOpen # 1] call cTab_fnc_isDialog;

//- Set ATAK APPs (by order)
  if (_HomePage) exitwith {
    private _Apps_Group = _display displayCtrl (17000 + 4660);
    private _createCtrls = (allControls _Apps_Group) findIf {true} < 0;

    private _config = [
      configFile >> "RscTitles" >> "ATAK_APPs",
      configFile >> "ATAK_APPs"
    ] select _isDialog;
    
    private _ROWs = 3;
    private _APP_W = (_ctrlPOS_BG # 2) / 3;
    private _Yaxis = 0;

    {
      //- Check Ctrls
        private _ctrl = if (_createCtrls) then {
          _display ctrlCreate [_config >> _x, 100 + _forEachIndex, _Apps_Group];
        } else {
          _Apps_Group controlsGroupCtrl (100 + _forEachIndex);
        };

      private _o = _forEachIndex mod _ROWs; //- Checking Order

      //- Check Y POS (Skip the first ROW)
        if (_o == 0 && _forEachIndex >= _ROWs) then {
          _Yaxis = _Yaxis + ((ctrlPosition _ctrl) # 3);
        };
      
      _ctrl ctrlSetPositionX (_APP_W * _o);
      _ctrl ctrlSetPositionY _Yaxis;
      _ctrl ctrlCommit 0;
    } forEach _order;
  };

//- Set APP Menu
  (_page call BCE_fnc_ATAK_getAPPs_props) params ["_currentMenu","_function","_subMenus"];

  //- if subMenu exist then overwrite [_currentMenu, [_function, _Config]]
    if (_subMenu != "") then {
      _currentMenu = _subMenu;
      _function = (_subMenus get _subMenu) param [0,""];
    };

  //- Check Ctrls
    private _Apps_Group = _display displayCtrl (17000 + 4650);
    private _menuIDC = 15000 + (_order find _page);

    //- if selected "_page" isn't current "_page"
      private _ctrl = [
        _currentMenu, //- Create Menu className
        _menuIDC,     //- Desire IDC
        _Apps_Group,  //- Group will Attached to
        _isDialog,    //- (MUST) "BOOL"
        true          //- Reset Page (OPTIONAL) : false
      ] call BCE_fnc_ATAK_createSubPage;

  //- Opened
    [_ctrl,_interfaceInit,_isDialog,_settings] call {
      privateAll;
      import ["_function"];
      _this call (uiNamespace getVariable _function);
    };