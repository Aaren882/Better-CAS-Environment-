_idEH = addMissionEventHandler ["EachFrame", {
  _LaserLight_UnitList = missionNamespace getVariable ["IR_LaserLight_UnitList", []];
  if (count _LaserLight_UnitList != 0) then {
    _LaserLight_UnitList apply {
      if (isLaserOn _x) then {
        _x call BCE_fnc_LaserDesignator;
      } else {
        call BCE_fnc_delete;
      }
    };
  };

  //-Output TGP Dir (For current controling vehicle only)
  {
    if (hasPilotCamera cameraOn) then {
      cameraOn setVariable ["BCE_Camera_DIR_Air",getPilotCameraDirection cameraOn,true];
    };
  } remoteExec ["call", [0, -2] select isDedicated, true];

  if (time > (IR_LaserLight_UnitList_LastUpdate + 0.1)) then {
    IR_LaserLight_UnitList_LastUpdate = time;
    missionNamespace setVariable ["IR_LaserLight_UnitList", call BCE_fnc_IR_UnitList,true];
    missionNamespace setVariable ["TGP_View_Turret_List", (allunits + vehicles) select {!((_x getVariable ["TGP_View_Turret_Control",[]]) isEqualTo []) or (isUAVConnected _x) or ((_x getVariable ["AHUD_Actived",-1]) != -1)}, true];
  };

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
