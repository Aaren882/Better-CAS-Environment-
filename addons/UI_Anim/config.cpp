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

//- Animation Config
#include "Extended_Anim_props.hpp"

//- Arma Configs
#include "configs/CfgFunctions.hpp"
