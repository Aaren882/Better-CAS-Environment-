#include "script_component.hpp"

class CfgPatches {
	class ADDON {
		authors[] = {"Aaren"};
		url = ECSTRING(main,url);
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[]=
		{
			"A3_Ui_F_Orange" 
		};
		units[] = {};
		weapons[] = {};
		VERSION_CONFIG;
	};
};

//- Use for intel sharing #LINK - https://community.bistudio.com/wiki/BIS_fnc_initLeaflet
class RscDisplayRead
{
	class Controls
	{
		class ButtonShowText;
		class ButtonTakePicture: ButtonShowText
		{
			idc=1006;
			show=1;
			text="Take Picture";
			x="safezoneX + safezoneW - (3 * 	6 + 1) * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			onButtonClick="private _screenshot = [] call BCE_fnc_screenShot; if (_screenshot isNotEqualTo []) then {[""bce_took_screenshot"", _screenshot] call CBA_fnc_localEvent;};";
		};
	};
};  
