_vehicle = _this # 0;
if((unitIsUAV _vehicle) && (cameraView == "GUNNER") && (UAVControl _vehicle select 1 == "GUNNER")) exitwith{true};
if((!(unitIsUAV _vehicle)) &&(cameraView == "GUNNER") && (_vehicle getCargoIndex player == -1))  exitwith {true};

false
