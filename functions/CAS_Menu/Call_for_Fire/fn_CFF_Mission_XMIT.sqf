/*
  NAME : BCE_fnc_CFF_Mission_XMIT
  
  On CFF XMIT pressed #LINK - functions/cTab/functions/ATAK/Fire_Mission/Call_for_Fire/fn_ATAK_CFF_TaskList_Init.sqf
*/
params ["_control",["_transmitType",""]];

//- Check Task Unit 
private _taskUnit = [nil,"CFF" call BCE_fnc_get_TaskIndex] call BCE_fnc_get_TaskCurUnit;
if (isnull _taskUnit) exitWith {};

//- Check Custom Button (Current Selected TaskID)
  private _tagGrp = ctrlParentControlsGroup _control;
  private _taskData = _tagGrp getVariable ["CFF_Task_Mission",""];

private _customData = if (_taskData != "") then {
  switch (toUpperANSI _transmitType) do { //- Check XMIT type
    //- Start Mission
    case "START": {_taskData};

    //- Open Adjust Menu
    case "ADJUST_MENU": {
      private _value = ["CFF_Mission",[],true] call BCE_fnc_get_TaskCurSetup;
      _value set [0,_taskData];
      ["CFF_Mission",_value] call BCE_fnc_set_TaskCurSetup;

      //- #TODO - Add CBA localEvent
      [nil,"Task_CFF_Action",-1] call BCE_fnc_ATAK_ChangeTool;
      
      nil //- Return
    };
  };
} else {
  //- Submit & SUB/EXEC Mission
  private _typeCtrl = "New_Task_Submit_CFF_Mission_Type" call BCE_fnc_getTaskSingleComponent;
  lbCurSel _typeCtrl //- Return
};

//- #NOTE - Exit if there's no "_customData"
if (isNil{_customData}) exitWith {};

//- Send Data
  [
    _taskUnit,
    nil,
    nil,
    _customData
  ] call BCE_fnc_SendTaskData;