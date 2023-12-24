if !((hasPilotCamera cameraOn) || (Local cameraOn)) exitWith {};

if (
    (time > (BCE_TGP_LastUpdate + 0.035)) &&
    (
      (isLaserOn cameraOn) ||
      !(isMultiplayer) ||
      ({
        (
          ((_x getVariable ["TGP_View_EHs",-1]) != -1) ||
          ((_x getVariable ["cTab_TGP_View_EH",-1]) != -1) ||
          (_x getVariable ["BCE_TACMap_Visiable",false])
        ) &&
        (((_x getVariable ["TGP_View_Selected_Optic",[[],objNull]]) # 1) isEqualTo cameraOn)
      } count allUnits) > 0
    )
  ) then {
  BCE_TGP_LastUpdate = time;
  private _info = getPilotCameraTarget cameraOn;
  cameraOn setVariable ["BCE_Camera_Info_Air",[[_info # 0, _info # 1], getPilotCameraDirection cameraOn],true];
};
