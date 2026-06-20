class cTab_Tablet_notification: cTab_RscText_Tablet
{
	x = "((257)) / 2048 * ((safezoneH * 1.2) * 3/4) + (safezoneX + (safezoneW - ((safezoneH * 1.2) * 3/4)) / 2 + (((safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
	w = "(((1341))) / 2048 * ((safezoneH * 1.2) * 3/4)";
};
class cTab_MenuItem: RscButtonMenu
{
	color[] = {1,1,1,1};
	color2[] = {1,1,1,1};
	colorBackground[] = {0,0,0,0};
	colorBackground2[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.5};
	colorFocused[] = {1,1,1,1};
	colorBackgroundFocused[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.5};
	shadow = 2;
	style = 0;

	period = 0;
	periodFocus = 2;
	periodOver = 0.5;

	offsetPressedX = "pixelW";
	offsetPressedY = "pixelH";

	class Attributes
	{
		font = "PuristaLight";
		size = QUOTE(SubMenuText);
	};
};

class cTab_MenuExit: cTab_MenuItem
{
	color[] = {1,1,1,1};
	colorBackground[] = {1,0.25,0.25,0.1};
	colorBackground2[] = {1,0.25,0.25,0.3};
	colorBackgroundFocused[] = {1,0.25,0.25,0.3};
};
class cTab_Tablet_OSD_hookGrid: cTab_RscText_Tablet
{
	colorText[] = {0.95,0.95,0.95,1};
};
class cTab_Tablet_OSD_time;
class cTab_Tablet_OSD_dirDegree: cTab_Tablet_OSD_time
{
	style = 1;
};

//- Weather Widget Toggle
class cTab_Tablet_OSD_dirOctant: BCE_RscButtonMenu
{
	style = 2;
	
	//x = "((((10) + ((257))) + ((10) + ((((1341)) - (10) * 8) / 7)) * (2))) / 2048 * ((safezoneH * 1.2) * 3/4) + (safezoneX + (safezoneW - ((safezoneH * 1.2) * 3/4)) / 2 + (((safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
	x = "((((10) + ((257))) + ((10) + ((((1341)) - (10) * 8) / 7)) * (4 - 1))) / 2048  * ((safezoneH * 1.2) * 3/4) + (safezoneX + (safezoneW - ((safezoneH * 1.2) * 3/4)) / 2 + (((safezoneH * 1.2) * 3/4) * 96.5 / 2048)) + ((((((1341)) - (10) * 8) / 7)) / 2048  * ((safezoneH * 1.2) * 3/4))";
	y = "((491) + ((42) - (27)) / 2) / 2048 * (safezoneH * 1.2) + (safezoneY + (safezoneH - (safezoneH * 1.2)) / 2)";
	w = "1.3 * ((((((1341)) - (10) * 8) / 7)) / 2048 * ((safezoneH * 1.2) * 3/4))";
	h = "(((42) - (10))) / 2048 * (safezoneH * 1.2)";
	
	text = "";
	action = "['cTab_Tablet_dlg'] call cTab_fnc_toggleWeather";
	
	size = "(((42) - (10))) / 2048 * (safezoneH * 1.2)";
	
	animTextureOver = "#(argb,8,8,3)color(1,1,1,0.8)";
	animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
	animTexturePressed = "#(argb,8,8,3)color(1,1,1,0.5)";
	
	colorBackground[] = 
	{
		"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",
		0.8
	};
	colorBackground2[] = 
	{
		"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",
		0.8
	};
	colorBackgroundFocused[] = 
	{
		"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",
		0.5
	};
	
	class Attributes: Attributes
	{
		align="left";
		valign="middle";
	};
};

//-Weather Condition
class cTab_Tablet_OSD_Weather_condition_Box: RscStructuredText
{
	idc = 26160;
	colorBackground[] = {0.2,0.2,0.2,0.5};
	
	y = "((491) + ((42) - (27)) / 2) / 2048 * (safezoneH * 1.2) + (safezoneY + (safezoneH - (safezoneH * 1.2)) / 2) + ((((42) - (10))) / 2048 * (safezoneH * 1.2))";
	w = "1.3 * ((((((1341)) - (10) * 8) / 7)) / 2048 * ((safezoneH * 1.2) * 3/4))";
	h = QUOTE(0);
	
	text = "";
	tooltip="";
	
	size = "(((42) - (10))) / 2048 * (safezoneH * 1.2)";
	
	class Attributes
	{
		align = "Left";
		font = "RobotoCondensedBold_BCE";
	};
};