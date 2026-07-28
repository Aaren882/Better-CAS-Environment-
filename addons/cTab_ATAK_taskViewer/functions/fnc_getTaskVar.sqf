#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_cTab_ATAK_taskViewer_fnc_getTaskVar
Description:
		Retrieves a task identifier string based on the provided task ID.

Parameters:
		_taskId  - Task ID string required for retrieval.

Returns:
		Return description <NONE>

Author:
		Aaren
---------------------------------------------------------------------------- */

params [["_taskId", "", [""]]];

if (_taskId isEqualTo "") exitWith {""};

"^&" + _taskId
