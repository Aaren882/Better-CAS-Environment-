/*
  NAME : BCE_fnc_set_TaskCurUnit

  Set Current TaskUnit from current controlling unit

  Params : (will get from current setup by Default)
    _taskUnit <OBJECT> : The object will be stored
    _curType  <NUMBER> : (Optional) Index 0,1,2...
    _cateSel  <NUMBER> : (Optional) Index 0,1,2...

  Return :
    <BOOL>
*/
params ["_taskUnit","_curType","_cateSel"];

if (isNil{_taskUnit}) exitWith {false};

private _props = [displayNull, _curType, _cateSel] call BCE_fnc_getDisplayTaskProps;
_props params ["_VarName","","","","_taskUnit_Var"];

focusOn setVariable [_taskUnit_Var, _taskUnit];

//- Fire BCE_Event
  ["BCE_TaskBuilding_TaskUnitChanged", [_VarName, _taskUnit_Var, _taskUnit]] call CBA_fnc_localEvent;

true