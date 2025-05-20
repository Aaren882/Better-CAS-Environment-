/*
  NAME : BCE_fnc_CFF_AT_READY

  Medthod of Control >> "At-Ready"
*/

params ["_taskUnit",["_chargeInfo",[]]];

// private _taskUnit = [nil,"CFF" call BCE_fnc_get_TaskIndex] call BCE_fnc_get_TaskCurUnit;
// private _chargeInfo = ["chargeInfo", [], _taskUnit] call BCE_fnc_get_CFF_Value;
private _executed = _chargeInfo findIf {true} < 0;

//- Trigger EH
  ["BCE_CFF_Event_At_Ready", _this + [_executed]] call CBA_fnc_localEvent;

//- Exit if no _chargeInfo
  if (_executed) exitWith {
    ["_chargeInfo = []"] call BIS_fnc_error;
  };

//- Execute Fire Mission
  [_chargeInfo, _taskUnit, 2] call BCE_fnc_doFireMission;