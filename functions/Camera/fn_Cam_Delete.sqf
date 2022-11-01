#define have_ACE (isClass(configFile >> "CfgPatches" >> "ace_hearing"))

_cam = TGP_View_Camera # 0;
_cam cameraeffect ["Terminate", "back"];
camDestroy _cam;
ppEffectDestroy (TGP_View_Camera # 1);

556 cutRsc ["default","PLAIN"];
cutText ["", "BLACK IN",0.5];

if (have_ACE) then {
  if !(BCE_have_ACE_earPlugs) then {
    player setVariable ["ACE_hasEarPlugsIn", false, true];
    [[true]] call ace_hearing_fnc_updateVolume;
    [] call ace_hearing_fnc_updateHearingProtection;
  };
} else {
  1.5 fadeSound 1;
};

_current_EH = player getVariable "TGP_View_EHs";
removeMissionEventHandler ["Draw3D", _current_EH];

player setVariable ["TGP_View_EHs",-1,true];
TGP_View_Camera = [];

if !(isNull findDisplay 1022553) then {
  closedialog 1022553;
};
