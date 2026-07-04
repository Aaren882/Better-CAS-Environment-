#include "script_component.hpp"

class CfgPatches {
	class ADDON {
		authors[] = {"Aaren"};
		url = ECSTRING(main,url);
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[]=
		{
			"cTab",
			QGVARMAIN(Compat_cTab) //- Check for "BCE_Compat_cTab" #LINK - addons/Compat_cTab/config.cpp
		};
		skipWhenMissingDependencies = 1;
		units[] = {};
		weapons[] = {};
		VERSION_CONFIG;
	};
};

//- UI
#define IS_DIALOG 1
#include "UI_Components.hpp"

//- cTab Interfaces
#include "UI\cTab_UI.hpp"
