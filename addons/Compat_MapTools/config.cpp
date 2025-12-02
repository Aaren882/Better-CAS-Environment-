#include "script_component.hpp"

class CfgPatches {
	class ADDON {
		authors[] = {"Aaren"};
		url = ECSTRING(main,url);
		requiredVersion = REQUIRED_VERSION;
		//- #NOTE : POLPOX MapTools
		requiredAddons[]=
		{
			QGVARMAIN(Core),
			"A3_Ui_F",
			"PLP_mapToolsRemastered"
		};
		skipWhenMissingDependencies = 1;
		units[] = {};
		weapons[] = {};
		VERSION_CONFIG;
	};
};

//- POLPOX MapTool Config
#include "Components/PLP_SMT_Data.hpp"

//- UI
#include "UI_components.hpp"
#include "UI/Map_UI.hpp"

//- Arma Configs
#include "configs/CfgFunctions.hpp"
