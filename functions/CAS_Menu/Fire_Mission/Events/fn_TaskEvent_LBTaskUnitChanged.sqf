/*
  NAME : BCE_fnc_TaskEvent_LBTaskUnitChanged

  On Task/Mission Unit Changed "DropBox menu only"
*/

params ["_control","_lbCurSel"];

([ctrlParent _control] call BCE_fnc_getDisplayTaskProps) params ["_varName","","_events"];

//- Fires Function (Get the Unit Object)
  _this call (uiNamespace getVariable [(_events get "LBTaskUnitChanged"),{}]);