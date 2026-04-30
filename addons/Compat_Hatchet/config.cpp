#include "script_component.hpp"

class CfgPatches {
	class ADDON {
		authors[] = {"Aaren"};
		url = ECSTRING(main,url);
		requiredVersion = REQUIRED_VERSION;
		//- #NOTE : Hatchet H-60
		requiredAddons[]=
		{
			QEGVAR(Compat,cTab),
			"vtx_uh60_jvmf"
		};
		skipWhenMissingDependencies = 1;
		units[] = {};
		weapons[] = {};
		VERSION_CONFIG;
	};
};

#include "configs\CfgFunctions.hpp"
