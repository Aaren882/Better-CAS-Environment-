
//-input _vehicle
if (hasPilotCamera _vehicle) then {
  if (isMultiplayer) then {
    if (isplayer _vehicle) then {
      {
        cameraOn setVariable ["BCE_Camera_Info_Air",[getPilotCameraTarget cameraOn, getPilotCameraDirection cameraOn],true];
      } remoteExec ["call", _vehicle, true];
    };
  } else {
    _vehicle setVariable ["BCE_Camera_Info_Air",[getPilotCameraTarget _vehicle, getPilotCameraDirection _vehicle]];
  };
};
