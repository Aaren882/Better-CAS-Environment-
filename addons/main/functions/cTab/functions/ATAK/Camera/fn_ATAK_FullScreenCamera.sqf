params [["_controllable_unit",false],"_Init_Cam"];

if (isNil {_Init_Cam}) then {
  _Init_Cam = "camera" camCreate [0,0,0];
};

if (_controllable_unit) then {
  _Init_Cam cameraEffect ["Internal", "Back","rttN"];
  switchCamera _Init_Cam;
} else {
  _Init_Cam cameraEffect ["Internal", "Back"];
};

cutText ["", "BLACK IN",0.5];

camUseNVG false;
false setCamUseTi 0;
false setCamUseTi 1;

cameraEffectEnableHUD true; 
showCinemaBorder false;

_Init_Cam