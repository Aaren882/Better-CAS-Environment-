/*
  NAME : BCE_fnc_get_BCE_TaskCateClasses

  Get BCE Holding task categories from #LINK - Mission_Property.hpp

  Return : #LINK - Mission_Property.hpp
    "BCE_Task_Category_Values" : ex. [["AIR",["9LINE","5LINE"]],["GND",["CFF"]]] (ARRAY)
*/

privateAll;

_categories = localNamespace getVariable ["BCE_Mission_Cate", []];

//- Arrange According (For Task Items)
  if (_categories findIf {true} < 0) then {
    private _missionCfg = configFile >> "BCE_Mission_Default";

    _categories = ("true" configClasses _missionCfg) apply {
      private _tasks = configProperties [_x] apply {toUpperANSI configName _x};
      [toUpperANSI configName _x, _tasks]
    };
    localNamespace setVariable ["BCE_Mission_Cate", _categories]; //- Save Categories
  };

//- Return
_categories