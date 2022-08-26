_vehicle = vehicle player;

if !(_vehicle iskindof "Plane_Base_F") then {
  if (AHUD_fn) then {
    _vehicle setUserMFDValue [5, 1];
  } else {
    _vehicle setUserMFDValue [5, 0];
  };

  //Sliders
  _vehicle setUserMFDValue [0, A_Red_sdr];
  _vehicle setUserMFDValue [1, A_Green_sdr];
  _vehicle setUserMFDValue [2, A_Blue_sdr];
  _vehicle setUserMFDValue [3, A_Alpha_sdr];
};
