#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_cTab_ATAK_missions_CFF_fnc_ATAK_CFF_Mission_EOM
Description:
		Executes the End Of Mission (EOM) procedure for the ATAK CFF interface.
		This includes mission cleanup steps.

Parameters:
		_control   - The UI control triggering the function <CONTROL>.

Returns:
		<NONE>

Author:
		Aaren
---------------------------------------------------------------------------- */

params ["_control"];
TRACE_1("fnc_ATAK_CFF_Mission_EOM",_this);

//- Get the Hash Key
private _tagGrp = ctrlParentControlsGroup _control;
private _taskData = _tagGrp getVariable ["CFF_Task_Mission",""];

[_taskData] call BCE_fnc_CFF_Mission_EOM;
