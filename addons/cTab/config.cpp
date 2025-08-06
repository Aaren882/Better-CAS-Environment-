#include "script_component.hpp"

class CfgPatches {
	class SUBADDON {
		authors[] = {"Aaren"};
		url = ECSTRING(main,url);
		addonRootClass = QUOTE(ADDON);
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[]=
		{
			"A3_Ui_F",
			"A3_Weapons_F",
			"A3_Air_F_Heli_Light_01",
			"A3_Air_F_Jets_Plane_Fighter_01",
			"A3_Armor_F_Tank_AFV_Wheeled_01",
			"A3_Armor_F_Tank_LT_01",
			"A3_Soft_F_Beta_MRAP_03"
		};
		units[] = {};
		weapons[] = {};
		VERSION_CONFIG;
	};
};

class Extended_PreInit_EventHandlers
{
	class ADDON
	{
		init = QUOTE(call COMPILE_SCRIPT(XEH_preInit));
	};
};
