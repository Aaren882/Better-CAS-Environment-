/*
  NAME : BCE_fnc_getCurUnit_CFF

	PARAMS :
		_taskUnit<OBJECT> : The battery unit
		_MSN_Key<STRING> : The key for the mission

	Return :
		CFF_MSN : [ 
			"_random_POS",
			"_lbAmmo",
			"_setCount",
			"_radius",
			"_fuzeData",
			"_Control_Function_Name",
			"_Sheaf_Info",
			["_MSN_RECUR", [0,60]] //- #NOTE - [ROUNDS, Interval]
		]
		==> #LINK - functions/CAS_Event/Call_for_Fire/fn_get_CFF_Value.sqf
*/

params [
	["_taskUnit",objNull,[objNull]],
	[
		"_MSN_Key",
		["CFF_MSN","",_taskUnit] call BCE_fnc_get_CFF_Value,
		[""]
	]
];

//- Check _taskUnit exist
if (isNull _taskUnit) then {
	_taskUnit = [ 
		nil, 
		"GND" call BCE_fnc_get_TaskCateIndex 
	] call BCE_fnc_get_TaskCurUnit;
};

private _MSN_NAME = ["CFF_MSN",_MSN_Key] joinString ":";
[_MSN_NAME, [], _taskUnit] call BCE_fnc_get_CFF_Value;