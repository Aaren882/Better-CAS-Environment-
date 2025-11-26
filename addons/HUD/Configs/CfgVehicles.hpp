class CfgVehicles
{
	//-Helis
	class Helicopter_Base_F;
	class Helicopter_Base_H: Helicopter_Base_F
	{
		class EventHandlers;
		class Turrets
		{
			class MainTurret;
		};
	};
	class Heli_Light_01_base_F: Helicopter_Base_H {};
	class Heli_Light_01_armed_base_F: Heli_Light_01_base_F
	{
		// hiddenSelectionsTextures[] = {"A3\Air_F\Heli_Light_01\Data\Heli_Light_01_ext_Blufor_CO.paa"};
		defaultUserMFDvalues[]={0.15,1,0.15,0.7};
		class MFD
		{
			#include "../HUD.hpp"
		};
		class EventHandlers: EventHandlers
		{
			class HUD
			{
				getin="(_this # 0) setObjectTexture [1, ['a3\air_f\heli_light_01\data\heli_light_01_dot_ca.paa',''] select (missionNameSpace getVariable ['BCE_HUD_fn', false])];";
			};
		};
	};
};
