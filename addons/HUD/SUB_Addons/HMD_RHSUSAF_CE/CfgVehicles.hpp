class CfgVehicles
{
	//- #NOTE : Overwrite "BCE_HUD_RHSUSAF"
	class Helicopter_Base_F;
	class Helicopter_Base_H: Helicopter_Base_F
	{
		class EventHandlers;
	};
	class RHS_MELB_base: Helicopter_Base_H
	{
		class EventHandlers: EventHandlers{};
	};
	class RHS_MELB_AH6M: RHS_MELB_base
	{
		defaultUserMFDvalues[] = {1,1,0,1,0.65,0,0.5};
		class MFD
		{
			delete BCE_Assist_HUD;
		};
	};
};
