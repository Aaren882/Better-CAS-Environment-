#include "script_component.hpp"

class CfgPatches {
	class ADDON {
		authors[] = {"Aaren"};
		url = ECSTRING(main,url);
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[]={
			"A3_Ui_F"
		};
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

//- BCE Configs
#include "Components\Additional_Fuze.hpp" //- Fuze System (🔧WIP)

//- UI
#include "UI_Components.hpp"

	//- Mission Property + Controls + Map Infos
	#include "Components\Mission_Property.hpp"
	#include "Components\Mission_Components.hpp"
	#include "Components\Mission_Map_Infos.hpp"

#include "UI\Dialog.hpp"
#include "UI\Control_UI.hpp" //- AV Terminal Interfaces

//- BI's UI ScriptPaths
#include "Configs\CfgScriptPaths.hpp"
