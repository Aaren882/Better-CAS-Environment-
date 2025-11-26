#include "script_component.hpp"

class CfgPatches {
	class ADDON {
		authors[] = {"Aaren"};
		url = ECSTRING(main,url);
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[]=
		{
			"cTab",
			"ctab_core",
			"ctab_rangefinder"
		};
		skipWhenMissingDependencies = 1;
		units[] = {};
		weapons[] = {};
		VERSION_CONFIG;
	};
};

#include "Configs/CfgFunctions.hpp"
#include "Configs/CfgVehicles.hpp"

class Extended_PostInit_EventHandlers
{
	class ADDON
	{
		init = QUOTE(call COMPILE_FILE(XEH_postInit));
	};

	//- Remove 1erGTD's rangefinder Initiation
	class ctab_rangefinder
	{
		clientInit = "";
	};
};
class Extended_PreInit_EventHandlers
{
	class ADDON
	{
		init = QUOTE(call COMPILE_FILE(XEH_preInit));
	};
};