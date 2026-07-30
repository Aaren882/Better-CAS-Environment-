#include "script_component.hpp"

class CfgPatches {
	class SUBADDON {
		authors[] = {"Aaren"};
		url = ECSTRING(main,url);
		addonRootClass = QUOTE(ADDON);
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[]=
		{
			QADDON,
			QGVARMAIN(cTab_UI) //- #NOTE : BCE_cTab_UI
		};
		skipWhenMissingDependencies = 1;
		units[] = {};
		weapons[] = {};
		VERSION_CONFIG;
	};
};

#define IS_DIALOG 1
#include "..\UI_Components.hpp"

class PLP_SMT_Description;
#include "UI\Control_UI.hpp"