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