/*
  NAME : BCE_fnc_FuzeTrigger
*/
params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

private _fuzeData = _unit getVariable ["#NextFuze",[]];
_fuzeData params ["_fuzeType","_fuzeValue"];
private _Cfg = configfile >> "Additional_Fuze" >> _fuzeType;

private _conditionName = [_Cfg ,"condition", "#EMPTY"] call BIS_fnc_returnConfigEntry;
private _condition = uiNamespace getVariable _conditionName;
_unit setVariable ["#NextFuze",nil]; //- Clean UP

//- Catch Error
  if (isNil {_condition}) exitWith {
    if (_conditionName != "#EMPTY") then {
      ["Function ""%1"" Doesn't Exist !!",_conditionName] call BIS_fnc_error;
    };
  };

//- Detection function
  [{
    params ["_condition","_fuzeValue","_projectile"];

    [_fuzeValue,_projectile] call _condition;
  }, {
    triggerAmmo (_this # 2);
  }, [_condition,_fuzeValue,_projectile]] call CBA_fnc_waitUntilAndExecute;