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

class CfgCommands
{
	// Note that in case of clients connected to dedicated server, restrictions defined in its config have priority.
	allowedHTMLLoadURIs[] +=
	{
		"*.youtube-nocookie.com",
		"*.youtube.com"
	};
};

//- Configs
#include "Configs\CfgEventHandlers.hpp"

//- UI
#define IS_DIALOG 1
#include "UI_Components.hpp"
#include "UI\elements.hpp"

class RscTitles
{
	#undef IS_DIALOG
	#include "UI_Components.hpp"
	#include "UI\elements.hpp"
};