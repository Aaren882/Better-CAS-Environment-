///////////////////HUD//////////////////////
[
	"BCE_HUD_fn","CHECKBOX",
	["Show HUD"],
	["Better CAS Environment", "HUD Settings"],
	true,
	0,
	{
		call BCE_Fnc_SetMFDValue;
	}
] call CBA_fnc_addSetting;

//Sliders
[
	"BCE_HUD_Color", "COLOR",
	["Custom HUD Color"],
	["Better CAS Environment", "HUD Settings"],
	[0.15, 0.15, 0.7],
	0,
	{
		call BCE_Fnc_SetMFDValue;
	}
] call CBA_fnc_addSetting;

[
	"BCE_Alpha_sdr", "SLIDER",
	["Alpha Slider"],
	["Better CAS Environment", "HUD Settings"],
	[0, 1, 1, 2],
	0,
	{
		call BCE_Fnc_SetMFDValue;
	}
] call CBA_fnc_addSetting;

//-Aircraft
[
	"BCE_compass_fn","CHECKBOX",
	["Show 3D Compass"],
	["Better CAS Environment", "Aircraft Camera"],
	true
] call CBA_fnc_addSetting;

[
	"BCE_Mapicon_fn","CHECKBOX",
	["Show Map Icon"],
	["Better CAS Environment", "Aircraft Camera"],
	true
] call CBA_fnc_addSetting;

[
	"BCE_touchMark_fn","CHECKBOX",
	["Touch Mark"],
	["Better CAS Environment", "Aircraft Camera"],
	true
] call CBA_fnc_addSetting;

[
	"BCE_FriendlyTrack_fn","CHECKBOX",
	["Friendly Tracker"],
	["Better CAS Environment", "Aircraft Camera"],
	false,
	1
] call CBA_fnc_addSetting;

[
	"BCE_UnitTrack_fn","CHECKBOX",
	["Unit Tracker Box"],
	["Better CAS Environment", "Aircraft Camera"],
	false,
	1
] call CBA_fnc_addSetting;

//- List
[
	"BCE_Access_list", "LIST",
	["Select Turret Control Trait"],
 	["Better CAS Environment", "TGP Cam Settings"],
 	[[0,1,2,3,4], ["Disabled","All","Leader or JTAC","JTAC","Leader"], 2],
	1,
	{
		TGP_View_Terminal_canUseTurret = call BCE_fnc_canUseTurret;
	}
] call CBA_fnc_addSetting;

///////////////////IR Stuffs//////////////////////
[
	"BCE_veh_IR_fn","CHECKBOX",
	["Laser for Air Vehicles Laserdesignator"],
	["Better CAS Environment", "IR Settings"],
	true
] call CBA_fnc_addSetting;

[
	"BCE_inf_IR_fn","CHECKBOX",
	["Laser for Laserdesignator"],
	["Better CAS Environment", "IR Settings"],
	true
] call CBA_fnc_addSetting;

[
	"BCE_inf_IR_Lig_fn","CHECKBOX",
	["Laser Light Source for Laserdesignator"],
	["Better CAS Environment", "IR Settings"],
	true
] call CBA_fnc_addSetting;

///////////////////TGP//////////////////////
[
	"BCE_Tracker_Render_sdr", "SLIDER",
	["Unit Render Range"],
	["Better CAS Environment", "TGP Cam Settings"],
	[500, 20000, 10000, 0]
] call CBA_fnc_addSetting;

///////////////////(Server)//////////////////////
[
	"BCE_AIAir_IR_fn","CHECKBOX",
	["Exclude AI Aircrafts have the Laser Effect"],
	["Better CAS Environment (Server)", "Laser Settings"],
	true,
	1
] call CBA_fnc_addSetting;

[
	"BCE_veh_IR_S_fn","CHECKBOX",
	["Laser for Air Vehicles Laserdesignator"],
	["Better CAS Environment (Server)", "Laser Settings"],
	true,
	1
] call CBA_fnc_addSetting;

[
	"BCE_inf_IR_Lig_S_fn","CHECKBOX",
	["Laser Light Source for Laserdesignator"],
	["Better CAS Environment (Server)", "Laser Settings"],
	true,
	1
] call CBA_fnc_addSetting;

[
	"BCE_TAC_Map_AIxcd_POS","CHECKBOX",
	["Dont Return Turret and TGP Pointing POS from AI","or They will keep going Up"],
	["Better CAS Environment (Server)", "AV Terminal"],
	true,
	1,
	{
		private _dir_simp = missionNamespace getVariable ["BCE_Directional_object_AV",objNull];
		if (_dir_simp isEqualTo objNull) then {
			deleteVehicle _dir_simp;
			missionNamespace setVariable ["BCE_Directional_object_AV",objNull];
		};
	}
] call CBA_fnc_addSetting;

[
	"BCE_AI_CAS_Support_fn","CHECKBOX",
	["Available AI CAS via CAS Receiver"],
	["Better CAS Environment (Server)", "CAS Receiver"],
	false,
	1
] call CBA_fnc_addSetting;

//-Turret Gunner
[
	"BCE_LandVeh_Light_fn","CHECKBOX",
	["Spotlight on Ground Vehicle Turret"],
	["Better CAS Environment (Server)", "Turret Gunner"],
	false,
	1
] call CBA_fnc_addSetting;

[
	"BCE_LandVeh_Laser_fn","CHECKBOX",
	["Laser on Ground Vehicle Turret"],
	["Better CAS Environment (Server)", "Turret Gunner"],
	false,
	1
] call CBA_fnc_addSetting;
