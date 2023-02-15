/* _cam = TGP_View_Camera # 0;

_optic_Vars = player getVariable "TGP_View_Selected_Optic";
_OpticArray = _optic_Vars # 0;
_vehicle = _optic_Vars # 1;

_current_turret = _OpticArray # 1;
_turret_Unit = _vehicle turretUnit _current_turret;
_turret_Vars = _turret_Unit getVariable ["TGP_View_Turret_Control",[]];

_Optic_LODs = if !(_turret_Vars isEqualTo []) then {
  (
    (_vehicle getVariable "TGP_View_Available_Optics") select {
      private _unit = _vehicle turretUnit (_x # 1);

      !((_x # 1) isEqualTo []) &&
      ((_unit getVariable ["TGP_View_Turret_Control",[]]) isEqualTo [])
    }
  ) + [_OpticArray]
} else {
  _vehicle getVariable "TGP_View_Available_Optics"
};

_current_turret = _Optic_LODs find _OpticArray;

[_cam,_vehicle,_Optic_LODs,_current_turret] */

_cam = TGP_View_Camera # 0;

_optic_Vars = player getVariable "TGP_View_Selected_Optic";
_OpticArray = _optic_Vars # 0;
_vehicle = _optic_Vars # 1;

_current_turret = _OpticArray # 1;
_turret_Unit = _vehicle turretUnit _current_turret;

_Optic_LODs = if !((_turret_Unit getVariable ["TGP_View_Turret_Control",[]]) isEqualTo []) then {
  (_vehicle getVariable "TGP_View_Available_Optics") select {!((_x # 1) isEqualTo [])};
} else {
  _vehicle getVariable "TGP_View_Available_Optics";
};

_current_turret = _Optic_LODs find _OpticArray;

[_cam,_vehicle,_Optic_LODs,_current_turret]
