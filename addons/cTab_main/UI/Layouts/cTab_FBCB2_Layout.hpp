class cTab_FBCB2_on_screen_time;
class cTab_FBCB2_on_screen_dirDegree: cTab_FBCB2_on_screen_time
{
	style = 1;
};
//-Weather Condition
class cTab_FBCB2_on_screen_dirOctant: cTab_Tablet_OSD_dirOctant
{
	x = "((((15) + ((685))) + ((15) + ((((810)) - (15) * 6) / 5)) * (0.3))) / 2048 * (safezoneW) + (safezoneX + (safezoneW - 	(safezoneW)) / 2)";
	y = "((608) + ((44) - (24)) / 2) / 2048  * ((safezoneW) * 4/3) + (safezoneY + (safezoneH - ((safezoneW) * 4/3)) / 2)";
	w = "1.05 * ((((((810)) - (15) * 6) / 5)) / 2048 * (safezoneW))";
	h = "(((44) - (15))) / 2048 * ((safezoneW) * 4/3)";
	
	size = "(((44) - (15))) / 2048 * ((safezoneW) * 4/3)";
	action = "['cTab_FBCB2_dlg'] call cTab_fnc_toggleWeather";
	
	class TextPos
	{
		left = QUOTE(0.25 * (((safezoneW / safezoneH) min 1.2) / 40));
		top = QUOTE((((((1341))) / 2048 * (safezoneH * 0.8)) * 3/5)/4/20);
		right = 0.0049999999;
		bottom = 0;
	};
	class Attributes: Attributes
	{
		size = QUOTE(0.8);
	};
};