#include "script_component.hpp"

class CfgPatches {
	class ADDON {
		authors[] = {"Aaren"};
		url = ECSTRING(main,url);
		requiredVersion = REQUIRED_VERSION;
		//- #NOTE : A3 Thermal Improvement (A3TI)
		requiredAddons[]=
		{
			"A3TI"
		};
		skipWhenMissingDependencies = 1;
		units[] = {};
		weapons[] = {};
		VERSION_CONFIG;
	};
};

#include "configs/CfgFunctions.hpp"

class Extended_PreInit_EventHandlers
{
	class ADDON
	{
		init = QUOTE(call COMPILE_FILE(XEH_preInit));
	};
};