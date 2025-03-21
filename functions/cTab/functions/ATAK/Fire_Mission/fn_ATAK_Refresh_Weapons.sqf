params ["_TaskList"];
private ["_curType","_curLine","_shownCtrls"];

(["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings) params ["","_shown",""];

if !(_shown) exitwith {};

_curType = []  call BCE_fnc_get_TaskCurType;
_taskVar = ([] call BCE_fnc_getTaskVar) # 0;

_curLine = 0;
["BCE_TaskBuilding_Opened", [_curLine]] call CBA_fnc_localEvent;

/* _shownCtrls = [_TaskList,_curLine,1,false,true] call BCE_fnc_Show_CurTaskCtrls;

private _fnc = ["BCE_fnc_DblClick9line", "BCE_fnc_DblClick5line"] # _curType;
call (uiNamespace getVariable _fnc); */