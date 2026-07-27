#include "script_component.hpp"
// #include "XEH_PREP.hpp"

[
	QGVAR(UseExtension), "CHECKBOX",
	[
		"Extension Offload (*EXPERIMENTAL)",
		"Offload animation calculation to extension(x64).\n - This should reduce execution time between each frame."
	],
	["Better CAS Environment", "Animation Engine"],
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
