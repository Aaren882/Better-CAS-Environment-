/*
  NAME : BCE_fnc_TaskEvent_SendData

  On Task/Mission Task being Sent

  Return : BOOL
*/

params ["_curLine"];
private _taskUnit = [] call BCE_fnc_get_TaskCurUnit;

//- if _taskUnit isn't selected
if (isNull _taskUnit) exitWith {
  ["No ""taskUnit"" is selected !!"] call BIS_fnc_error;
  false
};

([] call BCE_fnc_getTaskVar) params ["_taskVar"];
private _props = [] call BCE_fnc_getDisplayTaskProps;

private _events = _props param [2, createHashMap];
private _TaskData_Vaild = _props param [5, []];

// #define CHECK_TASK(TASK) ((TASK select 0) != "NA")
private _vaildation = {
  (_taskVar # _x # 0) != "NA"
} count _TaskData_Vaild;

//- Vaildating the taskVar State
if (
  _vaildation != count _TaskData_Vaild
) exitwith {
  hint localize "STR_BCE_Error_Task9";
  false
};

private _events = _props param [2, createHashMap];

//- Fire Function
  private _data = [_taskUnit, _taskVar] call (uiNamespace getVariable [(_events get "SendData"),{}]);
  private _return = ["BCE_TaskBuilding_DataSent", [_taskUnit,_data]] call CBA_fnc_localEvent;

_return