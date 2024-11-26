params [["_Reset_Value",false]];

private _return = profileNamespace getVariable ["BCE_ATAK_APPs", []];

//- if Force Reset || Empty Variable
if (_Reset_Value || _return findIf {true} < 0) then {
  private _classes = "true" configClasses (configFile >> "ATAK_APPs");
  private _result = _classes apply {[getNumber (_x >> "ORDER"), configName _x]};
  _result = [_result, [], {_x # 0}, "ASCEND"] call BIS_fnc_sortBy;
  _return = _result apply {_x # 1};

  profileNamespace setVariable ["BCE_ATAK_APPs", _return];
};

_return