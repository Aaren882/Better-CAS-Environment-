/*
  NAME : BCE_fnc_ATAK_CFF_Mission_RAT_2_ADD
  
  On "ADD" pressed, for ATAK CFF interface only
	(it will add the FIRE-MSN back to the Mission list)
*/

params ["_control"];

//- Get the Hash Key
private _tagGrp = ctrlParentControlsGroup _control;
private _taskData = _tagGrp getVariable ["CFF_Task_Mission",""];

_taskData call BCE_fnc_CFF_Mission_RAT_2_ADD;
