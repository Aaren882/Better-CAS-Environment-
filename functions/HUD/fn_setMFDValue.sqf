_vehicle = vehicle player;

if !(_vehicle iskindof "Plane_Base_F") then {
  if (BCE_HUD_fn) then {
    _vehicle setUserMFDValue [11, 1];
  } else {
    _vehicle setUserMFDValue [11, 0];
  };

  //Sliders
  _vehicle setUserMFDValue [7, BCE_HUD_Color # 0];
  _vehicle setUserMFDValue [8, BCE_HUD_Color # 1];
  _vehicle setUserMFDValue [9, BCE_HUD_Color # 2];
  _vehicle setUserMFDValue [10, BCE_Alpha_sdr];
};
