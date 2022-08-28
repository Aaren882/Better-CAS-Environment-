params ["_unit", "_cameraView"];
_Unit_veh = vehicle _unit;

if ((_Unit_veh iskindof "Air") and ((_Unit_veh getVariable ["AHUD_Actived",-1]) == -1) and (_cameraView == "GUNNER") and ((player getVariable ["TGP_View_EHs",-1]) == -1)) then {
  _AHUD_PFH = addMissionEventHandler ["Draw3D", {
    _vehicle = _thisArgs # 0;

    //Draw Compass
    if (([_vehicle] call BCE_fnc_filtered_compass) and (cameraOn == _vehicle) and (Acompass_fn)) then {
      call BCE_fnc_3DCompass;
    };
  }, [_Unit_veh]];
  _Unit_veh setVariable ["AHUD_Actived",_AHUD_PFH];
} else {
  removeMissionEventHandler ["Draw3D", (_Unit_veh getVariable ["AHUD_Actived",-1])];
  _Unit_veh setVariable ["AHUD_Actived",-1];
};
