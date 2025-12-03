if((unitIsUAV _this) && (cameraView == "GUNNER") && (UAVControl _this select 1 == "GUNNER")) exitwith{true};
if((!(unitIsUAV _this)) && (cameraView == "GUNNER") && (_this getCargoIndex player == -1))	exitwith {true};

false
