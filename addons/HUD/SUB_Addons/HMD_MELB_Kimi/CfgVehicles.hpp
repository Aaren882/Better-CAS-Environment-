class CfgVehicles
{
	//- #NOTE : Overwrite "BCE_HUD_MELB"
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
		defaultUserMFDvalues[] = {0,1,0,0,1,0,0.2};
		delete MFD;
	};
};
