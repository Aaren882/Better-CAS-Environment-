params ["_TaskList"];
private ["_curType","_curLine","_shownCtrls"];

(["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings) params ["","_shown",""];

if !(_shown) exitwith {};

_curType = uiNameSpace getVariable ["BCE_Current_TaskType",0];
_taskVar = uiNameSpace getVariable (["BCE_CAS_9Line_Var","BCE_CAS_5Line_Var"] # _curType);

_curLine = 0;
_shownCtrls = [_TaskList,_curLine,1,false,true] call BCE_fnc_Show_CurTaskCtrls;

call ([BCE_fnc_DblClick9line, BCE_fnc_DblClick5line] # _curType);