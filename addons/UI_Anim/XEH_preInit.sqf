#include "script_component.hpp"
// #include "XEH_PREP.hpp"

[
	QGVAR(UseExtension), "CHECKBOX",
	[
		LLSTRING(Extension_Offload_Title),
		LLSTRING(Extension_Offload_Tip)
	],
	["Better CAS Environment", LLSTRING(Setting_Category)],
	false,
	0, //- Local only
	{
		localNamespace setVariable [
			QFUNC(Handler_Spring),
			[
				COMPILE_FILE(functions\fnc_Handler_Spring),
				COMPILE_FILE(functions\fnc_Handler_SpringExtension)
			] select _this
		];
	}
] call CBA_fnc_addSetting;
