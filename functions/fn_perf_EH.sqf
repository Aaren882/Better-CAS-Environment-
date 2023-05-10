_idEH = addMissionEventHandler ["EachFrame", {
  _LaserLight_UnitList = missionNamespace getVariable ["IR_LaserLight_UnitList", []];
  if (count _LaserLight_UnitList != 0) then {
    _LaserLight_UnitList apply {
      if (_x call BCE_fnc_isLaserOn) then {
        _x call BCE_fnc_LaserDesignator;
      } else {
        call BCE_fnc_delete;
      }
    };
  };

  //-DoorGunner Laser Sync
  (allunits select {!(_x getVariable ["BCE_turret_Gunner_Laser",[]] isEqualTo [])}) apply {
    _x call BCE_fnc_gunnerLoop;
  };

  //-List Update
  if (time > (IR_LaserLight_UnitList_LastUpdate + 0.1)) then {
    IR_LaserLight_UnitList_LastUpdate = time;
    missionNamespace setVariable ["IR_LaserLight_UnitList", call BCE_fnc_IR_UnitList, true];
    missionNamespace setVariable ["TGP_View_Turret_List", (allunits + vehicles) select {!((_x getVariable ["TGP_View_Turret_Control",[]]) isEqualTo []) or (isUAVConnected _x) or ((_x getVariable ["AHUD_Actived",-1]) != -1)}, true];
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

  //-Remove Client Side Handler If Have Multiple Handlers
  private _EH = player getVariable ["IR_LaserLight_EachFrame_EH",-1];
  private _BCE_list = (allPlayers select {_x getVariable ["Have_BCE_Loaded",false]}) apply {str _x};
  _BCE_list sort true;

  if ((({(_x getVariable ["IR_LaserLight_EachFrame_EH",-1]) != -1} count allPlayers) > 1) && !((_BCE_list # 0) == str player)) then {
    call BCE_fnc_ClientSideLaser;
    player setVariable ["IR_LaserLight_EachFrame_EH",-1,true];
    removeMissionEventHandler ["EachFrame", _EH];
  };
}];

player setVariable ["IR_LaserLight_EachFrame_EH",_idEH,true];
