/*
  NAME : BCE_fnc_CFF_Mission_Get_Group

  Get Call for Fire mission unit group

	Return : Unit Group <GROUP>
*/
params [
  "_taskID"
];

private _pool = localNamespace getVariable ["#BCE_CFF_Task_Pool", createHashMap];
_pool getOrDefault [_taskID, grpNull];