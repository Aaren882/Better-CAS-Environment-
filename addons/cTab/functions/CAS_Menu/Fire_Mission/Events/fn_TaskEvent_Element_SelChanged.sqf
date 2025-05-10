/*
  NAME : BCE_fnc_TaskEvent_Element_SelChanged

  On Task/Mission Building Component editted e.g. "Mark Method"
*/

params ["_curLine","_selectedIndex"];

([] call BCE_fnc_getDisplayTaskProps) params ["","","_events"];
([] call BCE_fnc_getTaskVar) params ["_taskVar"];

(_curLine call BCE_fnc_getTaskComponents) params ["_shownCtrls"];

private _isOverwrite = false;

//- On Empty Returns
  if (
    (_shownCtrls findIf {true} < 0)
  ) exitWith {
    ["No Task Infos are found - Make sure ""Vaild _curLine"" and ""Controls are created correctly"""] call BIS_fnc_error;
  };

//- Fire Function
  call (uiNamespace getVariable [(_events get "Element_SelChanged"),{}]);