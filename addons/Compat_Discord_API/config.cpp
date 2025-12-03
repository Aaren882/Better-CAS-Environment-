#include "script_component.hpp"

class CfgPatches {
	class ADDON {
		authors[] = {"Aaren"};
		url = ECSTRING(main,url);
		requiredVersion = REQUIRED_VERSION;
		//- #NOTE : Aaren's Discord Message API
		requiredAddons[]=
		{
			"DiscordMessageAPI" 
		};
		skipWhenMissingDependencies = 1;
		units[] = {};
		weapons[] = {};
		VERSION_CONFIG;
	};
};

class Extended_PostInit_EventHandlers
{
	class ADDON
	{
		init = QUOTE(call COMPILE_FILE(XEH_postInit));
	};
};
