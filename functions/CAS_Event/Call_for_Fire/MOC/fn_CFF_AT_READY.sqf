/*
  NAME : BCE_fnc_CFF_AT_READY

  Medthod of Control >> "At-Ready"
*/

params ["_taskUnit",["_chargeInfo",[]]];

private _executed = _chargeInfo findIf {true} < 0;

//- Trigger EH
  ["BCE_CFF_Event_At_Ready", _this + [_executed]] call CBA_fnc_localEvent;

//- Exit if no _chargeInfo
  if (_executed) exitWith {
    ["_chargeInfo = []"] call BIS_fnc_error;
  };

//- Execute Fire Mission
  [
		_chargeInfo,
		_taskUnit,
		["RELOAD", -1, _taskUnit] call BCE_fnc_get_CFF_Value
	] call BCE_fnc_doFireMission;