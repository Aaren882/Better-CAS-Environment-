/*
	Author: Lala14

	Description:
	For external use by addon makers and such
	Returns the Vision as a string

	Note:
	LOCAL PER CLIENT

	Parameter(s):
	NIL

	Returns:
	STRING
	e.g.
	BHOT

  Edit by: Aaren (Fix return value)
*/

private _vmNumber = uiNameSpace getVariable ["A3TI_FLIR_VisionMode", nil];

private _visText = switch (_vmNumber) do {
	case (-3): {
		"BHOT/LLTV"
	};
	case (-2): {
		"WHOT/LLTV"
	};
	case (-1): {
		//"DTV"
		""
	};
	case (0): {
		"WHOT"
	};
	case (1): {
		"BHOT"
	};
};

_visText
