/*
  NAME : BCE_fnc_TaskEvent_Element_SelChanged

  On Task/Mission Building Component editted e.g. "Mark Method"
*/

params ["_curLine","_selectedIndex"];

([] call BCE_fnc_getDisplayTaskProps) params ["","","_events"];
([] call BCE_fnc_getTaskVar) params ["_taskVar"];

(_curLine call BCE_fnc_getTaskComponents) params ["_shownCtrls"];

//- On Empty Returns
  if (
    (_shownCtrls findIf {true} < 0)
  ) exitWith {
    ["No Task Infos are found - Make sure ""Vaild _curLine"" and ""Controls are created correctly"""] call BIS_fnc_error;
  };

private _function = uiNamespace getVariable (_events get "Element_SelChanged");

//- No function exist
  if (isNil{_function}) exitWith {
    ["No function exist"] call BIS_fnc_error;
  };

privateAll;
Import [
  "_function",
  "_shownCtrls",
  "_curLine",
  "_selectedIndex",
  "_taskVar"
];

//- Fire Function
  [_shownCtrls,_curLine,_selectedIndex,_taskVar] call _function;
