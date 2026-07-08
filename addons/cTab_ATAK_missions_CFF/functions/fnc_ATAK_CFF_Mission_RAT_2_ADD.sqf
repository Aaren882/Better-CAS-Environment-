#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_cTab_ATAK_missions_CFF_fnc_ATAK_CFF_Mission_RAT_2_ADD
Description:
		On "ADD" pressed, for ATAK CFF interface only
		(it will add the FIRE-MSN back to the Mission list)

Parameters:
		_control - The button/UI control which triggers this function. <CONTROL>

Returns:
		<NONE>

Author:
		Aaren
---------------------------------------------------------------------------- */

params ["_control"];
TRACE_1("fnc_ATAK_CFF_Mission_RAT_2_ADD",_this);

//- Get the Hash Key
private _tagGrp = ctrlParentControlsGroup _control;
private _taskData = _tagGrp getVariable ["CFF_Task_Mission",""];

_taskData call BCE_fnc_CFF_Mission_RAT_2_ADD;
