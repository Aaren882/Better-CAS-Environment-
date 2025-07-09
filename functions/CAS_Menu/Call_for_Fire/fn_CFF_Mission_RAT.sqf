/*
  NAME : BCE_fnc_CFF_Mission_RAT
  
  On CFF "Record as Target" pressed
*/
params ["_control"];

//- Remove the Hash Key
private _tagGrp = ctrlParentControlsGroup _control;
private _taskData = _tagGrp getVariable ["CFF_Task_Mission",""];

private _taskUnit = [nil,"GND" call BCE_fnc_get_TaskCateIndex] call BCE_fnc_get_TaskCurUnit;

private _RAT_val = _taskData call BCE_fnc_CFF_Mission_Set_RAT_Values;


//- Send Msg
  if (isFormationLeader _taskUnit) then {
    if (_RAT_val findIf {true} < 0) exitWith {
      [
        _taskUnit,
        localize "STR_BCE_CFF_MSG_RAT_FAIL",
        "CFF_RAT_FAIL"
      ] call BCE_fnc_Send_Task_RadioMsg;
    };
    [
      _taskUnit,
      localize "STR_BCE_CFF_MSG_RAT",
      "CFF_RAT"
    ] call BCE_fnc_Send_Task_RadioMsg;
  };

//- Refresh CFF Mission list
// [nil,"Task_CFF_List",-1] call BCE_fnc_ATAK_ChangeTool;