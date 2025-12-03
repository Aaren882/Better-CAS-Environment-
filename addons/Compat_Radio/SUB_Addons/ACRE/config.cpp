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
			"acre_sys_core"
		};
		skipWhenMissingDependencies = 1;
		units[] = {};
		weapons[] = {};
		VERSION_CONFIG;
	};
};

//- UI
#include "..\UI_Components.hpp"

class BCE_Mission_Build_Controls
{
	class ButtonACRE_Racks;
	class ListACRE_Racks;
};
#include "UI\Control_UI.hpp"

class CfgFunctions
{
  class BCE
  {
    class Radio_Compat
		{
      class getFreq_ACRE;
      class setRacks_ACRE;
		};
  };
};
