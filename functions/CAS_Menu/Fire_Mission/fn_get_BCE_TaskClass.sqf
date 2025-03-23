/*
  NAME : BCE_fnc_get_BCE_TaskClass

  Get BCE Holding Components from display

  Params : 
    "_display" :  Display object for desire custom setup
    "_curType" :  Index Number (0,1,2...)
    "_cateSel" :  Index Number (0,1,2...)

  Return : #LINK - Mission_Property.hpp
    "BCE_Task_Type" : ex. "AIR_9_LINE", "AIR_5_LINE"...
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
  BCE Holder Format :
  [
    "Category Name" (e.g. AIR, GND)

    #NOTE - ["Task Type" , "Task Setups"] ("UI Controls", "Description", "Variable")
    [
      "9Line", "AIR_9_LINE"
    ]
  ]
*/
  private _BCE_Holder = _display getVariable ["BCE_onLoad_BCE_Holder", createHashMap];

// ex. [["AIR",["9LINE","5LINE"]],["GND",["CFF"]]] (ARRAY)
  private _categories = localNamespace getVariable ["BCE_Mission_Cate", []];

//- Arrange According (For Task Items)
  if (_categories findIf {true} < 0) then {
    private _missionCfg = configFile >> "BCE_Mission_Default";

    _categories = ("true" configClasses _missionCfg) apply {
      private _tasks = configProperties [_x] apply {toUpperANSI configName _x};
      [toUpperANSI configName _x, _tasks]
    };
    localNamespace setVariable ["BCE_Mission_Cate", _categories]; //- Save Categories
    _categories 
  };

//- Get Desire Task Type
  private _cate = _categories # _cateSel;
  _cate params ["_key","_types"];

(_BCE_Holder get _key) getOrDefault [_types # _curType, ""];