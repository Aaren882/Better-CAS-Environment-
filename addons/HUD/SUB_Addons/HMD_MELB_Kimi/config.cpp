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
			QGVAR(MELB), //- overwrite "BCE_HUD_MELB"
			"rhsusf_main",
			"Kimi_HMDs_MELB" //- Original HMD mod
		};
		skipWhenMissingDependencies = 1;
		units[] = {};
		weapons[] = {};
		VERSION_CONFIG;
	};
};

#include "CfgVehicles.hpp"
