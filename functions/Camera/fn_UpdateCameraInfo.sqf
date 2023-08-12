if (
    (time > (BCE_TGP_LastUpdate + 0.035)) &&
    (hasPilotCamera cameraOn) &&
    (
      (isLaserOn cameraOn) or
      ({
        (
          !(isMultiplayer) or
          ((_x getVariable ["TGP_View_EHs",-1]) != -1) or
          ((_x getVariable ["cTab_TGP_View_EH",-1]) != -1)
        ) &&
        (((_x getVariable ["TGP_View_Selected_Optic",[[],objNull]]) # 1) isEqualTo cameraOn)
      } count allUnits) > 0
    )
  ) then {
  BCE_TGP_LastUpdate = time;
  private _info = getPilotCameraTarget cameraOn;
  cameraOn setVariable ["BCE_Camera_Info_Air",[[_info # 0, _info # 1], getPilotCameraDirection cameraOn],true];
};
