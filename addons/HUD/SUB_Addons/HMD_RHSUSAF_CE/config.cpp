#include "script_component.hpp"

class CfgPatches {
	class SUBADDON {
		//- #NOTE : RHSUSAF C-Eagle
		requiredAddons[]=
		{
			QGVAR(RHSUSAF), //- overwrite "BCE_HUD_RHSUSAF"
			"CE_HMD_Master" //- #NOTE : https://steamcommunity.com/id/CEagle
		};
		skipWhenMissingDependencies = 1;
		requiredVersion = REQUIRED_VERSION;
		units[] = {};
		weapons[] = {};
		VERSION_CONFIG;
	};
};

#include "CfgVehicles.hpp"
