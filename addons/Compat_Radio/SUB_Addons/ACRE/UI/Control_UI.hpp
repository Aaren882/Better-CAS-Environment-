class RscDisplayAVTerminal
{
	class controls: BCE_Mission_Build_Controls
	{
		class ButtonACRE_Racks: ButtonACRE_Racks
		{
			idc = 201141;
			x = "58 * (safezoneW / 64) + (safezoneX) - (((safezoneW / safezoneH) min 1.2) / 40)";
			y = "(8.75 + 2) * (safezoneH / 40) + (safezoneY) + (19.9 * (safezoneH / 40) + 0.01) + (0.035 * safezoneH)";
			w = "(((safezoneW / safezoneH) min 1.2) / 40)";
			h = "((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			show = 0;
		};

		class ListACRE_Racks: ListACRE_Racks
		{
			idc = 201142;
			x = "58 * (safezoneW / 64) + (safezoneX)";
			y = "(8.75 + 2) * (safezoneH / 40) + (safezoneY) + (19.9 * (safezoneH / 40) + 0.01) + (0.035 * safezoneH)";
			w = "5 * (safezoneW / 64)";
			h = "0";
			show = 0;
		};
	};
};