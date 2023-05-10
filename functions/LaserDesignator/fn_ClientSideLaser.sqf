_idEH = addMissionEventHandler ["EachFrame", {
  _LaserLight_UnitList = missionNamespace getVariable ["IR_LaserLight_UnitList", []];
  if (count _LaserLight_UnitList != 0) then {
    _LaserLight_UnitList apply {
      if (_x call BCE_fnc_isLaserOn) then {
        _x call BCE_fnc_LaserDesignator;
      };
    };
  };

  //-DoorGunner Laser Sync
  (allunits select {!(_x getVariable ["BCE_turret_Gunner_Laser",[]] isEqualTo [])}) apply {
    _x call BCE_fnc_gunnerLoop;
  };

  //-TGP Update
  call BCE_fnc_UpdateCameraInfo;

  //-cTab Main System
  #if __has_include("\cTab\config.bin")
    if (cTab_player != (missionNamespace getVariable ["BIS_fnc_moduleRemoteControl_unit",player])) then {
      cTab_player = missionNamespace getVariable ["BIS_fnc_moduleRemoteControl_unit",player];

      call cTab_fnc_close;
      call cTab_fnc_updateLists;
  		call cTab_fnc_updateUserMarkerList;

      // remove msg notification
  		cTabRscLayerMailNotification cutText ["", "PLAIN"];
    };
  #endif

  //-Take Client Side Handler
  private _EH = player getVariable ["IR_LaserLight_EachFrame_EH_Client",-1];
  private _BCE_list = (allPlayers select {_x getVariable ["Have_BCE_Loaded",false]}) apply {str _x};
  _BCE_list sort true;

  if ((({(_x getVariable ["IR_LaserLight_EachFrame_EH",-1]) != -1} count allPlayers) == 0) && ((_BCE_list # 0) == str player)) then {
    call BCE_fnc_perf_EH;
    player setVariable ["IR_LaserLight_EachFrame_EH_Client",-1];
    removeMissionEventHandler ["EachFrame", _EH];
  };
}];
player setVariable ["IR_LaserLight_EachFrame_EH_Client",_idEH];
