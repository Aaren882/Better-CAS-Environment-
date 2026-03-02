#include "\DSLR\functions\rsc\constants.h"
#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: HATE_fnc_takePicture
Description:
		Overwrite original "HATE_fnc_takePicture" function.

Parameters:
		_unit  - Camera man <OBJECT>

Returns:
		<NONE>
---------------------------------------------------------------------------- */

TRACE_1("fn_takePicture",_this);

private ["_unit","_screenshot"];
_unit = _this select 0;


if (cameraView == "gunner") then
{
	//Play shutter sound in 3D (for multiplayer reasons)
	[player, [hateShutterSound, 15, 1]] remoteExec ["say3D", 0, false];

	if (_unit getVariable [LALA_HATE_FLASH_ENABLED_VAR, LALA_HATE_FLASH_ENABLED_DEFAULT_VALUE]) then {
		//flash script
		DSLR_light = "#lightpoint" createVehicle getPos player;
		DSLR_light setLightBrightness 0.6;
		DSLR_light setLightAmbient [0.76,0.99,0.97];
		DSLR_light setLightColor [0.98,0.99,0.81];
		DSLR_light setLightUseFlare true;
		DSLR_light setLightFlareSize 2;
		DSLR_light setLightFlareMaxDistance 100;
		DSLR_light lightAttachObject [player,[0,.1,1.7]];
	};
	sleep .1;
	//Save screenshot to /profile directory/Screenshots with format YYYY_MM_DD_hh_mm_ss.png
	screenshot "";

	private _screenshot = [] call BCE_fnc_screenShot; //- Take picture
  if (_screenshot isNotEqualTo []) then {
		["bce_took_screenshot", _screenshot] call CBA_fnc_localEvent; //- upload to discord
	};
};

sleep 0.4;

private _dslr_light = missionNamespace getVariable ["DSLR_light", objNull];

if (!isNull _dslr_light) then {
	deleteVehicle DSLR_light;
};
