class CfgVehicles
{
	class Helicopter_Base_F;
	class Helicopter_Base_H: Helicopter_Base_F
	{
		class EventHandlers;
	};
	
	//MELB
	class MELB_base: Helicopter_Base_H
	{
		class EventHandlers: EventHandlers{};
	};
	class MELB_AH6M: MELB_base
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
				getin="if (((_this # 0) animationPhase 'Addcrosshair') != 0 && {missionNameSpace getVariable ['BCE_HUD_fn', false]}) then {(_this # 0) animate ['Addcrosshair', 0];} else {(_this # 0) animate ['Addcrosshair', 1];};";
			};
		};
	};
};
