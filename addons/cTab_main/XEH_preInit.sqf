#include "CBA_Setting.hpp"

private _set_TaskBuilder_Vars = {
	params ["_config",["_offset",0]];

	private _classes = ["CAS_TaskList_9","CAS_TaskList_5"] apply {
		"true" configClasses (_config >> "controls" >> _x >> "items");
	};

	[
		(_classes apply {
			_x apply {
				getArray (_x >> "Expression_idc") apply {_x + _offset}
			}
		}),
		(_classes apply {
			_x apply {
				[getText (_x >> "textRight"), getText (_x >> "Task_writeDown")]
			}
		})
	]
};

//-Set all Task IDCs
cTab_Task_TaskItems = [configFile >> "cTab_Tablet_dlg" >> "controls" >> "Task_Builder",17000] call _set_TaskBuilder_Vars;

//- Set Default Devices
ctab_core_personneldevices = ["ItemcTab","ItemcTabMisc","ItemAndroid","ItemAndroidMisc","ItemMicroDAGR","ItemMicroDAGRMisc","ACE_microDAGR"];
ctab_core_leaderDevices = ["ItemcTab","ItemcTabMisc","ItemAndroid","ItemAndroidMisc"];
ctab_core_androidDevices = ["ItemAndroid","ItemAndroidMisc"];
ctab_core_tabDevices = ["ItemcTab","ItemcTabMisc"];
ctab_core_useArmaMarker = false;
ctab_core_bft_mode = 1;