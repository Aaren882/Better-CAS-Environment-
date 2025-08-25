/*
  NAME : BCE_fnc_CFF_Mission_STOP
  
  Stop Call For Fire Mission

	params ["_taskID",["_remove",false]]
	
	_taskID   : Current Mission ID
	_remove 	: Remove the current unit mission data (CFF_MSN, FIRE_EH, etc)
*/
params ["_taskID",["_remove",false]];

//- Get all vehicles under this "_taskID"
private _vehicles = _taskID call BCE_fnc_CFF_Mission_Get_Group_Units;

{
	private _taskUnit = _x;

	//- terminate Unit's "fn_do_Aim_CFF.sqf" + Clear "chargeInfo"
  terminate (["CFF_Action",scriptNull,_taskUnit] call BCE_fnc_get_CFF_Value);
  [["CFF_Action","CFF_STATE"],nil,_taskUnit] call BCE_fnc_set_CFF_Value;
	
	//- Remove the mission EOM
	if (_remove) then {
		_taskUnit call BCE_fnc_UnstuckUnit;
		_taskUnit removeEventHandler ["Fired",["MSN_FIRE_EH", -1, _taskUnit] call BCE_fnc_get_CFF_Value];
		_taskUnit setVariable ["#CFF_MSN_Data", nil];
	};
} forEach _vehicles;

nil