/*
  NAME : BCE_fnc_CFF_Mission_XMIT
  
  On CFF XMIT pressed #LINK - functions/cTab/functions/ATAK/Fire_Mission/Call_for_Fire/fn_ATAK_CFF_TaskList_Init.sqf
*/
params ["_control"];

//- Check Custom Button
private _tagGrp = ctrlParentControlsGroup _control;
private _taskData = _tagGrp getVariable ["CFF_Task_Mission",""];

private _customData = if (_taskData == "") then {
  private _typeCtrl = "New_Task_Submit_CFF_Mission_Type" call BCE_fnc_getTaskSingleComponent;
  lbCurSel _typeCtrl

  //- XMIT Type
  /* private _customInfos = switch (_curSel) do {
    //- FIRE FOR EFFECT (if no _curSel is found)
    case -1: {

    };
    //- SUBMIT
    case 0: {

    };
    //- SUB & EXEC
    case 1: { };
    //- DRAFT
    case 2: { };
  }; */
} else {
  _taskData
};


//- Send Data
  [
    nil,
    nil,
    nil,
    _customData
  ] call BCE_fnc_SendTaskData;