params ["_control","_MenuGroup","_settings"];

//- Execute Fire mission
//- #LINK - functions/CAS_Menu/Call_for_Fire/fn_CFF_Mission_XMIT.sqf

//- Get current CFF mission infos
  private _curMSN = ["CFF_Mission",[]] call BCE_fnc_get_TaskCurSetup;
  _curMSN params [["_taskData",""]];

//- #NOTE - Exit if there's no "_taskData"
if (isNil{_taskData}) exitWith {};

//- Send Data
  [
    _taskUnit,
    nil,
    _taskData
  ] call BCE_fnc_SendTaskData;