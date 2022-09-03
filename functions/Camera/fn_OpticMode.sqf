params ["_type"];

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
    false setCamUseTi -1;
    camUseNVG true;
    _text = "NVG";
  };
  case 4:
  {
    true setCamUseTi 0;
    _text = "W-FLIR";
  };
  case 5:
  {
    true setCamUseTi 1;
    _text = "T-FLIR";
  };
  default
  {
    false setCamUseTi 0;
    false setCamUseTi 1;
    _text = "NORMAL";
  };
};

((uiNameSpace getVariable "BCE_TGP") displayCtrl 1005) ctrlSetText (format ["CMODE %1",_text]);
