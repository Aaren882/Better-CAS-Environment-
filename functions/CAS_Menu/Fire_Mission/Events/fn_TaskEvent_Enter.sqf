/*
  NAME : BCE_fnc_TaskEvent_Enter

  On Task/Mission Building Load OR Refresh
*/

params ["_curLine"];

([] call BCE_fnc_getDisplayTaskProps) params ["_varName","_default","_events"];
([] call BCE_fnc_getTaskVar) params ["_taskVar"];

(_curLine call BCE_fnc_getTaskComponents) params ["_shownCtrls"];

private _isOverwrite = false;

//- On Empty Returns
  if (
    (_shownCtrls findIf {true} < 0)
  ) exitWith {
    ["No Task Infos are found - Make sure ""Vaild _curLine"" and ""Controls are created correctly"""] call BIS_fnc_error;
  };

//- Fires Function
  call (uiNamespace getVariable [(_events get "Enter"),{}]);
  
//- Store TaskVar
  // uiNamespace setVariable [_varName, _taskVar];
  [
    [],
    _curLine,
    _taskVar # _curLine
  ] call BCE_fnc_setTaskVar;