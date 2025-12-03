#include "script_component.hpp"

class CfgPatches {
	class SUBADDON {
		authors[] = {"Aaren"};
		url = ECSTRING(main,url);
		addonRootClass = QUOTE(ADDON);
		requiredVersion = REQUIRED_VERSION;
		//- #NOTE : RHSUSAF Kimi
		requiredAddons[]=
		{
			QGVAR(RHSUSAF), //- overwrite "BCE_HUD_RHSUSAF"
			"Kimi_HMDs_RHS" //- Original HMD mod
		};
		skipWhenMissingDependencies = 1;
		units[] = {};
		weapons[] = {};
		VERSION_CONFIG;
	};
};

#include "CfgVehicles.hpp"
