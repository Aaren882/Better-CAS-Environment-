// - "BCE_fnc_ATAK_openMenu" (in "BCE_fnc_ATAK_openPage")
params ["_HomePage"];

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
    // _Apps_Group ctrlshow true;
    
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
      _ctrl ctrlshow true;

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
  private _APPs_Map = uiNamespace getVariable ["BCE_ATAK_APPs_HashMap", createHashMap];
  private _currentMenu = _APPs_Map get _page;
  private _menuIDC = 100 + (_order find _page);

  //- Check Ctrls
    private _Apps_Group = _display displayCtrl (17000 + 4650);
    private _allCtrls = allControls _Apps_Group;
    private _ctrl = _allCtrls param [0, controlNull];
    // private _createCtrls = _allCtrls findIf {ctrlClassName _x == _page} > -1;

    //- if selected "_page" isn't current "_page"
    if (ctrlIDC _ctrl != _menuIDC) then {
       private _config = [
        configFile >> "RscTitles",
        configFile
      ] select _isDialog;
      {ctrlDelete _x} count _allCtrls; //- Reset ControlGroup
      hintSilent str [_display,_config >> _currentMenu,_Apps_Group,time];
      
      _ctrl = _display ctrlCreate [_config >> _currentMenu, _menuIDC, _Apps_Group];
    };

    systemChat str [ctrlIDC _ctrl != _menuIDC,_currentMenu,_ctrl,_allCtrls,time];