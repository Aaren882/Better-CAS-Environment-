#include "script_component.hpp"

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
  ["Exception : Invalid Input Parameter !! - No ""_curLine"" input."] call BIS_fnc_error;
	ERROR("""fnc_getTaskComponents"" Exception : Invalid Input Parameter !! - No ""_curLine"" input.");
  
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
  private _build_Components = localNamespace getVariable [
    "BCE_Mission_Build_Components",
    createHashMap
  ];

//- Get the Desire Line
  private _build_Component = (_build_Components getOrDefault [_varName, [[], configNull]]);
	_build_Component params ["_Components", "_taskCfg"];

//- #SECTION - Error Index out of the range
  if ((count _Components) - 1 < _curLine) exitWith {
		["Exception : ""_varName"" = ""%1"" index out of the range ""_curLine"" = %2",_varName,_curLine] call BIS_fnc_error;
		ERROR_2("""fnc_getTaskComponents"" Exception : ""_varName"" = ""%1"" index out of the range ""_curLine"" = %2",_varName,_curLine);

    [[],""]
  };

//- Get Ctrl Component and Description

	//- Get the Ctrls
  private _compo_VarName = _Components # _curLine;
  private _compo = localNamespace getVariable [_compo_VarName,[]];

	//- Get Description
	private _build_Desc = [_taskCfg, "Descriptions", []] call BIS_fnc_returnConfigEntry;
	private _description = _build_Desc param [_curLine, ""];

	TRACE_2("fnc_getTaskComponents (From Component)",_compo_VarName,_compo);

//- Return
  [
    _compo apply {
      _x call BCE_fnc_getTaskSingleComponent
    },
    _description
  ]
