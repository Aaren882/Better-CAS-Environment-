/*
  NAME : BCE_fnc_TaskEvent_SendData

  On Task/Mission Task being Sent

  Return : BOOL
*/

params [["_taskUnit", [] call BCE_fnc_get_TaskCurUnit]];

//- if _taskUnit isn't selected
if (isNull _taskUnit) exitWith {
  ["No ""taskUnit"" is selected !!"] call BIS_fnc_error;
  false
};

([] call BCE_fnc_getTaskVar) params ["_taskVar"];
private _props = [] call BCE_fnc_getDisplayTaskProps;

private _TaskData = _props param [5, []];
_TaskData params [
  "_TaskData_Vaild",
  "_TaskData_invaildMsg"
];

//- Vaildation
  private _vaildation = _TaskData_Vaild findIf {
    (_taskVar # _x # 0) == "NA"
  };

//- Vaildating the taskVar State
// #TODO - Custom ERROR Msg (Also CBA EH)
  if (_vaildation > -1) exitwith {
    hint _TaskData_invaildMsg;
    false
  };

private _events = _props param [2, createHashMap];

//- Fire Function
  private _data = [_taskUnit, _taskVar] call (uiNamespace getVariable [(_events get "SendData"),{}]);
  private _return = ["BCE_TaskBuilding_DataSent", [_taskUnit,_data]] call CBA_fnc_localEvent;

_return