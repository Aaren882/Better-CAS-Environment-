//-Set all Task IDCs
cTab_Task_TaskItems = [configFile >> "cTab_Tablet_dlg" >> "controls" >> "Task_Builder",17000] call _set_TaskBuilder_Vars;

//- Set Default Devices
ctab_core_personneldevices = ["ItemcTab","ItemcTabMisc","ItemAndroid","ItemAndroidMisc","ItemMicroDAGR","ItemMicroDAGRMisc","ACE_microDAGR"];
ctab_core_leaderDevices = ["ItemcTab","ItemcTabMisc","ItemAndroid","ItemAndroidMisc"];
ctab_core_androidDevices = ["ItemAndroid","ItemAndroidMisc"];
ctab_core_tabDevices = ["ItemcTab","ItemcTabMisc"];
ctab_core_useArmaMarker = false;
ctab_core_bft_mode = 1;