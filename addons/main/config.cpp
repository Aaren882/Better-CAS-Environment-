#include "script_component.hpp"

class CfgPatches
{
	class MAIN_ADDON
	{
		authors[] = {"Aaren"};
		url = ECSTRING(main,url); //- Localized String
		name = CSTRING(COMPONENT);
		requiredVersion = REQUIRED_VERSION;
		units[] = {};
		weapons[] = {};
		requiredAddons[]=
		{
			"A3_Ui_F"
		};
		VERSION_CONFIG;
	};
};
