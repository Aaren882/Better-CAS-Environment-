/*
  NAME : BCE_fnc_CFF_Mission_RAT_2_ADD
  
  it will add the FIRE-MSN back to the Mission list of the current _taskUnit's group
*/
params ["_taskID"];

//- Unit
private _taskUnit = [nil,"GND" call BCE_fnc_get_TaskCateIndex] call BCE_fnc_get_TaskCurUnit;

//- #NOTE - Add mission
	private _MSN_Info = _taskID call BCE_fnc_CFF_Mission_Get_RAT_Values;
	[_taskUnit, [_taskID, _MSN_Info, _taskUnit]] call BCE_fnc_Send_MSN_CFF;

//- #TODO - Check if the unit has the required weapon & ordnance
//- Maybe check the each unit className from _taskUnit's group
	/* private _hasWeapon = false;
	private _weapon = "";
	{
		_x params ["_weaponName", "_magazines", "_muzzles", "_optics", "_accessories"];
		if (_weaponName in (weapons _taskUnit)) exitWith {
			_hasWeapon = true;
			_weapon = _weaponName;
		};
	} forEach (_MSN_Info # 3);

	if !(_hasWeapon) exitWith {
		[
			FormationLeader _taskUnit,
			format ["Unit %1 does not have the required weapon %2 to perform this mission.", name _taskUnit, _weapon],
			"CFF_ADD_FROM_RAT_NO_WEAPON"
		] call BCE_fnc_Send_Task_RadioMsg;
		false
	}; */
	

//- Send Msg
[
  FormationLeader _taskUnit,
  "Fire Mission Added.",
  "CFF_ADD_FROM_RAT"
] call BCE_fnc_Send_Task_RadioMsg;