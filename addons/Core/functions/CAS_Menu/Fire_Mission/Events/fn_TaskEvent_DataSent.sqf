/*
  NAME : BCE_fnc_TaskEvent_DataSent

  On Task/Mission Task Sent
  Mainly for Mission Execution

  Return : BOOL
*/

params ["_taskUnit","_data"];

//- Fire Function
  private _return = [_taskUnit,_data] call (uiNamespace getVariable [(_events get "DataSent"),{}]);

if (isnil{_return}) exitWith {true};
_return
