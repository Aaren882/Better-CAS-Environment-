/*
  NAME : BCE_fnc_CFF_Mission_CheckActive
  
  Description: Check if the mission is active

	params ["_taskID"]
	
	_taskID   : Current Mission ID

	<BOOL>
*/
params ["_taskID"];

private _group  = _taskID call BCE_fnc_CFF_Mission_Get_Group;

private _findIndex = (_group call BCE_fnc_getGroupVehicles) findIf {
	//- #NOTE - current unit CFF Mission
	private _curMSN = ["CFF_MSN", "", _x] call BCE_fnc_get_CFF_Value;
	private _state = ["CFF_STATE", false, _x] call BCE_fnc_get_CFF_Value;
	
	_curMSN == _taskID && 	//- Same ID
	_state									//- Check permission state					
};

_findIndex > -1