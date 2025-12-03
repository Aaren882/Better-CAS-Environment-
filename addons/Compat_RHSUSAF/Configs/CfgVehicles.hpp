class CfgVehicles
{
	//- Door Gunner stuffs
	class Heli_Transport_02_base_F;
	class RHS_CH_47F_base: Heli_Transport_02_base_F
	{
		//BCE_DoorGunners = 1;
	};

	class Helicopter_Base_F;
	class Heli_Light_03_base_F: Helicopter_Base_F
	{
		class Turrets
		{
			class MainTurret;
		};
	};
	class RHS_UH1_Base: Heli_Light_03_base_F{};
	class RHS_UH1Y_base: RHS_UH1_Base{};
	class RHS_UH1Y_US_base: RHS_UH1Y_base{};
	class RHS_UH1Y: RHS_UH1Y_US_base
	{
		class Turrets: Turrets
		{
			class MainTurret: MainTurret
			{
				Laser_Offset[] = {0,0,-0.1};
			};
			class CopilotTurret: MainTurret
			{
				LightFromLOD=1;
			};
			class RightDoorGun: MainTurret
			{
				Laser_Offset[] = {0,0,-0.1};
			};
		};
	};
};
