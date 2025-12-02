class RscDisplayMainMap
{
	class controls
	{
		//-POLPOX map tools
		class BCE_Task_toggle;
		class BCE_MapTools_Tooltip: BCE_Task_toggle
		{	
			idc = 1609;
			text = "";
			tooltip = "MOD : ""Key Combine""";
			onButtonClick = "";
			y = MAP_TOGGLE_Y(2,2);
			w = "5 * (((safezoneW / safezoneH) min 1.2) / 40) + (0.5 * 0.015)";
			colorDisabled[]={1,1,1,1};
			colorBackgroundDisabled[]={0,0,0,0.5};
		};
	};
};