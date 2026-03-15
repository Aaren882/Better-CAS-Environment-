#include "script_component.hpp"

#ifndef DEBUG_MODE_FULL
if !(isMultiplayer) exitWith {};
#endif

[
  "BCE_SSE_Webhook_Send_fn","CHECKBOX",
  [localize "STR_BCE_Send_SSE_Pic_Send"],
  ["Better CAS Environment (ScreenShot)",localize "STR_BCE_Server_Side"],
  false,
  1
] call CBA_fnc_addSetting;

["bce_took_screenshot", FUNC(upload_SSE_PictureToDiscord)] call CBA_fnc_addEventHandler;

//- initiate for Server and Client
0 spawn {
  waitUntil {!isNil{DiscordEmbedBuilder_Info}};
  
  private _infoVar = DiscordEmbedBuilder_Info # 0;

  private _list = [];
  for "_i" from 0 to (count _infoVar) - 1 do {
    _list pushBack _i;
  };

  //- Webhook Select
  [
    "BCE_SSE_Webhook_list", "LIST",
    [localize "STR_BCE_Select_Webhook_SSE"],
    ["Better CAS Environment (ScreenShot)",localize "STR_BCE_Server_Side"],
    [
      _list,
      _list apply {str _x},
      0
    ],
    1
  ] call CBA_fnc_addSetting;
};
