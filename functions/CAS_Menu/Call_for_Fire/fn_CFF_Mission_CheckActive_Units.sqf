/*
  NAME : BCE_fnc_CFF_Mission_CheckActive_Units
  
  Description:
		Check if the mission is active on what vehicles and return the active units

	params ["_taskID"]
	
	_taskID   : Current Mission ID

	Return : Array of vehicles
		[<OBJECT>...]
*/
params ["_taskID"];

private _group  = _taskID call BCE_fnc_CFF_Mission_Get_Group;

(assignedVehicles _group) select {
	//- #NOTE - current unit CFF Mission
	private _curMSN = ["CFF_MSN", "", _x] call BCE_fnc_get_CFF_Value;
	private _state = ["CFF_STATE", false, _x] call BCE_fnc_get_CFF_Value;
	
	_curMSN == _taskID && 	//- Same ID
	_state									//- Check permission state					
};