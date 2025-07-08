/*
  NAME : BCE_fnc_TaskEvent_Enter

  On Task/Mission Building Value manually Updated
*/

params ["_curLine"];

([] call BCE_fnc_getDisplayTaskProps) params ["_varName","","_events"];
([] call BCE_fnc_getTaskVar) params ["_taskVar"];

([_curLine, _varName] call BCE_fnc_getTaskComponents) params ["_shownCtrls"];

//- On Empty Returns
  if (
    (_shownCtrls findIf {true} < 0)
  ) exitWith {
    ["No Task Infos are found - Make sure ""Vaild _curLine"" and ""Controls are created correctly"""] call BIS_fnc_error;
  };

//- Fire Function
  privateAll;
  Import [
    "_events",
    "_taskVar",
    "_curLine",
    "_shownCtrls"
  ];
  private _isOverwrite = false;
  private _taskUnit = [] call BCE_fnc_get_TaskCurUnit;
  [
    _taskUnit,
    _taskVar,
    _curLine,
    _shownCtrls
  ] call (uiNamespace getVariable [(_events get "Enter"),{}]);

//- Store TaskVar
  [
    [],
    _curLine,
    _taskVar # _curLine
  ] call BCE_fnc_setTaskVar;