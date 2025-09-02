/*
  NAME : BCE_fnc_FuzeInit
	#TODO - Fuze Framework
*/
params ["_projectile","_fuzeData","_targetPOS"];
_fuzeData params ["_fuzeType","_fuzeValue"];

private _triggerValue = switch (_fuzeType) do {
  case "VT": { //- IN ASL HEIGHT
    _fuzeValue
  };
  case "DELAY": { //- Delay 0.05 by its design
    0.05
  };
  default {0};
};

_projectile setVariable ["#BCE_FUZE",[_fuzeType,_triggerValue]];