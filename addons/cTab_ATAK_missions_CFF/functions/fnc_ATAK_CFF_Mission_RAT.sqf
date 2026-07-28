#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_cTab_ATAK_missions_CFF_fnc_ATAK_CFF_Mission_RAT
Description:
		Handles the logic when "Record as Target" is pressed on ATAK CFF interface.

Parameters:
		_control   - The UI control triggering the function <CONTROL>.
		_removeRAT - flag to determine if the RAT should be removed. <BOOL>

Returns:
		<NONE>

Author:
		Aaren
---------------------------------------------------------------------------- */

params ["_control",["_removeRAT",false]];
TRACE_1("fnc_ATAK_CFF_Mission_RAT",_this);

//- Get the Hash Key
private _tagGrp = ctrlParentControlsGroup _control;
private _taskData = _tagGrp getVariable ["CFF_Task_Mission",""];

[_taskData, _removeRAT] call BCE_fnc_CFF_Mission_RAT;
