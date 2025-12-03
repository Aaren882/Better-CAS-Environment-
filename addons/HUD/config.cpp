#include "script_component.hpp"

class CfgPatches {
	class ADDON {
		authors[] = {"Aaren"};
		url = ECSTRING(main,url);
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[]={};
		units[] = {};
		weapons[] = {};
		VERSION_CONFIG;
	};
};

#include "configs/CfgFunctions.hpp"
#include "configs/CfgVehicles.hpp"

class Extended_PreInit_EventHandlers
{
	class ADDON
	{
		init = QUOTE(call COMPILE_FILE(XEH_preInit));
	};
};