params ["_group",["_interfaceInit",false],"_isDialog","_settings"];

private _taskUnit = [nil,"CFF" call BCE_fnc_get_TaskIndex] call BCE_fnc_get_TaskCurUnit;

//- Check _taskUnit exist
if (isnull _taskUnit) exitWith {
  
};
//- Get TaskUnit group infos
  private _taskUnit_Grp = group _taskUnit;
  private _CFF_Map = _taskUnit_Grp getVariable ["BCE_CFF_Task_Pool", createHashMap];

//- #NOTE - Setup Adjustment Control Interface
  private _AdjustGrp = _group controlsGroupCtrl 5400;
  private _AdjustBnt = _AdjustGrp controlsGroupCtrl 5100;
  private _AdjustMeter = _AdjustGrp controlsGroupCtrl 5004;

  _AdjustBnt call BCE_fnc_UpdateFireAdjust; //- Refresh UI Values

  private _MeterValue = ["Meter",1] call BCE_fnc_get_FireAdjustValues;
  _AdjustMeter ctrlSetText format ["<-- %1 m -->", _MeterValue * 10];

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

_Wpn_setup_IE params ["_lbAmmo_IE","_lbFuse_IE","_fireUnitSel_IE","_setCount_IE","_radius_IE","_fuzeVal_IE"];


private _PageTitle = _group controlsGroupCtrl 3600;
_PageTitle ctrlSetText ("Mission #" + _taskData);

private _MTO_dsp = "New_Task_MTO_Display" call BCE_fnc_getTaskSingleComponent;
private _default_FUZE = [configFile >> "CfgMagazines" >> _lbAmmo_IE, "displayNameMFDFormat", "NO SPEC"] call BIS_fnc_returnConfigEntry;

_MTO_dsp ctrlSetStructuredText parseText format [
  "<t color='#FFBC05' size='0.9'>%1</t><br/>""%2 x%3, %4 in Effect, %5 ROUNDS, TARGET NUMBER %6""",
  "Message to Observer :",
  str groupId _taskUnit_Grp,
  _fireUnitSel_IE,
  [_lbFuse_IE,_default_FUZE] select (_lbFuse_IE == ""),
  _setCount_IE,
  _taskData
];