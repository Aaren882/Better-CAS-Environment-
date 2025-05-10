/* 
  NAME : BCE_fnc_getTaskVar
  
  Get Mission/Task from "BCE_Mission_Property"
  # LINK .\fn_getTaskProps.sqf

  Params : 
    "_taskID" :  ConfigName
    "_cateSel" :  Index Number (0,1,2...)
  
  RETURN : [
    "Variable Name",   : Default is Class name
    "Default Value",   : For Variable Editting
  ]
 */
params [
  ["_curType", [] call BCE_fnc_get_TaskCurType],
  ["_cateSel", ["Cate"] call BCE_fnc_get_TaskCurSetup],
  ["_display", displayNull]
];

//- Getting Values
private _props = [_display,_curType,_cateSel] call BCE_fnc_getDisplayTaskProps;
_props params ["_varName","_default_Value"];
private _default =+ _default_Value;

[
  uiNamespace getVariable [_varName,_default],
  _default
]