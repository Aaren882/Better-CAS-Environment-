params [["_Reset_Value",false],["_onInit",false]];

private _ATAK_APPs = profileNamespace getVariable ["BCE_ATAK_APPs", []];

//- Check ATAK Menu items (on postInit)
  if (_onInit && _ATAK_APPs findIf {true} > -1) exitWith {
    private _classes = "true" configClasses (configFile >> "ATAK_APPs");
    private _result = _classes apply {
      !((configName _x) in _ATAK_APPs)
    };

    //- if anything isn't in "_ATAK_APPs" Array (Rearrange "_ATAK_APPs")
    if (_result findIf {_x} > -1) then {
      private _list = _classes apply {[getNumber (_x >> "Menu_Property" >> "ORDER"), configName _x]};
      private _New_Order = [_list, [], {_x # 0}, "ASCEND"] call BIS_fnc_sortBy;
      {
        if (_x) then {
          _ATAK_APPs set [_forEachIndex, _New_Order # _forEachIndex # 1];
        };
      } forEach _result;
      profileNamespace setVariable ["BCE_ATAK_APPs", _ATAK_APPs];
      
      //- Rearrange APP HashMap (uiNamespace)
        [_ATAK_APPs] call BCE_fnc_ATAK_setAPPs_props; //- Update APP Props
    };
  };

//- if Force Reset || Empty Variable (profileNamespace)
if (_Reset_Value || _ATAK_APPs findIf {true} < 0) then {
  private _classes = "true" configClasses (configFile >> "ATAK_APPs");
  private _result = _classes apply {[getNumber (_x >> "Menu_Property" >> "ORDER"), configName _x]};

  _result = [_result, [], {_x # 0}, "ASCEND"] call BIS_fnc_sortBy;
  _ATAK_APPs = _result apply {_x # 1};

  //- Set HashMap for finding "Menu className" (Force Reset)
    [_ATAK_APPs] call BCE_fnc_ATAK_setAPPs_props; //- Update APP Props

  profileNamespace setVariable ["BCE_ATAK_APPs", _ATAK_APPs];
};

//- Set HashMap for finding "Menu className" (Debug - uiNamespace)
  private _APPs_Map = localNamespace getVariable ["BCE_ATAK_APPs_HashMap", createHashMap];
  if (count _APPs_Map == 0) then {
    [_ATAK_APPs] call BCE_fnc_ATAK_setAPPs_props; //- Update APP Props
  };

_ATAK_APPs