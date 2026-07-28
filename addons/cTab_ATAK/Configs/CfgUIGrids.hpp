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
					grid_cTab_ATAK_dsp[] = 
					{
						{
							"(safezoneX - (safezoneW * 0.443437) * 0.17)",
							"(safezoneY + safezoneH * 0.88 - ((safezoneW * 0.443437) * 4/3) * 0.72)",
							"(safezoneW * 0.443437)",
							"((safezoneW * 0.443437) * 4/3)"
						},
						"(safezoneW * 0.443437) / 4",
						"((safezoneW * 0.443437) * 4/3) / 4"
					};
				};
			};
		};

		class Variables
		{
			class grid_cTab_ATAK_dsp
			{
				displayName = "cTab Android";
				description = "Android display from cTab";
				preview = "\cTab\img\android_s7_ca.paa";
				saveToProfile[] = {0,1,2,3};
				canResize = 1;
			};
		};
	};
};