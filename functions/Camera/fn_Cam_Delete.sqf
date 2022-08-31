_cam = TGP_View_Camera # 0;
_cam cameraeffect ["Terminate", "back"];
camDestroy _cam;
ppEffectDestroy (TGP_View_Camera # 1);

556 cutRsc ["default","PLAIN"];
cutText ["", "BLACK IN",0.5];

1.5 fadeSound 1;

_current_EH = player getVariable "TGP_View_EHs";
removeMissionEventHandler ["Draw3D", _current_EH];

player setVariable ["TGP_View_EHs",-1,true];
TGP_View_Camera = [];

_optic_Vars = player getVariable "TGP_View_Selected_Optic";
_OpticArray = _optic_Vars # 0;
_vehicle = _optic_Vars # 1;

_current_turret = _OpticArray # 1;
_turret_Unit = _vehicle turretUnit _current_turret;

if ((_turret_Unit getVariable ["TGP_View_Turret_Control",-1]) != -1) then {
  removeUserActionEventHandler ["defaultAction", "Activate", (_turret_Unit getVariable "TGP_View_Turret_Control")];
  _turret_Unit setVariable ["TGP_View_Turret_Control",-1,true];
};

if !(isNull findDisplay 1022553) then {
  closedialog 1022553;
};
