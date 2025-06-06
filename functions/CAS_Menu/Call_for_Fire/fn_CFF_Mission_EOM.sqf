/*
  NAME : BCE_fnc_CFF_Mission_EOM
  
  On CFF Abort pressed
*/
params ["_control"];

//- Remove the Hash Key
private _tagGrp = ctrlParentControlsGroup _control;
private _taskData = _tagGrp getVariable ["CFF_Task_Mission",""];

/* private _group = group _taskUnit;
private _pool = localNamespace getVariable ["#BCE_CFF_Task_Pool", createHashMap];
private _CFF_Map = _group getVariable ["BCE_CFF_Task_Pool", createHashMap];

_CFF_Map deleteAt _taskData;
_group setVariable ["BCE_CFF_Task_Pool", _CFF_Map]; */

[_taskData, nil, _taskUnit] call BCE_fnc_CFF_Mission_Set_Values;
[["MSN",_taskData] joinString ":", nil ,_taskUnit] call BCE_fnc_set_CFF_Value;

//- Refresh CFF Mission list
[nil,"Task_CFF_List",-1] call BCE_fnc_ATAK_ChangeTool;