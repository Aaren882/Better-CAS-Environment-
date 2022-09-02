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

if !(isNull findDisplay 1022553) then {
  closedialog 1022553;
};
