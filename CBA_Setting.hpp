///////////////////HUD//////////////////////
[
	"BCE_HUD_fn","CHECKBOX",
	[localize "STR_BCE_Show_HUD"],
	["Better CAS Environment", localize "STR_BCE_Title_HUD_Settings"],
	true,
	0,
	{
		call BCE_Fnc_SetMFDValue;
	}
] call CBA_fnc_addSetting;

[
	"BCE_HUD_RK_fn","LIST",
	[localize "STR_BCE_Rocket_HUD"],
	["Better CAS Environment", localize "STR_BCE_Title_HUD_Settings"],
	[
		[0,1],
		["CCIP","Static"],
		0
	],
	0,
	{
		call BCE_Fnc_SetMFDValue;
	}
] call CBA_fnc_addSetting;

//Sliders
[
	"BCE_HUD_Color", "COLOR",
	[localize "STR_BCE_Custom_HUD_Color"],
	["Better CAS Environment", localize "STR_BCE_Title_HUD_Settings"],
	[0.15, 0.15, 0.7],
	0,
	{
		call BCE_Fnc_SetMFDValue;
	}
] call CBA_fnc_addSetting;

[
	"BCE_Alpha_sdr", "SLIDER",
	[localize "STR_BCE_Brightness"],
	["Better CAS Environment", localize "STR_BCE_Title_HUD_Settings"],
	[0, 1, 1, 2],
	0,
	{
		call BCE_Fnc_SetMFDValue;
	}
] call CBA_fnc_addSetting;

//-Aircraft
[
	"BCE_compass_fn","CHECKBOX",
	[(localize "STR_BCE_Toggle") + (localize "STR_BCE_3D_Compass")],
	["Better CAS Environment", localize "STR_BCE_Title_Aircraft_Camera"],
	true
] call CBA_fnc_addSetting;

[
	"BCE_Mapicon_fn","CHECKBOX",
	[(localize "STR_BCE_Toggle") + (localize "STR_BCE_Map_Icon")],
	["Better CAS Environment", localize "STR_BCE_Title_Aircraft_Camera"],
	true
] call CBA_fnc_addSetting;

[
	"BCE_touchMark_fn","CHECKBOX",
	[localize "STR_BCE_Set_Touch_Marker"],
	["Better CAS Environment", localize "STR_BCE_Title_Aircraft_Camera"],
	true
] call CBA_fnc_addSetting;

[
	"BCE_FriendlyTrack_fn","CHECKBOX",
	[localize "STR_BCE_Unit_Tracker"],
	["Better CAS Environment", localize "STR_BCE_Title_Aircraft_Camera"],
	false,
	1
] call CBA_fnc_addSetting;

[
	"BCE_UnitTrack_fn","CHECKBOX",
	[localize "STR_BCE_Tracker_Box"],
	["Better CAS Environment", localize "STR_BCE_Title_Aircraft_Camera"],
	false,
	1
] call CBA_fnc_addSetting;

[
	"BCE_Landmarks_fn","CHECKBOX",
	[localize "STR_BCE_LandMark_Icon"],
	["Better CAS Environment", localize "STR_BCE_Title_Aircraft_Camera"],
	false,
	1
] call CBA_fnc_addSetting;

[
	"BCE_CamNoise_sdr", "SLIDER",
	[localize "STR_BCE_CamNoise"],
	["Better CAS Environment", localize "STR_BCE_Title_Aircraft_Camera"],
	[0, 1, 0.5, 2],
	1,
	{
		if (count TGP_View_Camera > 0) then {
			private _pphandle = TGP_View_Camera # 1;
			_pphandle ppEffectAdjust [BCE_CamNoise_sdr, 1, 0, [1.0, 0.1, 1.0, 0.75], [0.0, 1.0, 1.0, 1.0], [0.199, 0.587, 0.114, 0.0]];
			_pphandle ppEffectCommit 0;
		};
	}
] call CBA_fnc_addSetting;

//- List
[
	"BCE_Access_list", "LIST",
	[localize "STR_BCE_Select_Turret_Control_Trait"],
 	["Better CAS Environment", localize "STR_BCE_Title_AV_Cam_Settings"],
 	[[0,1,2,3,4], ["Disabled","All","Leader or JTAC","JTAC","Leader"], 2],
	1,
	{
		TGP_View_Terminal_canUseTurret = call BCE_fnc_canUseTurret;
	}
] call CBA_fnc_addSetting;

//- Set File type (ATAK)
	[
		"BCE_PicFile_list", "LIST",
		[localize "STR_BCE_Select_PIC_FILE"],
		["Better CAS Environment (cTab ATAK Camera)", localize "STR_BCE_Title_ATAK_CAM_Settings"],
		[[0,1], ["jpg","png"], 0],
		2
	] call CBA_fnc_addSetting;

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

///////////////////IR Stuffs//////////////////////
[
	"BCE_veh_IR_fn","CHECKBOX",
	[localize "STR_BCE_Laser_for_Air_Vehicles_Laserdesignator"],
	["Better CAS Environment", localize "STR_BCE_Title_LaserDesign_Settings"],
	true
] call CBA_fnc_addSetting;

[
	"BCE_inf_IR_fn","CHECKBOX",
	[localize "STR_BCE_Laser_for_Laserdesignator"],
	["Better CAS Environment", localize "STR_BCE_Title_LaserDesign_Settings"],
	true
] call CBA_fnc_addSetting;

[
	"BCE_inf_IR_Lig_fn","CHECKBOX",
	[localize "STR_BCE_Laser_Light_Source_for_Laserdesignator"],
	["Better CAS Environment", localize "STR_BCE_Title_LaserDesign_Settings"],
	true
] call CBA_fnc_addSetting;

///////////////////TGP//////////////////////
[
	"BCE_Tracker_Render_sdr", "SLIDER",
	[localize "STR_BCE_Unit_Render_Distance"],
	["Better CAS Environment", localize "STR_BCE_Title_AV_Cam_Settings"],
	[500, 20000, 10000, 0]
] call CBA_fnc_addSetting;

///////////////////(Server)//////////////////////
[
	"BCE_AIAir_IR_fn","CHECKBOX",
	[localize "STR_BCE_Exclude_AI_Aircrafts_have_the_Laser_Effect"],
	["Better CAS Environment (Server)", localize "STR_BCE_Title_LaserDesign_Settings"],
	true,
	1
] call CBA_fnc_addSetting;

[
	"BCE_veh_IR_S_fn","CHECKBOX",
	[localize "STR_BCE_Laser_for_Air_Vehicles_Laserdesignator"],
	["Better CAS Environment (Server)", localize "STR_BCE_Title_LaserDesign_Settings"],
	true,
	1
] call CBA_fnc_addSetting;

[
	"BCE_inf_IR_Lig_S_fn","CHECKBOX",
	[localize "STR_BCE_Laser_Light_Source_for_Laserdesignator"],
	["Better CAS Environment (Server)", localize "STR_BCE_Title_LaserDesign_Settings"],
	true,
	1
] call CBA_fnc_addSetting;

[
	"BCE_AI_CAS_Support_fn","CHECKBOX",
	[localize "STR_BCE_Available_AI_CAS_via_CAS_Receiver"],
	["Better CAS Environment (Server)", localize "STR_BCE_Title_CAS_Receiver"],
	false,
	1
] call CBA_fnc_addSetting;

//-Turret Gunner
[
	"BCE_LandVeh_Light_fn","CHECKBOX",
	[localize "STR_BCE_Spotlight_on_Ground_Vehicle_Turret"],
	["Better CAS Environment (Server)", localize "STR_BCE_Title_Turret_Gunner"],
	false,
	1
] call CBA_fnc_addSetting;

[
	"BCE_LandVeh_Laser_fn","CHECKBOX",
	[localize "STR_BCE_Laser_on_Ground_Vehicle_Turret"],
	["Better CAS Environment (Server)", localize "STR_BCE_Title_Turret_Gunner"],
	false,
	1
] call CBA_fnc_addSetting;
