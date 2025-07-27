/*
  NAME : BCE_fnc_FuzeTrigger
*/
params ["_unit","_projectile",["_projectileParent",objNull]];

//- Check "_projectileParent" Exist
if (isNull _projectileParent) then {
	_projectileParent = _projectile;
};

private _fuzeData = _projectileParent getVariable ["#BCE_FUZE",[]];

_fuzeData params ["_fuzeType","_fuzeValue"];

private _Cfg = configfile >> "Additional_Fuze" >> _fuzeType;
private _conditionName = [_Cfg ,"condition", "#EMPTY"] call BIS_fnc_returnConfigEntry;
private _condition = uiNamespace getVariable _conditionName;


_projectileParent setVariable ["#BCE_FUZE",nil]; //- Clean UP

//- Catch Error
  if (isNil {_condition}) exitWith {
    if (_conditionName != "#EMPTY") then {
      ["Function ""%1"" Doesn't Exist !!",_conditionName] call BIS_fnc_error;
    };
  };

//- Detection function

	[_fuzeValue,_projectile,_unit,_condition] spawn {
		params ["","_projectile","","_condition"];
		
		while {alive _projectile} do {
			sleep 0.01;
			if (call _condition) then {
				triggerAmmo _projectile;
				break;
			};
		};
	};
	
  /* [
    {
      params ["","_projectile","_unit","_condition"];
      call _condition || !(alive _projectile)
    }, {
    triggerAmmo (_this # 1);
  }, [_fuzeValue,_projectile,_unit,_condition]] call CBA_fnc_waitUntilAndExecute; */