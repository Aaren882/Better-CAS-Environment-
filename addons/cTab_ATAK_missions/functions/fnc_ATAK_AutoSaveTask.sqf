#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_cTab_ATAK_missions_fnc_ATAK_AutoSaveTask
Description:
		Automatically saves the state of the Task Control Tab (cTab) when controls change. It handles saving both the description and the Game Plan state.

Parameters:
		_control  - The control element that triggers the auto-save functionality.

Returns:
		<NONE>

Author:
		Aaren
---------------------------------------------------------------------------- */

params ["_control"];
TRACE_1("fnc_ATAK_AutoSaveTask",_this);

if !((ctrlParentControlsGroup _control) getVariable ["Init",false]) exitWith {};

[{
	params ["_control","_input",["_type",-1]];

	privateAll;

	_curType = [] call BCE_fnc_get_TaskCurType;
	_curCate = ["Cate"] call BCE_fnc_get_TaskCurSetup;

	//-5 line "Mark With"
	if (_type == 1) then {
		_type = 0;
	};

	_curLine = switch _type do {
		//-Save DESC
		case 0: {
			[[5,3],[3,3]] # _curCate # _curType; //- Get Description Line
		};
		//-Save Game Plan
		default {
			0
		};
	};

	//- Description Will update it self, base on the current value it has
		["BCE_TaskBuilding_Enter", [_curLine]] call CBA_fnc_localEvent;
	}, _this
] call CBA_fnc_execNextFrame;
