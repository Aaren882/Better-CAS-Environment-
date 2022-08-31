///////////////////HUD//////////////////////
[
	"BCE_compass_fn","CHECKBOX",
	["Show 3D Compass"],
	["Better CAS Environment", "HUD Settings"],
	true
] call CBA_fnc_addSetting;

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

[
	"BCE_touchMark_fn","CHECKBOX",
	["Touch Mark"],
	["Better CAS Environment", "TGP Cam Settings"],
	true
] call CBA_fnc_addSetting;

//- List
[
	"BCE_Access_list", "LIST",
	["Select Turret Control Trait"],
 	["Better CAS Environment", "TGP Cam Settings"],
 	[[0,1,2,3,4], ["Disabled","All","Leader or JTAC","JTAC","Leader"], 2],
	0,
	{
		TGP_View_Terminal_canUseTurre = call BCE_fnc_canUseTurret;
	}
] call CBA_fnc_addSetting;

//Sliders
[
	"BCE_Red_sdr", "SLIDER",
	["Red Slider"],
	["Better CAS Environment", "HUD Settings"],
	[0, 1, 0.15, 3],
	0,
	{
		call BCE_Fnc_SetMFDValue;
	}
] call CBA_fnc_addSetting;

[
	"BCE_Green_sdr", "SLIDER",
	["Green Slider"],
	["Better CAS Environment", "HUD Settings"],
	[0, 1, 0.15, 3],
	0,
	{
		call BCE_Fnc_SetMFDValue;
	}
] call CBA_fnc_addSetting;

[
	"BCE_Blue_sdr", "SLIDER",
	["Bule Slider"],
	["Better CAS Environment", "HUD Settings"],
	[0, 1, 0.7, 3],
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

///////////////////IR Stuffs//////////////////////
[
	"BCE_veh_IR_fn","CHECKBOX",
	["Laser for Vehicle Laserdesignator"],
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
	"BCE_gun_IR_fn","CHECKBOX",
	["Light Source from Laser Pointer"],
	["Better CAS Environment", "IR Settings"],
	true
] call CBA_fnc_addSetting;

//TGP
[
	"BCE_Tracker_Render_sdr", "SLIDER",
	["Unit Render Range"],
	["Better CAS Environment", "TGP Cam Settings"],
	[500, 20000, 10000, 0]
] call CBA_fnc_addSetting;
