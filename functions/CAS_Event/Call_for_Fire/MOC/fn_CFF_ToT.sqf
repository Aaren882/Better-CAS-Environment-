/*
  NAME : BCE_fnc_CFF_ToT

  Medthod of Control >> "ToT"
*/

params ["_taskUnit",["_chargeInfo",[]]];

private _executed = _chargeInfo findIf {true} < 0;

//- Trigger EH
  ["BCE_CFF_Event_ToT", _this + [_executed]] call CBA_fnc_localEvent;

//- Exit if no _chargeInfo
  if (_executed) exitWith {
    ["_chargeInfo = []"] call BIS_fnc_error;
  };
  
  _chargeInfo params ["_charge", "_angleA", "_ETA", "_pos"];

//- Execute Fire Mission
	[
		_chargeInfo,
		_taskUnit,
		["RELOAD", (3 * 60 - _ETA) max 0, _taskUnit] call BCE_fnc_get_CFF_Value
	] call BCE_fnc_doFireMission;