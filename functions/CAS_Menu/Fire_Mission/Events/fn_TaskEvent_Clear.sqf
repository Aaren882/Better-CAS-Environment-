/*
  Use for triggering Clear Task/Mission Variable
  # LINK .\fn_getTaskProps.sqf
  
  Remove Current TaskVar

  params :
    "_varName" : Default is 
*/

params [
  "_group",
  "_curLine"
];

// _TaskSel = [];
// if (_varName == "") then {
//   _TaskSel = [];
// };

_Veh_Changed = false;
_isOverwrite = false;
_IDC_offset = 17000;
_shownCtrls = [_group,_curLine,1,false,true] call BCE_fnc_Show_CurTaskCtrls;

([] call BCE_fnc_getDisplayTaskProps) params ["","","_events"];

//- Call Clear Function
call (uiNamespace getVariable [(_events get "Clear"),{}]);