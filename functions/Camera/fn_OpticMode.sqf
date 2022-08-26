params ["_type"];
_ViewMode = -1;

// PP effects
if (_type == 1) then
{
  ppEffectDestroy TGP_view_ppGrain;
};

if (_type == 2) then
{
  TGP_view_ppGrain = ppEffectCreate ["filmGrain",2005];
  TGP_view_ppGrain ppEffectEnable true;
  TGP_view_ppGrain ppEffectAdjust [0.02,1,1,0,1];
  TGP_view_ppGrain ppEffectCommit 0;
  camUseNVG false;
};
// FLIR text
_text = "";

// FLIR setting
switch (_type) do
{
  case 3:
  {
    _ViewMode = 0;
    true setCamUseTi _ViewMode;
    _text = "CMODE W-FLIR";
  };
  case 4:
  {
    _ViewMode = 1;
    true setCamUseTi _ViewMode;
    _text = "CMODE T-FLIR";
  };
  case 5:
  {
    false setCamUseTi _ViewMode;
    camUseNVG true;
    _text = "CMODE NVG";
  };
  default
  {
    false setCamUseTi 0;
    false setCamUseTi 1;
    _text = "CMODE NORMAL";
  };
};

((uiNameSpace getVariable "BCE_TGP") displayCtrl 1005) ctrlSetText _text;
