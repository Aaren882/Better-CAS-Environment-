#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_cTab_ATAK_missions_fnc_ATAK_set_TaskType
Description:
		Sets the task type settings for the cTab_ATAK_missions module.
		It retrieves the current task category and updates the sub-menu information based on the selected control.

Parameters:
		_lbCurSel  - The control element (e.g., list box selection) containing the current task selection.

Returns:
		_settings - The updated Settings <ARRAY> for mission parameters.

Author:
		Aaren
---------------------------------------------------------------------------- */

params ["_lbCurSel"];
TRACE_1("fnc_ATAK_set_TaskType",_this);

private _group = (call BCE_fnc_ATAK_getCurrentAPP) # 1;

//- Get Correct Mission Builder
  private _current_Cate = [] call BCE_fnc_get_BCE_TaskCateClass;
	
private _settings = ["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings;

_settings params ["","","_subInfos"];
private _subMenu_Map = _subInfos param [2, createHashMap];

//- Set SubMenu Infos (HashMap)
	_subMenu_Map set [_current_Cate, _lbCurSel];
	_subInfos set [2, _subMenu_Map];

//- Don't Update Interface (Save Only)
	_settings set [2, _subInfos];
	["cTab_Android_dlg",[["showMenu",_settings]],false] call cTab_fnc_setSettings;

_settings
