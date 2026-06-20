/*
  NAME : BCE_fnc_ATAK_CFF_Mission_EOM
  
  On "Record as Target" pressed, for ATAK CFF interface only 
*/

params ["_control",["_removeRAT",false]];

//- Get the Hash Key
private _tagGrp = ctrlParentControlsGroup _control;
private _taskData = _tagGrp getVariable ["CFF_Task_Mission",""];

[_taskData] call BCE_fnc_CFF_Mission_EOM;
