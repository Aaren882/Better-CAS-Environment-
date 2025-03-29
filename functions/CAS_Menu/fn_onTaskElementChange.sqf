/* 
  NAME : BCE_fnc_HandleTaskElementChange

  Triggers on switching Task Element Changed
  e.g. 
*/

params ["_control","_selectedIndex"];

private _curLine = (ctrlParent _control) call BCE_fnc_get_TaskCurLine;

/* ([] call BCE_fnc_getTaskVar) params ["_taskVar"];
(_curLine call BCE_fnc_getTaskComponents) params ["_shownCtrls","_desc_str"];
private _remarks = (count _taskVar) - 1; */

["BCE_TaskBuilding_Element_SelChanged", [_curLine,_selectedIndex]] call CBA_fnc_localEvent;