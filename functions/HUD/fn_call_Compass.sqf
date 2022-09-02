params ["_unit", "_cameraView"];
_Unit_veh = vehicle _unit;

if (
    (_Unit_veh iskindof "Air") &&
    ((_Unit_veh getVariable ["AHUD_Actived",-1]) == -1) &&
    (_cameraView == "GUNNER") &&
    ((_unit getVariable ["TGP_View_EHs",-1]) == -1) &&
    !((getText ([_Unit_veh, (_Unit_veh unitTurret _unit)] call BIS_fnc_turretConfig >> "turretInfoType")) in ["","RscWeaponZeroing"])
  ) then {

  _AHUD_PFH = addMissionEventHandler ["Draw3D", {
    _vehicle = _thisArgs # 0;
    _unit = _thisArgs # 1;

    //Draw Compass
    if ((cameraOn == _vehicle) && (BCE_compass_fn)) then {
      if (([_vehicle] call BCE_fnc_filtered_compass) && (player getVariable ["TGP_view_3D_Compass",true])) then {
        call BCE_fnc_3DCompass;
      };

      _time = _unit getVariable ["TGP_View_MapIcons_last",-1];
      _alpha = abs (1 min _time);
      if (_time != -1) then {
        call BCE_fnc_map_Icon;
      };
    };

    if (BCE_touchMark_fn) then {
      call BCE_fnc_touchMark;
    };

  }, [_Unit_veh,_unit]];
  _Unit_veh setVariable ["AHUD_Actived",_AHUD_PFH];
} else {
  removeMissionEventHandler ["Draw3D", (_Unit_veh getVariable ["AHUD_Actived",-1])];
  _Unit_veh setVariable ["AHUD_Actived",-1];
};
