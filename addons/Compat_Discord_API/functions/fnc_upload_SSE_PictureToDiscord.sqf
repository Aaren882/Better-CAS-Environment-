#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_Compat_Discord_API_fnc_upload_SSE_PictureToDiscord
Description:
		Uploads a screenshot taken via the BCE ScreenShot Extension to Discord using the Discord API.

Parameters:
		_fileDir  - Directory of the image file <OBJECT>
		_file  - The image file e.g. "myPicture.jpg" <OBJECT>

Returns:
		<BOOL>

Examples
		#LINK - addons/cTab/functions/ATAK/Camera/fn_ATAK_TakePicture.sqf

Author:
		Aaren
---------------------------------------------------------------------------- */

params ["_fileDir", "_file"];
TRACE_1("fnc_upload_SSE_PictureToDiscord",_this);

if !(BCE_SSE_Webhook_Send_fn || isNil "BCE_SSE_Webhook_list") exitWith {false};
INFO_1("Uploading SSE Picture To Discord. Params '%1'",_this);

[
	{
		params ["_fileDir","_fileName","_unit","_map"];
		([_unit] call BCE_fnc_getUnitParams) params ["","_unitName","_title"];

		//- Send Discord Message
		[
			BCE_SSE_Webhook_list,
			"",
			"",
			"",
			false,
			_fileDir,
			[
				//- Embeds
				[
					format [localize "STR_BCE_SSE_OPERATION_NAME", missionName], //- [Title]
					"", //- [Description]
					"", //- [color]
					true, //- [timestamp]
					"", //- [AuthorName]
					"", //- [AuthorUrl]
					"", //- [AuthorIconUrl]
					format ["attachment://%1", _fileName] //- [ImageUrl]
				]
			],
			[ //- Fields for each Embed
				[
					[localize "STR_BCE_SSE_SERVER_NAME", format["`%1`",serverName], false],
					[localize "STR_BCE_SSE_FROM", format ["```%1%2```", profileName, ["[" + _unitName + "]", ""] select (_unitName == "")],true],
					["", "",true],
					[format["“%1” :",_map], format ["```%1```", _unit call BIS_fnc_locationDescription],true],
					["","",false],
					[localize "STR_BCE_SSE_UNIT", format ["```%1```", [_title, localize "str_special_none"] select (_title == "")],true]
				]
			]
		] call DiscordAPI_fnc_sendMessage;
	}, 
	[
		_fileDir,
		_file,
		player,
		worldName
	], 1
] call CBA_fnc_waitAndExecute;

true