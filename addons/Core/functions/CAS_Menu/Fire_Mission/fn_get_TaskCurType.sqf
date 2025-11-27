/*
  NAME : BCE_fnc_get_TaskCurType

  Get Current TaskType

  Params :
    Category Index Number (0,1,2...)

  Return 
    Index Number of the Category (0,1,2...)
*/

params [
  ["_curCate", ["Cate", 0] call BCE_fnc_get_TaskCurSetup]
];

private _typeSetup = ["Type", []] call BCE_fnc_get_TaskCurSetup;

_typeSetup param [_curCate, 0];
