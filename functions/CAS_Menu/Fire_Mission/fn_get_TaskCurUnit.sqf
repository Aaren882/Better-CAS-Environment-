/*
  NAME : BCE_fnc_get_TaskCurUnit

  Get Current TaskUnit from current controlling unit

  Params : (will get from current setup by Default)
    _unit    : (Optional) 
    _curType : (Optional) 
    _cateSel : (Optional)

  Return :
    TaskUnit <OBJECT>
*/
params [["_unit",focusOn],"_curType","_cateSel"];

private _props = [displayNull, _curType, _cateSel] call BCE_fnc_getDisplayTaskProps;
// _props params ["","","","","_taskUnit_Var"]

_unit getVariable [_props # 4, objNull];