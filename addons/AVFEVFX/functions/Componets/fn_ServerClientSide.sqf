#include "\MG8\AVFEVFX\cTab\has_cTab.hpp"

addMissionEventHandler ["EachFrame", {
  if (count IR_LaserLight_UnitList > 0) then {
    IR_LaserLight_UnitList apply {
      if (_x call BCE_fnc_isLaserOn) then {
        _x call BCE_fnc_LaserDesignator;
      } else {
        call BCE_fnc_deleteLaserDesignator;
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

    //-Remove Client Side Handler If Have Multiple Handlers
    private _Server_unit = _thisArgs # 0;
    private _BCE_list = (allPlayers select {_x getVariable ["Have_BCE_Loaded",false]}) apply {str _x;};
    _BCE_list sort true;

    //-if BCE_SYSTEM_Handler variable been deleted
    if (isnil {BCE_SYSTEM_Handler} or (BCE_SYSTEM_Handler == "")) then {
      missionNamespace setVariable ["BCE_SYSTEM_Handler",str _Server_unit,true];
    };

    if ((_BCE_list # 0) != str _Server_unit) then {
      call BCE_fnc_ClientSide;
      missionNamespace setVariable ["BCE_SYSTEM_Handler","",true];
      removeMissionEventHandler [_thisEvent, _thisEventHandler];
    };
  };

  //-TGP Update
  call BCE_fnc_UpdateCameraInfo;

  //-cTab Main System
  #ifdef cTAB_Installed
  private _cTabPlayer = missionNamespace getVariable ["BIS_fnc_moduleRemoteControl_unit",player];
    if (cTab_player != _cTabPlayer) then {
      cTab_player = _cTabPlayer;

      call cTab_fnc_close;
      call cTab_fnc_updateLists;
      call cTab_fnc_updateUserMarkerList;

      // remove msg notification
      cTabRscLayerMailNotification cutText ["", "PLAIN"];
    };
#endif
},[player]];

player setVariable ["Have_BCE_Loaded",true,true];
missionNamespace setVariable ["BCE_SYSTEM_Handler",str player,true];
