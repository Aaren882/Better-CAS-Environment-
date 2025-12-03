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
		
		class MFD; //- #NOTE : 👈 Kimi's HMD is in here
	};
	class RHS_MELB_AH6M: RHS_MELB_base
	{
		defaultUserMFDvalues[] = {0,1,0,0,1,0,0.2};
		delete MFD; //- #NOTE - Important "DELETE" !! MFD doesn't take inheritance properties
	};
};
