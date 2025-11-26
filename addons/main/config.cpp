#include "script_component.hpp"

class CfgPatches
{
	class AVFEVFX
	{
		authors[] = {"Aaren"};
		url = ECSTRING(main,url); //- Localized String
		name = CSTRING(COMPONENT);
		requiredVersion = REQUIRED_VERSION;
		units[] = {};
		weapons[] = {};
		requiredAddons[]=
		{
			"A3_Ui_F"
		};
		VERSION_CONFIG;
	};
};

#include "Additional_Fuze.hpp"
#include "Configs\CfgFunctions.hpp"
#include "Configs\CfgVehicles.hpp"

class Extended_PostInit_EventHandlers
{
	class ADDON
	{
		init = QUOTE(call COMPILE_FILE(XEH_postInit));
	};
};
//- #TODO : CBA style preprocessing script compile
class Extended_PreInit_EventHandlers
{
	class ADDON
	{
		init = QUOTE(call COMPILE_FILE(XEH_preInit));
	};
};
