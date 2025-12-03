/*
  NAME : BCE_fnc_CFF_Mission_RAT_2_ADD
  
  it will add the FIRE-MSN back to the Mission list of the current _taskUnit's group
*/
params ["_taskID"];

//- Unit
private _taskUnit = [nil,"GND" call BCE_fnc_get_TaskCateIndex] call BCE_fnc_get_TaskCurUnit;
private _MSN_Info = _taskID call BCE_fnc_CFF_Mission_Get_RAT_Values;

_MSN_Info params ["_lbAmmo"];

private _has_Ammo = false;
//- #NOTE - Check if the unit has the required weapon & ordnance
	private _group = group _taskUnit;
	private _vehs = (units _group) apply {vehicle _x}; 
	_vehs = _vehs arrayIntersect _vehs;

	//- Vaildate Ammo Existence
	{
		private _unit = _x;
		private _allMags = magazinesAmmo _unit;

		
		{
			if (_lbAmmo == _x # 0) exitWith {_has_Ammo = true};
		} count _allMags;
		if (_has_Ammo) then {break};
	} forEach _vehs;
	_group = nil;
	_vehs = nil;

if !(_has_Ammo) exitWith {
	[
		FormationLeader _taskUnit,
		format [localize "STR_BCE_CFF_MSG_RAT2ADD_NO_AMMO", name _taskUnit, _weapon],
		"CFF_ADD_FROM_RAT_NO_AMMO"
	] call BCE_fnc_Send_Task_RadioMsg;
};

//- #NOTE - Add mission
	[
		"Send",
		[_taskID, _MSN_Info, _taskUnit],
		_taskUnit
	] call BCE_fnc_Send_MSN_CFF;

	[
		FormationLeader _taskUnit,
		localize "STR_BCE_CFF_MSG_RAT2ADD",
		"CFF_ADD_FROM_RAT"
	] call BCE_fnc_Send_Task_RadioMsg;
