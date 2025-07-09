/*
  NAME : BCE_fnc_CFF_Mission_EOM
  
  On CFF "End of Mission" pressed
*/
params ["_control"];

//- Remove the Hash Key
private _tagGrp = ctrlParentControlsGroup _control;
private _taskData = _tagGrp getVariable ["CFF_Task_Mission",""];

private _taskUnit = [nil,"GND" call BCE_fnc_get_TaskCateIndex] call BCE_fnc_get_TaskCurUnit;

//- Remove Task From Unit
  //- #NOTE - Remove mission
    [_taskData, nil, _taskUnit] call BCE_fnc_CFF_Mission_Set_Values;
  _taskUnit removeEventHandler ["Fired", ["MSN_FIRE_EH", -1, _taskUnit] call BCE_fnc_get_CFF_Value];
  terminate (["CFF_Action",scriptNull,_taskUnit] call BCE_fnc_get_CFF_Value);
  [
    [
      "CFF_MSN",
      "MSN_PROG",
      "MSN_FIRE_EH",
      "chargeInfo",
      "CFF_Action",
      ["CFF_MSN", _taskData] joinString ":"
    ],nil,_taskUnit
  ] call BCE_fnc_set_CFF_Value;
  _taskUnit call BCE_fnc_UnstuckUnit;
//- Send Msg
  if (isFormationLeader _taskUnit) then {
    [
      _taskUnit,
      localize "STR_BCE_CFF_MSG_EOM",
      "CFF_EOM"
    ] call BCE_fnc_Send_Task_RadioMsg;
  };

//- Refresh CFF Mission list
[nil,"Task_CFF_List",-1] call BCE_fnc_ATAK_ChangeTool;