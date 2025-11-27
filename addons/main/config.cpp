#include "script_component.hpp"

class CfgPatches
{
	//- #NOTE : Original patch name
	class AVFEVFX
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
