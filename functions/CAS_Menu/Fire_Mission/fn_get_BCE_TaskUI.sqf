/*
  NAME : BCE_fnc_get_BCE_TaskUI

  Params : 
    "_display" :  Display object for desire custom setup
    "_curType" :  Index Number (0,1,2...)
    "_cateSel" :  Index Number (0,1,2...)
  
  #NOTE - via BCE_fnc_getTaskProps
  RETURN : [
    "Control Group"      : UI "Control_Group" to Create
    "display Name"       : Localized displayName
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

private _cateData = [_cateSel] call BCE_fnc_get_BCE_TaskCateClass;
private _taskType = [_display,_curType,_cateSel] call BCE_fnc_get_BCE_TaskClass;

private _config = configFile >> "BCE_Mission_Property" >> _cateData >> _taskType;

//- Return
  [
    "Control_Group",
    "displayName"
  ] apply {
    [_config, _x, ""] call BIS_fnc_returnConfigEntry
  };