#include "script_component.hpp"

class CfgPatches {
	class ADDON {
		authors[] = {"Aaren"};
		url = ECSTRING(main,url);
		requiredVersion = REQUIRED_VERSION;
		//- #NOTE : This Compat For "cTab_1erGTD"
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

//- Arma Configs
#include "configs/CfgFunctions.hpp"
#include "configs/CfgUIGrids.hpp"

class Extended_PostInit_EventHandlers
{
	//- Remove 1erGTD's rangefinder Initiation
	class ctab_rangefinder
	{
		clientInit = "";
	};
};
