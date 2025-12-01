#include "script_component.hpp"

class CfgPatches {
	class ADDON {
		authors[] = {"Aaren"};
		url = ECSTRING(main,url);
		requiredVersion = REQUIRED_VERSION;
		//- #NOTE : This Compat For "cTab_1erGTD"
		requiredAddons[]=
		{
			"ace_map",
			"ACE_map_gestures"
		};
		skipWhenMissingDependencies = 1;
		units[] = {};
		weapons[] = {};
		VERSION_CONFIG;
	};
};

//- UI
#include "..\Core\Configs\UI_Components.hpp"
#include "UI\Map_UI.hpp"

#include "configs\CfgFunctions.hpp"
