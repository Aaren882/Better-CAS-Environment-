#include "script_component.hpp"

class CfgPatches {
	class SUBADDON {
		authors[] = {"Aaren"};
		url = ECSTRING(main,url);
		addonRootClass = QUOTE(ADDON);
		requiredVersion = REQUIRED_VERSION;
		//- #NOTE : RHSUSAF HUD
		requiredAddons[]=
		{
			"rhsusf_main"
		};
		skipWhenMissingDependencies = 1;
		units[] = {};
		weapons[] = {};
		VERSION_CONFIG;
	};
};

#include "CfgVehicles.hpp"
