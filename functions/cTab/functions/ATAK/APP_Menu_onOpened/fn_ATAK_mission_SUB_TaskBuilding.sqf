//- call BCE_fnc_ATAK_mission_SUB_TaskBuilding;
params ["_group",["_interfaceInit",false],"_isDialog","_settings"];

privateAll;

(["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings) params ["","_shown","_subInfos"];
_subInfos params ["_subMenu","_curLine"];

if !(_shown) exitwith {};

// _curType = [] call BCE_fnc_get_TaskCurType;
_taskVar = ([] call BCE_fnc_getTaskVar) # 0;

if (isnil {_taskVar}) exitWith {
	["Error ""_taskVar"" Variable is empty"] call BIS_fnc_error;
};

_curLine = [_curLine, (count _taskVar)-1] select (_curLine > count _taskVar);
["BCE_TaskBuilding_Opened", [_curLine]] call CBA_fnc_localEvent;