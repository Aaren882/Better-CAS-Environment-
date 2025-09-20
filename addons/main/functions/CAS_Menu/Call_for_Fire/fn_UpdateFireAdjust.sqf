/*
  NAME : BCE_fnc_UpdateFireAdjust

  ["_control","_vector"]

  "_control" - Button Control
  "_vector" - Input 2D Vector e.g. [0,1], [2,0]

  return : Updated 2D Vector
*/
params [["_control",controlNull],["_vector",[]]];

//- Get Current Adjust
private _current = ["CURRENT", ""] call BCE_fnc_get_FireAdjustValues;
private _curValue = [_current,[]] call BCE_fnc_get_FireAdjustValues;

private _result = switch (true) do {
	case (_current == "POLAR" || _current == "GUNLINE"): {
		//- #ANCHOR - ["Adjust": "0,0", "Meter": 1]
		_curValue params [["_adjust", "0,0"],["_multiplier", 1]];

		private _curAdjust = (_adjust splitString ",") apply {parseNumber _x};

		//- Get Multiplier (10m, 50m)
		_vector = _vector vectorMultiply _multiplier;
		private _curAdjust = _curAdjust vectorAdd _vector;

		//- Update value
		_curValue set [0, _curAdjust joinString ","];
		[_current, _curValue] call BCE_fnc_set_FireAdjustValues;

		_curAdjust
	};
	case (_current == "IMPACT"): {
		//- #ANCHOR - ["Adjust": "MIL,DIST"]
		private _curAdjust = if (count _vector == 0) then {
			_curValue
		} else {
			[_current, _vector] call BCE_fnc_set_FireAdjustValues;
			_vector
		};

		//- Split string
		/* private _HDG = parseNumber _dir;
		private _distNum = parseNumber _dist;
		
		//- check if it's Mil (=> Azimuth°)
		if (count _dir == 4) then {
			_HDG = _HDG / 6400 * 360;
		};

		private _curAdjust = [_distNum, _HDG, 0] call CBA_fnc_polar2vect;
		_curAdjust resize 2; */
		_curAdjust
	};
};

//- on "_control" Empty
if (isNull _control) exitWith {_result};

["BCE_onFireAdjusted", [
  ctrlParentControlsGroup _control,
	_current,
  _result,
  _vector isEqualTo [] //- Check is onLoad
]] call CBA_fnc_localEvent;

//- Return
_result
