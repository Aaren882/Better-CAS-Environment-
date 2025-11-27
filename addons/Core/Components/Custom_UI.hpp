class BCE_RscLine: RscPicture
{
	text=QPATHTOF(data\Element\line.paa);
	ColorText[]={1,1,1,0.8};
	background=1;
	shadow=2;
};

class BCE_RscButtonMenu: RscButtonMenu
{
	style = 2;
	shadow = 1;
	colorBackground[] = {0.36,0.36,0.36,0.5};
	colorBackground2[] = {0.36,0.36,0.36,0.5};
	
	colorBackgroundFocused[] = {0.36,0.36,0.36,0.5};
	
	//-Text
	color[] = {1,1,1,1};
	color2[] = {1,1,1,1};
	colorFocused[] = {0.3,0.3,0.3,1};
	colorFocusedSecondary[] = {0.3,0.3,0.3,1};
	
	period = 0;
	periodFocus = 0;
	periodOver = 0;
	
	class ShortcutPos
	{
		left = 0;
		top = 0.005;
		w = 0.0175;
		h = 0.025;
	};
	class Attributes
	{
		font = "RobotoCondensed_BCE";
		color = "#E5E5E5";
		align = "left";
		valign = "middle";
		shadow = "false";
	};
};