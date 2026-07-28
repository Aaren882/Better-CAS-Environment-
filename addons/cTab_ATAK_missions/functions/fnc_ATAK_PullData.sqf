#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_cTab_ATAK_missions_fnc_ATAK_PullData
Description:
		Focus on specific task position on ATAK map from provided task line <NUMBER>.

Parameters:
		_taskLine  - An integer representing a line index for task variable lookup.

Returns:
		<NONE>

Examples
		(begin example)
				4 call BCE_cTab_ATAK_missions_fnc_ATAK_PullData
		(end)

Author:
		Aaren
---------------------------------------------------------------------------- */

params ["_taskLine"];
TRACE_1("fnc_ATAK_PullData",_this);

private ["_curType","_taskVar","_pos"];

_curType = [] call BCE_fnc_get_TaskCurType;
_taskVar = ([] call BCE_fnc_getTaskVar) # 0;
_pos = _taskVar # _line # 2;

if (isnil{_pos}) exitwith {
	["BFT",localize "STR_BCE_ATAK_No_Info_Error",5] call cTab_fnc_addNotification;
};

//- Update map 
["cTab_Android_dlg",[["mapWorldPos",_pos]],true,true] call cTab_fnc_setSettings;
