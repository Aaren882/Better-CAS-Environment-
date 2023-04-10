#define A_OPTICS ["","RscWeaponZeroing","RscOptics_Offroad_01","RscOptics_crows","RHS_RscWeaponZeroing_TurretAdjust"]
params ["_player", "_cameraView"];
_Unit_veh = cameraon;

//if !(_Unit_veh in vehicles) exitWith {};

_condition = if ((count (allTurrets _Unit_veh) > 0) && !((_Unit_veh isKindOf "UAV") or (_Unit_veh isKindOf "UAV_01_base_F"))) then {
  !((getText ([_Unit_veh, (_Unit_veh unitTurret _player)] call BIS_fnc_turretConfig >> "turretInfoType")) in A_OPTICS)
} else {
  true
};

if (
    (_condition) &&
    (_Unit_veh iskindof "Air") &&
    ((_player getVariable ["AHUD_Actived",-1]) == -1) &&
    (_cameraView == "GUNNER") &&
    ((_player getVariable ["TGP_View_EHs",-1]) == -1)
  ) then {

  _AHUD_PFH = addMissionEventHandler ["Draw3D", {
    _vehicle = _thisArgs # 0;
    _player = _thisArgs # 1;

    //Draw Compass
    if (cameraOn == _vehicle) then {
      if ((_vehicle call BCE_fnc_filtered_compass) && (_player getVariable ["TGP_view_3D_Compass",true]) && (BCE_compass_fn)) then {
        call BCE_fnc_3DCompass;
      };

      _time = _player getVariable ["TGP_View_MapIcons_last",-1];
      _alpha = abs (1 min _time);
      if ((_time != -1) && (BCE_Mapicon_fn)) then {
        call BCE_fnc_map_Icon;
      };
      if ((_player getVariable ["TGP_view_LandMark_Icon",true]) && (BCE_Landmarks_fn)) then {
        call BCE_fnc_LandMarks_icon;
      };

      _boxActive = BCE_UnitTrack_fn;
      _friendlyActive = BCE_FriendlyTrack_fn;

      _cam = _vehicle;

      //Update UnitList
      if (missionNamespace getVariable ["TGP_View_Unit_List_update", -1] <= time) then {
        call BCE_fnc_TGP_UnitList;
        missionNamespace setVariable ["TGP_View_Unit_List_update", time+1];
      };

      if (count TGP_View_Unit_List > 0) then {
        call BCE_fnc_Unit_Icon;
      };
    };

    if (BCE_touchMark_fn) then {
      call BCE_fnc_touchMark;
    };

    //-Exit
    if ((cameraView != "GUNNER") or (cameraon isEqualTo _player)) then {
      removeMissionEventHandler ["Draw3D", (_player getVariable ["AHUD_Actived",-1])];
      _player setVariable ["AHUD_Actived",-1,true];
    };

  }, [_Unit_veh,_player]];
  _player setVariable ["AHUD_Actived",_AHUD_PFH,true];
};
