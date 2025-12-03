class CfgVehicles
{
	//-ACE Actions
	class Man;
	class CAManBase: Man
	{
		class ACE_Actions
		{
			class ACE_MainActions
			{
				class ACE_TeamManagement
				{
					class ACE_BCE_Assign_JTAC
					{
						displayName="$STR_BCE_AsJTAC";
						condition="!(_target getVariable ['BCE_is_JTAC',false]) && (_player == leader _player)";
						icon="\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\call_ca.paa";
						exceptions[]={};
						statement="_target setVariable ['BCE_is_JTAC',true,true]";
					};
					class ACE_BCE_Unassign_JTAC
					{
						displayName="$STR_BCE_UnAsJTAC";
						exceptions[]={};
						condition="(_target getVariable ['BCE_is_JTAC',false]) && (_player == leader _player)";
						statement="_target setVariable ['BCE_is_JTAC',false,true]";
					};
				};
			};
		};
		class ACE_SelfActions
		{
			class BCE_Task_Receiver
			{
				displayName = "$STR_BCE_CAS_Task";
				condition = "(((vehicle _player) getVariable ['BCE_Task_Receiver','']) != '') || !(isnull (uiNamespace getVariable ['BCE_Task_Receiver', displayNull])) || !(isNull ([_player] call BCE_fnc_get_TaskCurUnit))";
				exceptions[] = {"isNotInside","isNotSitting"};
				icon = QPATHTOF(data\missions.paa);
			};
		};
	};

	//Lights
	class Reflector_Cone_01_base_F;
	class Reflector_Cone_01_long_base_F: Reflector_Cone_01_base_F
	{
		class Reflectors
		{
			class Light_1;
			class Light_1_Flare;
		};
	};

	class Reflector_Cone_IR_Laser_F: Reflector_Cone_01_long_base_F
	{
		scope = 1;
		scopeCurator = 0;
		displayName = "IR Laser Sim (BCE)";
		class Reflectors: Reflectors
		{
			class Light_1: Light_1
			{
				irLight=1;
				intensity = 5;
				innerAngle = 1;
				outerAngle = 3;
				coneFadeCoef = 8;
				class Attenuation
				{
					start = 4000;
					constant = 0;
					linear = 0;
					quadratic = 0.1;
					hardLimitStart = 4800;
					hardLimitEnd = 6000;
				};
			};
			class Light_1_Flare: Light_1_Flare
			{
				irLight=1;
				innerAngle = 3;
				outerAngle = 10;
				coneFadeCoef = 8;
				useFlare = 1;
				flareMaxDistance = 3000;
				flareSize = 15;
			};
		};
	};
	class Reflector_Cone_IR_Laser_Light_F: Reflector_Cone_IR_Laser_F
	{
		displayName = "IR Laser Light Source (BCE)";
		class Reflectors: Reflectors
		{
			class Light_1_Flare: Light_1_Flare
			{
				color[]={1,0.58,0.16};
				ambient[]={1,0.58,0.16};
				diffuse[]={1,0.58,0.16};
				intensity = 70;
				innerAngle = 20;
				outerAngle = 60;
				coneFadeCoef = 6;

				useFlare = 1;
				flareSize = 0.3;
				flareMaxDistance = 2000;
				drawLight=1;
				dayLight=1;
				brightness=2;
				class Attenuation
				{
					start = 0;
					constant = 0;
					linear = 1;
					quadratic = 1;
					hardLimitStart = 0.01;
					hardLimitEnd = 0.01;
				};
			};
		};
	};
	class Reflector_Cone_IR_LaserDesignator_Light_F: Reflector_Cone_IR_Laser_Light_F
	{
		displayName = "IR Laser Designator Light Source (BCE)";
		class Reflectors: Reflectors
		{
			class Light_1_Flare: Light_1_Flare
			{
				innerAngle = 10;
				outerAngle = 30;
				coneFadeCoef = 4;

				flareSize = 10;
				flareMaxDistance = 4000;
			};
		};
	};

	//Heli
	class Reflector_Cone_01_spotlight_F: Reflector_Cone_01_long_base_F
	{
		scope = 1;
		scopeCurator = 0;
		displayName = "Heli SpotLight (BCE)";
		class Reflectors: Reflectors
		{
			class Light_1: Light_1
			{
				intensity = 10000;
				class Attenuation
				{
					start = 0;
					constant = 0;
					linear = 0;
					quadratic = 0.01;
					hardLimitStart = 2800;
					hardLimitEnd = 3000;
				};
			};
			class Light_1_Flare: Light_1_Flare
			{
				innerAngle = 10;
				outerAngle = 60;
				useFlare = 1;
				flareMaxDistance = 1000;
				flareSize = 5;
			};
		};
	};
	class Reflector_Cone_01_spotlight_IR_F: Reflector_Cone_01_spotlight_F
	{
		displayName = "Heli SpotLight IR (BCE)";
		class Reflectors: Reflectors
		{
			class Light_1: Light_1
			{
				irLight=1;
				innerAngle = 4;
				coneFadeCoef = 15;
				class Attenuation
				{
					start = 0;
					constant = 0;
					linear = 0;
					quadratic = 0.01;
					hardLimitStart = 2800;
					hardLimitEnd = 3000;
				};
			};
			class Light_1_Flare: Light_1_Flare
			{
				irLight=1;
				innerAngle = 4;
				useFlare = 1;
			};
		};
	};

	class Tank;
	class Tank_F: Tank
	{
		class Turrets;
	};
	class LT_01_base_F: Tank_F
	{
		class Turrets: Turrets
		{
			class MainTurret;
		};
	};
	class LT_01_scout_base_F: LT_01_base_F
	{
		class Turrets: Turrets
		{
			class MainTurret: MainTurret
			{
				LaserDesignator_Offset[] = {0,0.03,0}; //{X,Y,Z}
			};
		};
	};
	
	class Plane;
	class Plane_Base_F: Plane
	{
		class Eventhandlers;
	};

	#include "../Compat.hpp"
};
