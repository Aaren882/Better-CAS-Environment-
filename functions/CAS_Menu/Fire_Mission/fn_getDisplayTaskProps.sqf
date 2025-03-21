/*
  NAME : BCE_fnc_getDisplayTaskProps
  
  Get Mission/Task from "BCE_Mission_Property"
  # LINK .\fn_getTaskProps.sqf

  Params : 
    "_display" :  Display object for desire custom setup
    "_curType" :  Index Number (0,1,2...)
    "_cateSel" :  Index Number (0,1,2...)
  
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

//- Get Current Display Via "BCE_Holder"
if (isnull _display) then {
  private _BCE_Holder = ["BCE_Holder"] call BCE_fnc_getTaskSingleComponent;
  _display = ctrlParent _BCE_Holder;
};

if (isnull _display) exitWith {
  ["Cannot find in ""BCE_Holder"" display. Unable to get display properties due to null ""_display"""] call BIS_fnc_error;
  []; //- Return Value
};
/*
  [
    "Category Name" (e.g. AIR, GND)

    #NOTE - ["Task Type" , "Task Setups"] ("UI Controls", "Description", "Variable")
    [
      "9Line", "AIR_9_LINE"
    ]
  ]
*/
private _BCE_Holder = _display getVariable ["BCE_onLoad_BCE_Holder", createHashMap];

// ex. [["AIR",["9Line","5Line"]],["GND",["CFF"]]] (ARRAY)
private _categories = localNamespace getVariable ["BCE_Mission_Cate", []];

if (_categories findIf {true} < 0) then {
  //- Arrange According (For Task Items)
  private _missionCfg = configFile >> "BCE_Mission_Default";

  _categories = ("true" configClasses _missionCfg) apply {
    private _tasks = configProperties [_x] apply {toUpperANSI configName _x};
    [toUpperANSI configName _x, _tasks]
  };
  localNamespace setVariable ["BCE_Mission_Cate", _categories]; //- Save Categories
  _categories 
};

private _cate = _categories # _cateSel;
private _taskType = (_BCE_Holder get (_cate # 0)) get (_cate # 1 # _curType);

_taskType call BCE_fnc_getTaskProps;

// [["CFF","CFF"],["5Line","AIR_5_LINE_ATAK"],["9Line","AIR_9_LINE_ATAK"]]

/* [
  ConfigName, [
    "Variable Name",     : Default is Class name
    "Default Value",     : For Variable Editting
    "Events (HashMap)"   : Functions
    "Map Info (VarName)" : Map Info Display
    "displayName"        : - Less use, I think
  ]
] */
// [["GND",[["BCE_CFF_Var",[["NA",0],["NA","",[],[0,0],""],["NA","111222"],["NA","--",""],["NA",-1,[]]],[["Opened","BCE_fnc_DblClick5line"],["Enter","BCE_fnc_DataReceive5line"],["Clear","BCE_fnc_clearTask5line"]],[],"Call For Fire"]]],["AIR",[["BCE_CAS_9Line_Var",[["NA",0],["NA","",[],[0,0]],["NA",180],["NA",200],["NA",15],["NA","--"],["NA","",[],[0,0],[]],["NA","1111"],["NA","",[],[0,0],""],["NA",0,[],<null>,<null>],["NA",-1,[]]],[["Opened","BCE_fnc_DblClick9line"],["Enter","BCE_fnc_DataReceive9line"],["Clear","BCE_fnc_clearTask9line"]],["","IP_BP_Point","","","","","Air_TGT_Point","","FRD_Point"],"9 Line"],["BCE_CAS_9Line_Var",[["NA",0],["NA","",[],[0,0]],["NA",180],["NA",200],["NA",15],["NA","--"],["NA","",[],[0,0],[]],["NA","1111"],["NA","",[],[0,0],""],["NA",0,[],<null>,<null>],["NA",-1,[]]],[["Opened","BCE_fnc_DblClick9line"],["Enter","BCE_fnc_DataReceive9line"],["Clear","BCE_fnc_clearTask9line"]],["","IP_BP_Point","","","","","Air_TGT_Point","","FRD_Point"],"9 Line"],["BCE_CAS_5Line_Var",[["NA",0],["NA","",[],[0,0],""],["NA","111222"],["NA","--",""],["NA",-1,[]]],[["Opened","BCE_fnc_DblClick5line"],["Enter","BCE_fnc_DataReceive5line"],["Clear","BCE_fnc_clearTask5line"]],["","FRD_Point","Air_TGT_Point"],"5 Line"],["BCE_CAS_5Line_Var",[["NA",0],["NA","",[],[0,0],""],["NA","111222"],["NA","--",""],["NA",-1,[]]],[["Opened","BCE_fnc_DblClick5line"],["Enter","BCE_fnc_DataReceive5line"],["Clear","BCE_fnc_clearTask5line"]],["","FRD_Point","Air_TGT_Point"],"5 Line"]]]]