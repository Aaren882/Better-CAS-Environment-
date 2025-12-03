#include "script_component.hpp"

class CfgPatches {
	class ADDON {
		authors[] = {"Aaren"};
		url = ECSTRING(main,url);
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[]=
		{
			"cTab",
			"ctab_core",
			"ctab_rangefinder",
			QGVARMAIN(Compat_cTab), //- Check for "BCE_Compat_cTab" #LINK - addons/Compat_cTab/config.cpp
			QGVARMAIN(Core) //- overwrite "BCE_Core" #LINK - addons/Core/config.cpp
		};
		skipWhenMissingDependencies = 1;
		units[] = {};
		weapons[] = {};
		VERSION_CONFIG;
	};
};

//- UI
#include "UI_Components.hpp"
#include "Configs\UI_Components.hpp"

//- Arma Configs
#include "Configs\CfgVehicles.hpp"
#include "Configs\CfgFunctions.hpp"
#include "Configs\CfgEventHandlers.hpp"

//- Components
class BCE_Mission_Default
{
	class AIR;
	class GND;
};
#include "..\Core\Components\Mission_Components.hpp"
// #include "Components\BCE_Mission_Build_Controls.hpp" #NOTE : Base classes of "BCE_Mission_Build_Controls"

//- Configurations
#include "UI\cTab_classes.hpp"
#include "UI\cTab_MarkersClasses.hpp" //- Map Markers for cTab

//- cTab Interfaces
#include "UI\cTab_UI.hpp"
#include "UI\Dialog.hpp"
