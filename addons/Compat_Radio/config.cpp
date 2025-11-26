#include "script_component.hpp"

class CfgPatches {
	class DOUBLES(ADDON,ACRE) {
		authors[] = {"Aaren"};
		url = ECSTRING(main,url);
		requiredVersion = REQUIRED_VERSION;
		//- #NOTE : Radios (TFAR, ACRE2...)
		requiredAddons[]=
		{
			"acre_sys_core"
		};
		skipWhenMissingDependencies = 1;
		units[] = {};
		weapons[] = {};
		VERSION_CONFIG;
	};
	class DOUBLES(ADDON,TFAR): DOUBLES(ADDON,ACRE) {
		//- #NOTE : Radios (TFAR, ACRE2...)
		requiredAddons[]=
		{
			"tfar_core"
		};
	};
};

#include "configs/CfgFunctions.hpp"
