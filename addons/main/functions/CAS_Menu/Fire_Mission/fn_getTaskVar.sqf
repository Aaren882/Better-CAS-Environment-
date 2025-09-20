/* 
  NAME : BCE_fnc_getTaskVar
  
  Get Mission/Task from "BCE_Mission_Property"
  # LINK .\fn_getTaskProps.sqf

  Params : 
		_curType : Current Task Type Index Number
		_cateSel : Current Category Index Number
		_display : Display (default is displayNull)
  
  RETURN : [
    "Variable Name",   : Default is Class name
    "Default Value",   : For Variable Editting
  ]
 */
params [
  ["_curType", [] call BCE_fnc_get_TaskCurType],
  ["_cateSel", ["Cate"] call BCE_fnc_get_TaskCurSetup],
  ["_display", displayNull],
	["_withDefault",true]
];

//- Getting Values
private _props = [_display,_curType,_cateSel] call BCE_fnc_getDisplayTaskProps;
_props params [["_varName",""],["_default_Value",[]]];

private _default = [];
if (_withDefault) then {
	_default =+ _default_Value;
};

[
  uiNamespace getVariable [_varName,_default_Value],
  _default
]
