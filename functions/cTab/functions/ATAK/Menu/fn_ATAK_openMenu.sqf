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
  private _APPs_Map = uiNamespace getVariable ["BCE_ATAK_APPs_HashMap", createHashMap];
  (_APPs_Map get _page) params ["_currentMenu","_function","_subMenus"];
  /* _subInfos params ["_subMenu","_curLine"]; */
  
  //- if subMenu exist then overwrite [_currentMenu, _function]
  if (_subMenu != "") then {
    _currentMenu = _subMenu;
    _function = _subMenus get _subMenu;
  };

  //- Check Ctrls
    private _Apps_Group = _display displayCtrl (17000 + 4650);
    private _menuIDC = 15000 + (_order find _page);
    private _allCtrls = allControls _Apps_Group;
    // private _ctrl = (_allCtrls select {ctrlIDC _x >= 15000}) param [0, controlNull];
    private _ctrl = (call BCE_fnc_ATAK_getCurrentAPP) # 1;

    //- if selected "_page" isn't current "_page"
    if (ctrlClassName _ctrl != _currentMenu) then {
       private _config = [
        configFile >> "RscTitles",
        configFile
      ] select _isDialog;
      {ctrlDelete _x} count _allCtrls; //- Reset ControlsGroup
      
      _ctrl = _display ctrlCreate [_config >> _currentMenu, _menuIDC, _Apps_Group];
    };

  //- catch empty "Opened function"
    if (_function == "") exitWith {
      ["“Opened function” of this page is not exist"] call BIS_fnc_error;
    };

  //- Opened
    [_ctrl,_interfaceInit,_settings] call (uiNamespace getVariable _function);