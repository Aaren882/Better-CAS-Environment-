params ["_player", "_cameraView"];
_Unit_veh = vehicle _player;

_condition = if (count (allTurrets _Unit_veh) > 0) then {
  !((getText ([_Unit_veh, (_Unit_veh unitTurret _player)] call BIS_fnc_turretConfig >> "turretInfoType")) in ["","RscWeaponZeroing"])
} else {
  true
};
if (
    (_condition) &&
    (_Unit_veh iskindof "Air") &&
    ((_Unit_veh getVariable ["AHUD_Actived",-1]) == -1) &&
    (_cameraView == "GUNNER") &&
    ((_player getVariable ["TGP_View_EHs",-1]) == -1)
  ) then {

  _AHUD_PFH = addMissionEventHandler ["Draw3D", {
    _vehicle = _thisArgs # 0;
    _player = _thisArgs # 1;

    //Draw Compass
    if (cameraOn == _vehicle) then {
      if (([_vehicle] call BCE_fnc_filtered_compass) && (_player getVariable ["TGP_view_3D_Compass",true]) && (BCE_compass_fn)) then {
        call BCE_fnc_3DCompass;
      };

      _time = _player getVariable ["TGP_View_MapIcons_last",-1];
      _alpha = abs (1 min _time);
      if ((_time != -1) && (BCE_Mapicon_fn)) then {
        call BCE_fnc_map_Icon;
      };

      _boxActive = BCE_UnitTrack_fn;
      _friendlyActive = BCE_FriendlyTrack_fn;

      _cam = _vehicle;
      //Update UnitList
      if (_player getVariable ["TGP_View_Unit_List_update",time] <= time) then {
        call BCE_fnc_TGP_UnitList;
        _player setVariable ["TGP_View_Unit_List_update", time+1];
      };

      if (count TGP_View_Unit_List > 0) then {
        call BCE_fnc_Unit_Icon;
      };
    };

    if (BCE_touchMark_fn) then {
      call BCE_fnc_touchMark;
    };

  }, [_Unit_veh,_player]];
  _Unit_veh setVariable ["AHUD_Actived",_AHUD_PFH];
} else {
  removeMissionEventHandler ["Draw3D", (_Unit_veh getVariable ["AHUD_Actived",-1])];
  _Unit_veh setVariable ["AHUD_Actived",-1];
};
