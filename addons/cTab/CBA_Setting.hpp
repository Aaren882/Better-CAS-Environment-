//- Set File type (cTab/ATAK)
/* [
	"BCE_PicFile_list", "LIST",
	[localize "STR_BCE_Select_PIC_FILE"],
	["Better CAS Environment (cTab ATAK Camera)", localize "STR_BCE_Title_ATAK_CAM_Settings"],
	[[0,1], ["jpg","png"], 0],
	2
] call CBA_fnc_addSetting; */

[
	"BCE_PicFilePath_edit", "EDITBOX",
	[localize "STR_BCE_Select_PIC_FILE_PATH", localize "STR_BCE_Select_PIC_FILE_ToopTip"],
	["Better CAS Environment (cTab ATAK Camera)", localize "STR_BCE_Title_ATAK_CAM_Settings"],
	"",
	2
] call CBA_fnc_addSetting;

[
	"BCE_PicFileSize_edit", "EDITBOX",
	[localize "STR_BCE_Select_PIC_FILE_SIZE"],
	["Better CAS Environment (cTab ATAK Camera)", localize "STR_BCE_Title_ATAK_CAM_Settings"],
	"25",
	2,
	{
		private _return = "Arma_ScreenShot_Extension" callExtension ["MaxSize", [round parseNumber _this]];
		Systemchat (_return # 0);
	}
] call CBA_fnc_addSetting;
//- cTab server side
[
	"BCE_cTab_Side_Display", "CHECKBOX",
	[localize "STR_BCE_cTab_ATAK_Side_Display",localize "STR_BCE_cTab_ATAK_Side_Display_tip"],
	["Better CAS Environment (Server)",localize "STR_BCE_cTab_Settings"],
	true,
	1
] call CBA_fnc_addSetting;
[
	"BCE_cTab_Marker_Sync", "LIST",
	[localize "STR_BCE_cTab_Marker_Sync",localize "STR_BCE_cTab_Marker_Sync_tip"],
	["Better CAS Environment (Server)",localize "STR_BCE_cTab_Settings"],
	[
		["_IcTab", "_USER"],
		[localize "STR_MPROLE_DISABLE",localize "STR_OPT_ENABLE"],
		1
	],
	1
] call CBA_fnc_addSetting;
[
	"BCE_cTab_Marker_Sync_time", "TIME",
	[localize "STR_BCE_cTab_Marker_Sync_Time"],
	["Better CAS Environment (Server)",localize "STR_BCE_cTab_Settings"],
	[1, 5, 1],
	1
] call CBA_fnc_addSetting;