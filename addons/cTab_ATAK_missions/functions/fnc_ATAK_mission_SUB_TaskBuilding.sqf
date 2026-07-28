#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_cTab_ATAK_missions_fnc_ATAK_mission_SUB_TaskBuilding
Description:
		Handles the building and display logic for mission sub-tasks within the cTab interface.

Parameters:
		_group         - The UI parent group control. <CONTROL>
		_interfaceInit - Boolean flag for interface initialization. <BOOLEAN>
		_isDialog      - Boolean flag indicating if a dialog is active. <BOOLEAN>
		_settings      - An object containing panel settings, including the target page and component map.

Returns:
		<NONE>

Author:
		Aaren
---------------------------------------------------------------------------- */

params ["_group",["_interfaceInit",false],"_isDialog","_settings"];
TRACE_1("fn_ATAK_mission_SUB_TaskBuilding",_this);

_settings params ["","_shown","_subInfos"];
_subInfos params ["_subMenu","_curLine"];

if !(_shown) exitwith {};

private _taskVar = ([] call BCE_fnc_getTaskVar) # 0;

if (isnil {_taskVar}) exitWith {
	ERROR_MSG("Error ""_taskVar"" Variable is empty");
};

private _curLine = [_curLine, (count _taskVar)-1] select (_curLine > count _taskVar);
["BCE_TaskBuilding_Opened", [_curLine]] call CBA_fnc_localEvent;
