class CfgVehicles
{
	class Helicopter_Base_F;
	class Helicopter_Base_H: Helicopter_Base_F
	{
		class EventHandlers;
	};
	
	//- RHS LittleBirds
	class RHS_MELB_base: Helicopter_Base_H
	{
		class EventHandlers: EventHandlers{};
	};
	class RHS_MELB_AH6M: RHS_MELB_base
	{
		defaultUserMFDvalues[]={0.15,1,0.15,0.7};
		class MFD
		{
			#include "..\HUD.hpp"
		};
		class EventHandlers: EventHandlers
		{
			class HUD
			{
				getin="(_this # 0) animate ['Addcrosshair', parseNumber (!(missionNameSpace getVariable ['BCE_HUD_fn', false]) && (_this # 1) == 'driver'), true]";
			};
		};
	};

	//- RHS UH-60 HUD
	class Heli_Transport_01_base_F: Helicopter_Base_H{};

	class RHS_UH60_Base: Heli_Transport_01_base_F{};
	class RHS_UH60M_base: RHS_UH60_Base{};
	class RHS_UH60M_US_base: RHS_UH60M_base{};
	class RHS_UH60M: RHS_UH60M_US_base{};
	class RHS_UH60M2: RHS_UH60M{};
	class RHS_UH60M_ESSS: RHS_UH60M2
	{
		defaultUserMFDvalues[]={0.15,1,0.15,0.7};
		class MFD
		{
			#include "..\HUD.hpp"
		};
	};
};
