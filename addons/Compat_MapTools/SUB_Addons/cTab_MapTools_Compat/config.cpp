#include "script_component.hpp"

class CfgPatches {
	class SUBADDON {
		authors[] = {"Aaren"};
		url = ECSTRING(main,url);
		addonRootClass = QUOTE(ADDON);
		requiredVersion = REQUIRED_VERSION;
		//- #NOTE : BCE_cTab
		requiredAddons[]=
		{
			QADDON,
			QGVARMAIN(cTab)
		};
		skipWhenMissingDependencies = 1;
		units[] = {};
		weapons[] = {};
		VERSION_CONFIG;
	};
};

#include "..\UI_Components.hpp"

class PLP_SMT_Description;
#include "UI\Control_UI.hpp"