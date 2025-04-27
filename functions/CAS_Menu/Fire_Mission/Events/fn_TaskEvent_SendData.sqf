/*
  NAME : BCE_fnc_TaskEvent_SendData

  On Task/Mission Task being Sent

  PARAMS :
    "_taskUnit"	    - Data will be sent to this Unit
    "_cateName"	    - Task Cate Name ("AIR", "CFF")
    "_taskType"		  - Index of the "Task Type"
    "_customInfos"	- Custom Infos can be anything (OPTIONAL)

  Return : Anything (Even nothing)
*/

params [
  ["_taskUnit",objNull],
  ["_cateName",""],
  ["_taskType",-1],
  "_customInfos"
];

//- if _taskUnit isn't selected
if (
  isNull _taskUnit ||
  _cateName == "" ||
  _taskType < 0
) exitWith {
  private _error = call {
    if (isNull _taskUnit) exitWith {
      "No ""taskUnit"" is selected !!"
    };
    if (_cateName == "") exitWith {
      "No ""Task Category"" is found !!"
    };
    if (_taskType < 0) exitWith {
      "No ""Task Type"" is found !!"
    };
  };

  //- Error Message
  [
    _error + 
    " --- Check ""BCE_TaskBuilding_SendData"" Event has correct input."
  ] call BIS_fnc_error;
  
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
  privateAll;
  Import [
    "_events",
    "_taskUnit",
    "_cateName",
    "_taskType",
    "_taskVar",
    "_customInfos"
  ];
  private _data = [
    _taskUnit,
    _cateName,
    _taskType,
    _taskVar,
    _customInfos
  ] call (uiNamespace getVariable [(_events get "SendData"),{}]);

  private _return = ["BCE_TaskBuilding_DataSent", [_taskUnit,_data]] call CBA_fnc_localEvent;

//- Return
_return