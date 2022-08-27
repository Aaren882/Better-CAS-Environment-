_cam = (player getVariable "TGP_View_Camera") # 0;

_optic_Vars = player getVariable "TGP_View_Selected_Optic";
_OpticArray = _optic_Vars # 0;
_vehicle = _optic_Vars # 1;

_Optic_LODs = if (player getVariable ["TGP_View_Turret_Control",false]) then {
  (_vehicle getVariable "TGP_View_Available_Optics") select {!((_x # 1) isEqualTo [])};
} else {
  _vehicle getVariable "TGP_View_Available_Optics";
};
_current_turret = _Optic_LODs find _OpticArray;

[_cam,_vehicle,_Optic_LODs,_current_turret]
