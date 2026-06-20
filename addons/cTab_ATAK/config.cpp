#include "script_component.hpp"

class CfgPatches {
	class ADDON {
		authors[] = {"Aaren"};
		url = ECSTRING(main,url);
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {QGVARMAIN(cTab_main)};
		units[] = {};
		weapons[] = {};
		VERSION_CONFIG;
		skipWhenMissingDependencies = 1;
	};
};

#include "Configs/CfgFunctions.hpp"