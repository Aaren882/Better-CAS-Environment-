/*
  NAME : BCE_fnc_getTaskSingleComponent

  Get the Single Task/Mission Building Control

  _input_Name : Control Name

  RETURN : 
    UI Control
*/
params ["_input_Name"];

private _register = localNamespace getVariable ["#BCE_TASK_REGISTER",createHashMap];

_register getOrDefault [_input_Name,controlNull];