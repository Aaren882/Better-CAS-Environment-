/*
  NAME : BCE_fnc_FuzeInit
*/
params ["_taskUnit","_fuzeData","_targetPOS"];
_fuzeData params ["_fuzeType","_fuzeValue"];

private _triggerValue = switch (_fuzeType) do {
  case "VT": { //- IN ASL HEIGHT
    _fuzeValue
  };
  default {0};
};

["NextFuze", [_fuzeType,_triggerValue], _taskUnit] call BCE_fnc_set_CFF_Value;