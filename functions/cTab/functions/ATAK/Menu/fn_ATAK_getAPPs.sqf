params [["_Reset_Value",false],["_onInit",false]];

private _return = profileNamespace getVariable ["BCE_ATAK_APPs", []];

//- Check ATAK Menu items (on postInit)
  if (_onInit && _return findIf {true} > -1) exitWith {
    private _classes = "true" configClasses (configFile >> "ATAK_APPs");
    private _result = _classes apply {
      !((configName _x) in _return)
    };

    //- if anything isn't in "_return" Array (Rearrange "_return")
    if (_result findIf {_x} > -1) then {
      private _list = _classes apply {[getNumber (_x >> "Menu_Property" >> "ORDER"), configName _x]};
      private _New_Order = [_list, [], {_x # 0}, "ASCEND"] call BIS_fnc_sortBy;
      {
        if (_x) then {
          _return set [_forEachIndex, _New_Order # _forEachIndex # 1];
        };
      } forEach _result;
      profileNamespace setVariable ["BCE_ATAK_APPs", _return];

      //- Rearrange APP HashMap (uiNamespace)
        private _HashMap = _return apply {
          private _cfg = configFile >> "ATAK_APPs" >> _x >> "Menu_Property";
          private _page = getText (_cfg >> "PAGE_CTRL");
          private _Opened = getText (_cfg >> "Opened");

          [_x, [_page,_Opened]]
        };
        uiNamespace setVariable ["BCE_ATAK_APPs_HashMap", createHashMapFromArray _HashMap];
    };
  };

//- if Force Reset || Empty Variable
if (_Reset_Value || _return findIf {true} < 0) then {
  private _classes = "true" configClasses (configFile >> "ATAK_APPs");
  private _result = _classes apply {[getNumber (_x >> "Menu_Property" >> "ORDER"), configName _x]};

  _result = [_result, [], {_x # 0}, "ASCEND"] call BIS_fnc_sortBy;
  _return = _result apply {_x # 1};

  //- Set HashMap for finding "Menu className" (Force Reset)
    uiNamespace setVariable ["BCE_ATAK_APPs_HashMap", createHashMapFromArray (
      _classes apply {
        private _cfg = _x >> "Menu_Property";
        private _page = getText (_cfg >> "PAGE_CTRL");
        private _Opened = getText (_cfg >> "Opened");

        [configName _x, [_page, _Opened]]
      }
    )];

  profileNamespace setVariable ["BCE_ATAK_APPs", _return];
};

//- Set HashMap for finding "Menu className" (Debug)
  private _APPs_Map = uiNamespace getVariable ["BCE_ATAK_APPs_HashMap", createHashMap];
  if (count _APPs_Map == 0) then {
    private _result = _return apply {
      private _cfg = configFile >> "ATAK_APPs" >> _x >> "Menu_Property";
      private _page = getText (_cfg >> "PAGE_CTRL");
      private _Opened = getText (_cfg >> "Opened");
      
      [_x, [_page,_Opened]]
    };
    uiNamespace setVariable ["BCE_ATAK_APPs_HashMap", createHashMapFromArray _result];
  };

_return