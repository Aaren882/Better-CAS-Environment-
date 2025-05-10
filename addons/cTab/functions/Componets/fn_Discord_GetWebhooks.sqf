if !(isMultiplayer) exitWith {};

[
  "BCE_SSE_Webhook_Send_fn","CHECKBOX",
  [localize "STR_BCE_Send_SSE_Pic_Send"],
  ["Better CAS Environment (cTab ATAK Camera)",localize "STR_BCE_Server_Side"],
  false,
  1
] call CBA_fnc_addSetting;

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
    ["Better CAS Environment (cTab ATAK Camera)",localize "STR_BCE_Server_Side"],
    [
      _list,
      _list apply {str _x},
      0
    ],
    1
  ] call CBA_fnc_addSetting;
};