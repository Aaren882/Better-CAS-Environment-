class CfgUIGrids
{
	class IGUI
	{
		class Presets
		{
			class Arma3
			{
				class Variables
				{
					grid_BCE_TaskList[] =
					{
						{
							"safezoneX",
							"((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)",
							"(12 * (((safezoneW / safezoneH) min 1.2) / 40))",
							"(12 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))"
						},
						"(((safezoneW / safezoneH) min 1.2) / 40)",
						"((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"
					};
				};
			};
		};

		class Variables
		{
			class grid_BCE_TaskList
			{
				displayName = "BCE Task Receiver";
				description = "TaskList from BCE";
				preview = "#(argb,8,8,3)color(0.2,0.2,0.2,0.8)";
				saveToProfile[] = {0,1,2,3};
				canResize = 1;
			};
		};
	};
};