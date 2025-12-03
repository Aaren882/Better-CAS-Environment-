/*
  NAME : BCE_fnc_get_BCE_TaskClass

  Get Current/Desire BCE Holding Components from display

  Params : 
    "_display" :  Display object for desire custom setup
    "_curType" :  Index Number (0,1,2...)
    "_cateSel" :  Index Number (0,1,2...)

  Return : #LINK - Mission_Property.hpp
    "BCE_Task_Type" : ex. "AIR_9_LINE", "AIR_5_LINE"...
*/

params [
  ["_display", displayNull], //- #NOTE - This can be <STRING> or <DISPLAY>
  ["_curType", [] call BCE_fnc_get_TaskCurType],
  ["_cateSel", ["Cate"] call BCE_fnc_get_TaskCurSetup]
];

//- Get Current Display Via "BCE_Holder"
if (
  _display isEqualTo displayNull ||
  _display isEqualTo ""
) then {
  _display = call BCE_fnc_get_BCE_curDisplay;
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
  private _BCE_Holder = _display call BCE_fnc_get_BCE_Holder;
  
// ex. [["AIR",["9LINE","5LINE"]],["GND",["ADJ"]]] (ARRAY)
  private _categories = call BCE_fnc_get_BCE_TaskCateClasses;

//- Get Desire Task Type
  private _cate = _categories # _cateSel;
  _cate params ["_key","_types"];

//- Check out of range
  private _count = count _types - 1;
  if (_count < _curType) then {
    [
			"Out of the ""_types"" range, ""_curType : %1"" / ""Total : %2"" | Key = ""%3""  types = ""%4""",
			_curType,
			_count,
			_key,
			_types
		] call BIS_fnc_error;
    _curType = _count;
  };

(_BCE_Holder get _key) getOrDefault [_types # _curType, ""];
