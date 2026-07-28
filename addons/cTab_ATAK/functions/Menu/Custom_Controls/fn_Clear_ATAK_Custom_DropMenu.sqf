/*
  NAME : BCE_fnc_Clear_ATAK_Custom_DropMenu

  Clear Custom Drop Menu for cTab
  
  param :
    "_listGroup"  : controlsGroupCtrl of the Group
    "_condition"  : <CODE> Filter foreach controls in _listGroup
      
*/

params [
  "_listGroup",
  ["_condition",{true}]
];

{
  if (call _condition) then {ctrlDelete _x};
} count (allControls _listGroup);
