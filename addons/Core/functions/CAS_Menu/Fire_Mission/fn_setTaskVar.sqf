/*
  NAME : BCE_fnc_setTaskVar
  
  set Mission/Task for "BCE_Mission_Property"
  # LINK .\fn_getTaskProps.sqf

  Params : 
    "_TaskSel" : ARRAY [0,0] (Air_9_Line) | [0,1] (Air_5_Line)
  
  RETURN : [
    "Variable Values" : After Editting
  ]
*/
params [
  ["_TaskSel",[]],
  "_curLine",
  "_value"
];

_TaskSel params [
  ["_curType", [] call BCE_fnc_get_TaskCurType],
  ["_cateSel", ["Cate"] call BCE_fnc_get_TaskCurSetup],
  ["_display", displayNull]
];

//- Getting Values
  private _taskVar = ([_curType, _cateSel, _display] call BCE_fnc_getTaskVar) # 0;
  private _props = [_display, _curType, _cateSel] call BCE_fnc_getDisplayTaskProps;
  _props params ["_varName"];

//- !! Error Return !! -//
  if (isNil{_curLine} || isNil{_value}) exitWith {
    [
      "Incurrect Input !! - Unable to edit ""%1"" Variable : Cause By ""%2""",
      _varName,
      ["_curLine", "_value"] select isNil{_value}
    ] call BIS_fnc_error;
    
    //- Still Return 
      _taskVar
  };

//- Start EDITTING
  _taskVar set [_curLine, _value];
  uiNamespace setVariable [_varName, _taskVar];

_taskVar
