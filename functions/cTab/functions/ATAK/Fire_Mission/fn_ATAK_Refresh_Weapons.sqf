params ["_TaskList"];
private ["_curType","_curLine","_shownCtrls"];

(["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings) params ["","_shown",""];

if !(_shown) exitwith {};

_curType = ["Type",0] call BCE_fnc_get_TaskCurSetup;
_taskVar = (["9Line","5Line"] # _curType) call BCE_fnc_getTaskVar;

_curLine = 0;
_shownCtrls = [_TaskList,_curLine,1,false,true] call BCE_fnc_Show_CurTaskCtrls;

private _fnc = ["BCE_fnc_DblClick9line", "BCE_fnc_DblClick5line"] # _curType;
call (uiNamespace getVariable _fnc);