/*
  NAME : BCE_fnc_CFF_AMC

  Medthod of Control >> "AMC"
*/

params ["_taskUnit",["_chargeInfo",[]]];

private _executed = _chargeInfo findIf {true} < 0;

//- Trigger EH
  ["BCE_CFF_Event_AMC", _this + [_executed]] call CBA_fnc_localEvent;

//- Exit if no _chargeInfo
  if (_executed) exitWith {
    ["_chargeInfo = []"] call BIS_fnc_error;
  };

//- Get Delay
	private _delay = ["RELOAD", -1, _taskUnit] call BCE_fnc_get_CFF_Value;
	if (_delay < 0) then {
		_delay = 0;
	};

//- Execute Fire Mission
  [
		_chargeInfo,
		_taskUnit,
		_delay
	] call BCE_fnc_doFireMission;