private ["_curType","_taskVar","_pos"];

_curType = ["Type",0] call BCE_fnc_get_TaskCurSetup;
_taskVar = ((["9Line","5Line"] # _curType) call BCE_fnc_getTaskVar) # 0;
_pos = _taskVar # _this # 2;

if (isnil{_pos}) exitwith {
	["BFT",localize "STR_BCE_ATAK_No_Info_Error",5] call cTab_fnc_addNotification;
};

["cTab_Android_dlg",[["mapWorldPos",_pos]],true,true] call cTab_fnc_setSettings;