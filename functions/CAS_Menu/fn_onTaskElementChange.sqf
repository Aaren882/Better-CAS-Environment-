/* 
  NAME : BCE_fnc_onTaskElementChange

  Triggers on switching Task Element Changed
  e.g. 
*/

params [
  "_control",
  "_selectedIndex",
  "_curLine"
];

if (isnil {_curLine}) then {
  _curLine = (ctrlParent _control) call BCE_fnc_get_TaskCurLine;
};

["BCE_TaskBuilding_Element_SelChanged", [_curLine,_selectedIndex]] call CBA_fnc_localEvent;