params ["_type"];

if (_type == 2) then {
	TGP_view_ppGrain = ppEffectCreate ["filmGrain",2005];
	TGP_view_ppGrain ppEffectEnable true;
	TGP_view_ppGrain ppEffectAdjust [0.02,1,1,0,1];
	TGP_view_ppGrain ppEffectCommit 0;
	camUseNVG false;
};

// FLIR text

// FLIR setting
private _text = switch (_type) do
{
	// #if __has_include("\A3TI\functions.hpp")
		case 0: {
			call A3TI_fnc_ppEffects;
			call A3TI_fnc_getA3TIVision;
		};
		case 1: {
			call A3TI_fnc_ppEffects;
			call A3TI_fnc_getA3TIVision;
		};
	// #endif
	case 3:	{
		false setCamUseTi -1;
		camUseNVG true;
		"NVG";
	};
	case 4:	{
		true setCamUseTi 0;
		"W-FLIR";
	};
	case 5:	{
		true setCamUseTi 1;
		"T-FLIR";
	};
	default	{
		false setCamUseTi 0;
		false setCamUseTi 1;
		"NORMAL";
	};
};

((uiNameSpace getVariable "BCE_TGP") displayCtrl 1005) ctrlSetText (format ["%1 %2", localize "STR_BCE_CMODE", _text]);
