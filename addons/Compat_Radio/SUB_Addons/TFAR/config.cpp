#include "script_component.hpp"

class CfgPatches {
	class SUBADDON {
		authors[] = {"Aaren"};
		url = ECSTRING(main,url);
		addonRootClass = QUOTE(ADDON);
		requiredVersion = REQUIRED_VERSION;
		//- #NOTE : Task force Arrowhead Radio (Beta)
		requiredAddons[]=
		{
			"tfar_core"
		};
		skipWhenMissingDependencies = 1;
		units[] = {};
		weapons[] = {};
		VERSION_CONFIG;
	};
};


class CfgFunctions
{
  class BCE
  {
    class Radio_Compat
		{
      class getFreq_TFAR;
		};
  };
};