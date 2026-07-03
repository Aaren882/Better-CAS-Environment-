#include "script_component.hpp"

class CfgPatches {
	class ADDON {
		authors[] = {"Aaren"};
		url = ECSTRING(main,url);
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {QGVARMAIN(cTab_UI)};
		units[] = {};
		weapons[] = {};
		VERSION_CONFIG;
		skipWhenMissingDependencies = 1;
	};
};

class Extended_PreInit_EventHandlers
{
	class ADDON
	{
		init = QUOTE(call COMPILE_FILE(XEH_PreInit));
	};
};

//- UI
#define IS_DIALOG 1
#include "UI_Components.hpp"
#include "Configs/app.hpp"

class RscTitles
{
	titles[] += {"BCE_PhoneCAM_View"};
	
	#undef IS_DIALOG
	#include "UI_Components.hpp"
	#include "Configs/app.hpp"
	#include "UI\ScreenShot_UI.hpp"
};