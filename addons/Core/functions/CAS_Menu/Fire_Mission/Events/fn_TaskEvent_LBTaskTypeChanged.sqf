/*
  NAME : BCE_fnc_TaskEvent_LBTaskTypeChanged

  On Task/Mission Type Changed "ex. (AIR_9_Line => AIR_5_Line)"
*/

params ["_control","_lbCurSel"];

([ctrlParent _control] call BCE_fnc_getDisplayTaskProps) params ["","","_events"];

//- Fire Function
  _this call (uiNamespace getVariable [(_events get "LBTaskTypeChanged"),{}]);
