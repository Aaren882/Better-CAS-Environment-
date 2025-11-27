/*
	NAME : BCE_fnc_getPos_Sheaf

	PARAMS : 
		_taskUnit<OBJECT> : The battery unit

	Return : Array of AGL POS (the positions of the rounds will hit)
		- [[x,y,z],[x,y,z]...]
*/

params [["_taskUnit",objNull,[objNull]]];

if (isNull _taskUnit) then {
	_taskUnit = [
		nil, 
		"GND" call BCE_fnc_get_TaskCateIndex 
	] call BCE_fnc_get_TaskCurUnit;
};

(_taskUnit call BCE_fnc_getCurUnit_CFF) params [
	"_random_POS",
	"",
	"",
	"",
	"",
	"",
	"_Sheaf_Info"
];

//- Return AGL POS
	_Sheaf_Info apply {_random_POS getPos _x};
