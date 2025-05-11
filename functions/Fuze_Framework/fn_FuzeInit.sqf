/*
  NAME : BCE_fnc_FuzeInit
*/
params ["_unit","_fuzeData","_targetPOS"];
_fuzeData params ["_fuzeType","_fuzeValue"];

private _triggerValue = switch (_fuzeType) do {
  case "VT": { //- IN ASL HEIGHT
    (getTerrainHeight _targetPOS) + _fuzeValue
  };
  default {0};
};

_unit setVariable ["#NextFuze", [_fuzeType,_triggerValue]];