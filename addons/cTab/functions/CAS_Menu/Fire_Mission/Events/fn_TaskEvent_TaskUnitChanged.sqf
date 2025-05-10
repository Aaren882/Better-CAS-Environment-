/*
  NAME : BCE_fnc_TaskEvent_TaskUnitChanged

  On Task/Mission Unit Changed
*/

params ["_unit","_taskUnit"];

([] call BCE_fnc_getDisplayTaskProps) params ["","","_events"];

//- Fire Function (Get the Unit Object)
  _this call (uiNamespace getVariable [(_events get "TaskUnitChanged"),{}]);