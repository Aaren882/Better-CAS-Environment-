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
    "Map Info (VarName)" : Map Info Display
    "TaskUnit (VarName)" : TaskUnit variable name
  ]
*/

params [
  ["_display", displayNull],
  "_curType",
  ["_cateSel", ["Cate"] call BCE_fnc_get_TaskCurSetup]
];

if (isNil{_curType}) then {
  _curType = [_cateSel] call BCE_fnc_get_TaskCurType;
};

//- Get Current Task_Type" ex. "AIR_9_LINE", "AIR_5_LINE"...
private _taskType = [_display,_curType,_cateSel] call BCE_fnc_get_BCE_TaskClass;

_taskType call BCE_fnc_getTaskProps;