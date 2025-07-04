/*
  NAME : BCE_fnc_FuzeTrigger
*/
params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

private _fuzeData = ["NextFuze",[],_unit] call BCE_fnc_get_CFF_Value;
_fuzeData params ["_fuzeType","_fuzeValue"];

private _Cfg = configfile >> "Additional_Fuze" >> _fuzeType;
private _conditionName = [_Cfg ,"condition", "#EMPTY"] call BIS_fnc_returnConfigEntry;
private _condition = uiNamespace getVariable _conditionName;

["NextFuze", nil, _unit] call BCE_fnc_set_CFF_Value; //- Clean UP

//- Catch Error
  if (isNil {_condition}) exitWith {
    if (_conditionName != "#EMPTY") then {
      ["Function ""%1"" Doesn't Exist !!",_conditionName] call BIS_fnc_error;
    };
  };

//- Detection function
  [
    {
      params ["","_projectile","_unit","_condition"];
      call _condition || !(alive _projectile)
    }, {
    triggerAmmo (_this # 1);
  }, [_fuzeValue,_projectile,_unit,_condition]] call CBA_fnc_waitUntilAndExecute;