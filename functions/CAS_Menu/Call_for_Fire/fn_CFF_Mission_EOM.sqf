/*
  NAME : BCE_fnc_CFF_Mission_EOM
  
  On CFF "End of Mission" pressed
*/
params ["_taskID"];

private _taskUnit = [nil,"GND" call BCE_fnc_get_TaskCateIndex] call BCE_fnc_get_TaskCurUnit;
private _curMSN = ["CFF_MSN","",_taskUnit] call BCE_fnc_get_CFF_Value;

//- #NOTE - Remove mission
	// [_taskID, nil, _taskUnit] call BCE_fnc_CFF_Mission_Set_Values;
	[
		"Delete",
		_taskUnit,
		[_taskID, nil, _taskUnit]
	] call BCE_fnc_Send_MSN_CFF;
	
//- Refresh CFF Mission list
	[nil,"Task_CFF_List",-1] call BCE_fnc_ATAK_ChangeTool;

//- Send Msg
  if (isFormationLeader _taskUnit) then {
    [
      _taskUnit,
      localize "STR_BCE_CFF_MSG_EOM",
      "CFF_EOM"
    ] call BCE_fnc_Send_Task_RadioMsg;
  };

//- #NOTE - Check if the current mission matches the taskID
	if (_curMSN != _taskID) exitWith {};

//- Remove Task From Unit
  _taskUnit removeEventHandler ["Fired", ["MSN_FIRE_EH", -1, _taskUnit] call BCE_fnc_get_CFF_Value];
  terminate (["CFF_Action",scriptNull,_taskUnit] call BCE_fnc_get_CFF_Value);
  [
    [
      "CFF_MSN",
      "MSN_PROG",
      "MSN_FIRE_EH",
      "chargeInfo",
      "CFF_Action",
      ["CFF_MSN", _taskID] joinString ":"
    ],nil,_taskUnit
  ] call BCE_fnc_set_CFF_Value;
  _taskUnit call BCE_fnc_UnstuckUnit;

