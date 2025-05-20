/*
  NAME : BCE_fnc_CFF_AMC

  Medthod of Control >> "AMC"
*/

params ["_taskUnit",["_chargeInfo",[]]];

private _executed = _chargeInfo findIf {true} < 0;

//- Trigger EH
  ["BCE_CFF_Event_AMC", _this + [_executed]] call CBA_fnc_localEvent;