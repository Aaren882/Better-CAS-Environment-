/*
  NAME : BCE_fnc_getDisplayTaskProps
  
  Get Mission/Task from "BCE_Mission_Property"
  # LINK .\fn_getTaskProps.sqf

  Params : 
    "_display" :  Display object for desire custom setup
    "_curType" :  Index Number (0,1,2...)
    "_cateSel" :  Index Number (0,1,2...)
  
  #NOTE - via BCE_fnc_getTaskProps
  RETURN : [
    "Variable Name"      : Default is Class name
    "Default Value"      : For Variable Editting
    "Events (HashMap)"   : Functions
    "displayName"        : just displayName
  ]
*/

params [
  ["_display", displayNull],
  ["_curType", [] call BCE_fnc_get_TaskCurSetup],
  ["_cateSel", ["Cate"] call BCE_fnc_get_TaskCurSetup]
];

private _taskType = _this call BCE_fnc_get_BCE_TaskClass;

_taskType call BCE_fnc_getTaskProps;