_idEH = addMissionEventHandler ["EachFrame", {
  _LaserLight_UnitList = missionNamespace getVariable ["IR_LaserLight_UnitList", []];
  if (count _LaserLight_UnitList != 0) then {
    _LaserLight_UnitList apply {
      if (isLaserOn _x) then {
        _x call BCE_fnc_LaserDesignator;
      };
    };
  };

  //-Output TGP Dir (For current controling vehicle only)
  if (hasPilotCamera cameraOn) then {
    cameraOn setVariable ["BCE_Camera_DIR_Air",getPilotCameraDirection cameraOn,true];
  };

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
