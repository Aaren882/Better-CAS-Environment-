params ["_position","_Marker_Cate","_Marker_Type","_id"];

private _SelIcon = [
  _position,
  _Marker_Cate,_id,0,
  call cTab_fnc_currentTime,
  cTab_player
];

[call cTab_fnc_getPlayerEncryptionKey,_SelIcon] call cTab_fnc_addUserMarker;