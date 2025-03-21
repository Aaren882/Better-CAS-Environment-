/* 
  NAME : BCE_fnc_getTaskComponents
  
  Get Mission/Task "Building Components" from "BCE_Mission_Build_Components"
  # LINK .\fn_getTaskProps.sqf

  Params : 
    "_curLine"  :  Task Index Number (0,1,2...)
    "_varName"  :  Task variable name "BCE_CAS_9Line_Var"
  
  RETURN : [
    "IDCs",       : Selected IDC List from => #LINK - Mission_Controls.hpp
    "Description" : Selected Description
  ]
*/
params [
  "_curLine",
  ["_varName", ""],
  ["_display", displayNull]
];

if (isnil{_curLine}) exitWith {
  ["Invaild Input Parameter !! - No ""_curLine"" input."] call BIS_fnc_error;
  
  //- Return Empty
    [[], ""]
};

//- If empty _varName then get current "Task Building" Component
if (_varName == "") then {
  /* 
    [
      "Variable Name"    : Default is Class name
      "Default Value"    : For Variable Editting
      "Events (HashMap)" : Functions
      "displayName"      : Less use, I think
    ]
  */
  _varName = (_display call BCE_fnc_getDisplayTaskProps) # 0;
};

//- It's arranged by "varName" in "BCE_Mission_Property"
  private _components = localNamespace getVariable [
    "BCE_Mission_Build_Components",
    createHashMap
  ];

//- Get the Desire Line
  private _component = (_components getOrDefault [_varName,[ ["",""] ]]);

//- #SECTION - Error Index out of the range
  if ((count _component) - 1 < _curLine) exitWith {
    ["Index out of the range ""_curLine"" = %1",_curLine] call BIS_fnc_error;

    [[],""]
  };

  (_component # _curLine) params ["_compo_VarName","_desc_Sel"];


//- Get the Ctrls
  private _compo = localNamespace getVariable [_compo_VarName,[]];

//- Return
  [
    _compo apply {
      _x call BCE_fnc_getTaskSingleComponent
    },
    _desc_Sel
  ]