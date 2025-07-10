/*
  NAME : BCE_fnc_CFF_Mission_Set_RAT_Values

  Description : Set values for "Record as Target"
  (IT OVERWRITES THE RECORD) !!

  Return : 
    <ARRAY> UPDATED "_curValues"
*/

params [
  "_taskID",
  ["_removeRAT",false]
];

//- Get "_MSN_Values"
private _MSN_Values = _taskID call BCE_fnc_CFF_Mission_Get_Values;

if (_MSN_Values findIf {true} < 0) exitWith {[]};
private _pool = localNamespace getVariable ["#BCE_CFF_Task_RAT_Pool", createHashMap];
  
//- #NOTE - Remove RAT
if (_removeRAT) then {
  _pool deleteAt _taskID;
} else {
  _pool set [_taskID, _MSN_Values];
};

//- #TODO - Add CBA Event trigger

localNamespace setVariable ["#BCE_CFF_Task_RAT_Pool", _pool];

_MSN_Values