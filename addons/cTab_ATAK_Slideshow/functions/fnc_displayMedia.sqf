#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_cTab_ATAK_Slideshow_fnc_displayMedia
Description:
		Handles the display of various media types (IMAGE, VIDEO, WEB_LINK) within the slideshow.

Parameters:
		_slideshow_CtrlGroup  - controlGroup of slideshow <CONTROL>

Returns:
		<NONE>

Author:
		Aaren
---------------------------------------------------------------------------- */

params [["_slideshow_CtrlGroup",controlNull,[controlNull]]];
TRACE_1("fnc_displayMedia",_this);

if (isNull _slideshow_CtrlGroup) exitWith {
	ERROR_MSG("Error: Media players is null.");
};

private _mediaMap = missionNamespace getVariable [QEGVAR(cTab_ATAK_taskViewer,MediaData), createHashMap];
TRACE_1("fnc_displayMedia",_mediaMap);

if (count _mediaMap isEqualTo 0) exitWith {
	ERROR_MSG("Error: Media data is empty.");
};

private _media = _mediaMap get "Media";
private _mediaSel = _mediaMap get "Index";

private _selectedMedia = _media # _mediaSel;
//- Setup contents
_selectedMedia params ["_mediaType", "_content"];

//- #LINK - addons/cTab_ATAK_Slideshow/functions/fnc_onLoad.sqf
private _mediaPlayers = _slideshow_CtrlGroup getVariable ["MediaPlayers", createHashMap];
private _mediaPlayer = _mediaPlayers getOrDefault [_mediaType, controlNull];

//- Show MediaPlayer
{	_y ctrlShow (_x isEqualTo _mediaType) } forEach _mediaPlayers;

switch (_mediaType) do {
	case "IMAGE": {
		// _mediaPlayer ctrlSetText _content;

		//- CT_WEBBROWSER "IMAGE" -> #LINK - addons/cTab_ATAK_Slideshow/UI/elements.hpp
		(getTextureInfo _content) params ["_width", "_height"];

		private _content = _content; //- COPY _content
		_content = (_content splitString '\') joinString '\\';
		TRACE_3("fnc_displayMedia [IMAGE]",_content,_width,_height);

		localNamespace setVariable [QGVAR(JS), format ["setA3Texture('%1',%2,%3);",_content,_width,_height]];
		// _slideshow_CtrlGroup setVariable ["JS", format ["setA3Texture('%1',%2,%3);",_content,_width,_height]];
		
		// systemChat str ["fnc_displayMedia [IMAGE]",_content,_width,_height,time];
	};
	case "VIDEO": {
		_mediaPlayer ctrlSetText _content;
	};
	case "WEB_LINK": {
		//- Update Web UI
		/* _mediaPlayer setVariable ["GData", 
			addMissionEventHandler ['EachFrame', {
				_thisArgs params ["_disp", "_mediaPlayer"];

				if (!ctrlShown _mediaPlayer) exitWith {
					LOG("Web Link Frame Pop-ped !!");
					removeMissionEventHandler [_thisEvent, _thisEventHandler];
				};
				displayUpdate _disp;
				}, [ctrlParent _mediaPlayer, _mediaPlayer]
			]
		]; */
		_mediaPlayer ctrlSetURL _content;
	};
	default {
		ERROR_MSG_1("ERROR: Unknown media type '%1' found in slideshow ""fnc_onLoad"".",_mediaType);
	};
};
