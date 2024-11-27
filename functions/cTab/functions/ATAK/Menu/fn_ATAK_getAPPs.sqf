params [["_Reset_Value",false]];

private _return = profileNamespace getVariable ["BCE_ATAK_APPs", []];

//- if Force Reset || Empty Variable
if (_Reset_Value || _return findIf {true} < 0) then {
  private _classes = "true" configClasses (configFile >> "ATAK_APPs");
  private _result = _classes apply {[getNumber (_x >> "ORDER"), configName _x]};

  _result = [_result, [], {_x # 0}, "ASCEND"] call BIS_fnc_sortBy;
  _return = _result apply {_x # 1};

  //- Set HashMap for finding "Menu className" (Force Reset)
    uiNamespace setVariable ["BCE_ATAK_APPs_HashMap", createHashMapFromArray (
      _classes apply {
        [configName _x, getText (_x >> "PAGE_CTRL")]
      }
    )];

  profileNamespace setVariable ["BCE_ATAK_APPs", _return];
};

//- Set HashMap for finding "Menu className" (Debug)
  private _APPs_Map = uiNamespace getVariable ["BCE_ATAK_APPs_HashMap", createHashMap];
  if (count _APPs_Map == 0) then {
    private _result = _return apply {
      private _page = getText (configFile >> "ATAK_APPs" >> _x >> "PAGE_CTRL");
      [_x, _page]
    };
    uiNamespace setVariable ["BCE_ATAK_APPs_HashMap", createHashMapFromArray _result];
  };

_return