/*
  NAME : BCE_fnc_set_TaskCurType

  Set Current TaskType

  Params :
    Category Index Number (0,1,2...)

  Return 
    Index Number of the Category (0,1,2...)
*/
params [["_lbCurSel",-1]];

if (_lbCurSel < 0) exitWith {
  ["Invaild Input ""_lbCurSel"" cannot update TaskType."] call BIS_fnc_error;
};

private _typeSetup = ["Type", []] call BCE_fnc_get_TaskCurSetup;
private _curCate = ["Cate", 0] call BCE_fnc_get_TaskCurSetup;
_typeSetup set [_curCate, _lbCurSel];

["Type", _typeSetup] call BCE_fnc_set_TaskCurSetup;
