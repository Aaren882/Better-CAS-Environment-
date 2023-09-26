private ["_cam","_optic_Vars","_OpticArray","_vehicle","_current_turret","_turret_Unit","_Optic_LODs"];

_cam = TGP_View_Camera # 0;

_optic_Vars = player getVariable "TGP_View_Selected_Optic";
_OpticArray = _optic_Vars # 0;
_vehicle = _optic_Vars # 1;

_current_turret = _OpticArray # 1;
_turret_Unit = _vehicle turretUnit _current_turret;
_Optic_LODs = [_vehicle,0] call BCE_fnc_Check_Optics;

if !((_turret_Unit getVariable ["TGP_View_Turret_Control",[]]) isEqualTo []) then {
  _Optic_LODs = _Optic_LODs select {!((_x # 1) isEqualTo [-1])};
};

_current_turret = _Optic_LODs find _OpticArray;

[_cam,_vehicle,_Optic_LODs,_current_turret]
