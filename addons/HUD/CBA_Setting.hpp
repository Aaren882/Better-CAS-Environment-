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
