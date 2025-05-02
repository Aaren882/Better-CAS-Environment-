params ["_group",["_interfaceInit",false],"_isDialog","_settings"];

//- #NOTE - Setup Adjustment Control Interface
  private _AdjustGrp = _group controlsGroupCtrl 5400;
  private _AdjustBnt = _AdjustGrp controlsGroupCtrl 5100;
  private _AdjustMeter = _AdjustGrp controlsGroupCtrl 5004;

  _AdjustBnt call BCE_fnc_UpdateFireAdjust; //- Refresh UI Values

  private _MeterValue = ["Meter",1] call BCE_fnc_get_FireAdjustValues;
  _AdjustMeter ctrlSetText format ["<-- %1 m -->", _MeterValue * 10];


private _taskUnit = [nil,"CFF" call BCE_fnc_get_TaskIndex] call BCE_fnc_get_TaskCurUnit;
private _taskUnit_Grp = group _taskUnit;

private _CFF_Map = _taskUnit_Grp getVariable ["BCE_CFF_Task_Pool", createHashMap];

//- Get current CFF mission infos
private _value = ["CFF_Mission",[]] call BCE_fnc_get_TaskCurSetup;
_value params [["_taskData",""]];

(_CFF_Map get _taskData) params [
  "_MSN_Type",
  "_TG_Grid",
  "_requester",
  "_MSN_infos",
  ["_MSN_State",0]
];

_MSN_infos params [
  "_Wpn_setup_IE",
  "_Wpn_setup_IA",
  "_random_POS"
];

systemChat str ["ACTION : ",_taskData,time];
