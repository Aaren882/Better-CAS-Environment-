if !(isMultiplayer) exitWith {};

//- initiate for Server and Client
0 spawn {
  waitUntil {!isNil{DiscordEmbedBuilder_Info}};
  
  private _infoVar = DiscordEmbedBuilder_Info;

  private _list = [];
  for "_i" from 0 to (count (_infoVar # 0)) - 1 do {
    _list pushBack _i;
  };

  [
    "BCE_SSE_Webhook_list", "LIST",
    [localize "STR_BCE_Select_Webhook_SSE","Server Side Only"],
    ["Better CAS Environment (cTab ATAK)"],
    [
      _list,
      _list apply {str _x},
      0
    ],
    1
  ] call CBA_fnc_addSetting;
};