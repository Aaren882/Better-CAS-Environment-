/*
  NAME : BCE_fnc_get_BCE_TaskCateClass

  Get Current/Desire BCE Holding task categories from display

  Params : 
    "_cateSel" :  Index Number (0,1,2...)

  Return : #LINK - Mission_Property.hpp
    "BCE_Category_ClassName" : ex. "AIR", "GND", "OTR"... (#NOTE - In uppercase)
*/

params [
  ["_cateSel", ["Cate"] call BCE_fnc_get_TaskCurSetup]
];

//-- #NOTE - _categories => ["_key","_types"]
private _categories = call BCE_fnc_get_BCE_TaskCateClasses;
private _count = count _categories - 1;

if (_count < _cateSel) then {
  ["Out of the Task Category range. ""Selected : %1"" / ""Total (Index) : %2""", _cateSel, _count] call BIS_fnc_error;
  _cateSel = _count; //- return with the last one value
};

//- Return ["_key","_types"] => _key
toUpperANSI ((_categories param [_cateSel, [""]]) # 0)
