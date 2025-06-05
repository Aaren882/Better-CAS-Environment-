params ["_HDG"];
if (isnil{_HDG}) exitWith {nil};
["N", "NE", "E", "SE", "S", "SW", "W", "NW", "N"] # (([_HDG, 45] call BIS_fnc_roundDir) / 45);
