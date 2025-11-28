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

//- Arma Configs
#include "Configs\CfgHints.hpp"
#include "Configs\CfgUIGrids.hpp"
#include "Configs\CfgSounds.hpp"
#include "Configs\CfgMarkerColors.hpp"
#include "Configs\CfgVehicles.hpp"
#include "Configs\CfgEventHandlers.hpp"
#include "Configs\CfgFunctions.hpp"
#include "Configs\CfgFontFamilies.hpp"

#include "Configs\Communication_menu.hpp" //- Top left "Communication_menu" (command menu)
#include "Configs\UI_Elements.hpp"

//- BCE Configs
#include "Components\Additional_Fuze.hpp" //- Fuze System (🔧WIP)

//- Mission Property + Controls + Map Infos
#include "Components\Mission_Components.hpp"
#include "UI\Dialog.hpp"

//- BI's UI ScriptPaths
#include "Configs\CfgScriptPaths.hpp"
