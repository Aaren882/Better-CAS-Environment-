class CfgVehicles
{
	class Reflector_Cone_01_base_F;
	class Reflector_Cone_01_long_base_F: Reflector_Cone_01_base_F
	{
		class Reflectors
		{
			class Light_1;
			class Light_1_Flare;
		};
	};
	
	//- Phone Flash Light
	class Reflector_Cone_Phone_FlashLight_BCE_F: Reflector_Cone_01_long_base_F
	{
		scope = 1;
		scopeCurator = 0;
		displayName = "Phone FlashLight (BCE)";
		class Reflectors: Reflectors
		{
			class Light_1: Light_1
			{
				intensity = 80;
				innerAngle = 45;
				outerAngle = 100;
				useFlare = 0;
				coneFadeCoef = 4;
				class Attenuation
				{
					start = 0;
					constant = 0;
					linear = 0;
					quadratic = 0.1;
					hardLimitStart = 8;
					hardLimitEnd = 22;
				};
			};
			class Light_1_Flare: Light_1_Flare
			{
				intensity = 0;
				useFlare = 0;
			};
		};
	};
};
