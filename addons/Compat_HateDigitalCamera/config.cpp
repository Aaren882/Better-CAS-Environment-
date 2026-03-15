#include "script_component.hpp"

class CfgPatches {
	class ADDON {
		authors[] = {"Aaren"};
		url = ECSTRING(main,url);
		requiredVersion = REQUIRED_VERSION;
		//- #NOTE : Hate's Digital Camera
		requiredAddons[]=
		{
			"HATE_DSLR" 
		};
		skipWhenMissingDependencies = 1;
		units[] = {};
		weapons[] = {};
		VERSION_CONFIG;
	};
};

class CfgFunctions
{
	class HATE
	{
		class CAMERA
		{
			class takePicture
			{
				file = QPATHTOF(functions\fn_takePicture.sqf);
			};
		};
	};
};
