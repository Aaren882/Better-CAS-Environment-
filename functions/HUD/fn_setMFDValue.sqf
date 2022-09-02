_vehicle = vehicle player;

if !(_vehicle iskindof "Plane_Base_F") then {
  if (BCE_HUD_fn) then {
    _vehicle setUserMFDValue [5, 1];
  } else {
    _vehicle setUserMFDValue [5, 0];
  };

  //Sliders
  _vehicle setUserMFDValue [0, BCE_HUD_Color # 0];
  _vehicle setUserMFDValue [1, BCE_HUD_Color # 1];
  _vehicle setUserMFDValue [2, BCE_HUD_Color # 2];
  _vehicle setUserMFDValue [3, BCE_Alpha_sdr];
};
