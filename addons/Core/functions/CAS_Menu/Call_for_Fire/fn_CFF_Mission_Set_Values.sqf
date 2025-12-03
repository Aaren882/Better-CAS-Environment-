/*
  NAME : BCE_fnc_CFF_Mission_Set_Values

  Return : 
    <ARRAY> UPDATED "_curValues"
*/

params [
  "_taskID",
  "_values",
  ["_taskUnit", [nil,"GND" call BCE_fnc_get_TaskCateIndex] call BCE_fnc_get_TaskCurUnit]
];

if (isnull _taskUnit) exitWith {};

private _group = group _taskUnit;
private _pool = localNamespace getVariable ["#BCE_CFF_Task_Pool", createHashMap];

//- Update HashMap
  private _map = _group getVariable ["BCE_CFF_Task_Pool", createHashMap];
  
if (isnil{_values}) then {
  _pool deleteAt _taskID;
  _map deleteAt _taskID;
} else {
  _pool set [_taskID, _group];
  _map set [_taskID, _values];
};

localNamespace setVariable ["#BCE_CFF_Task_Pool", _pool];
//- #TODO - Send directly instead globally
// : this will need all ends have BCE Loaded (for CBA_event to work)
_group setVariable ["BCE_CFF_Task_Pool", _map];

_values
