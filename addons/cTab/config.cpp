#include "script_component.hpp"

class CfgPatches {
	class ADDON {
		authors[] = {"Aaren"};
		url = ECSTRING(main,url);
		requiredVersion = REQUIRED_VERSION;
		//- #NOTE : Check for "BCE_Compat_cTab"
		requiredAddons[]=
		{
			QGVAR(Compat_cTab) //- #LINK - addons/Compat_cTab/config.cpp
		};
		skipWhenMissingDependencies = 1;
		units[] = {};
		weapons[] = {};
		VERSION_CONFIG;
	};
};

//- Arma Configs
#include "Configs/UI_Elements.hpp"
#include "Configs/CfgVehicles.hpp"
#include "Configs/CfgFunctions.hpp"
#include "Configs/CfgEventHandlers.hpp"

//- Components
#include "Components\BCE_Mission_Build_Controls.hpp"

//- cTab controls
#include "UI\cTab_Macros.hpp"
#include "UI\cTab_Macros_Interface.hpp"
#include "UI\cTab_classes.hpp"
#include "UI\cTab_UI.hpp" //- cTab Interfaces
