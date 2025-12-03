#include "script_component.hpp"

class CfgPatches {
	class SUBADDON {
		authors[] = {"Aaren"};
		url = ECSTRING(main,url);
		addonRootClass = QUOTE(ADDON);
		requiredVersion = REQUIRED_VERSION;
		//- #NOTE : ACRE2
		requiredAddons[]=
		{
			QGVAR(ACRE_Compat), //- overwrite "BCE_Compat_Radio_ACRE_Compat"
			QGVARMAIN(cTab) 		//- overwrite "BCE_cTab"
		};
		skipWhenMissingDependencies = 1;
		units[] = {};
		weapons[] = {};
		VERSION_CONFIG;
	};
};

//- UI
class BCE_Mission_Build_Controls;
#include "..\cTab_UI_Components.hpp"
#include "UI\Control_UI.hpp"
