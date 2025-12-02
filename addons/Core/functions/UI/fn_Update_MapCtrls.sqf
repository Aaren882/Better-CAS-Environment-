params ["_displayOrControl","_index"];

private _unit = focusOn;
private _vars = uiNameSpace getVariable ["BCE_MainMap_Widget",
	[
		true,
		true,
		_unit call cTab_fnc_CheckMapIllumination
	]
];

if (_index < 0) exitWith {
	{
		private _ctrl = _displayOrControl displayCtrl _x;
		if (isNull _ctrl) then {continue};

		// - ACE map flashlight
		private _condition = [
			_vars # _forEachIndex,
			(
				_unit call cTab_fnc_CheckMapIllumination &&
				isNull ((_unit getVariable ["ace_map_flashlight", ["", objNull]]) # 1)
			)
		] select (_forEachIndex == 2);

		_ctrl ctrlSetBackgroundColor ([0,0,0,[0.5,1] select _condition]);
		_ctrl ctrlSetTextColor ([1,1,1,[0.5,1] select _condition]);

		//-POLPOX map tools
			if (_forEachIndex == 3) then {
				private ["_image","_h","_text"];

				_image = '<img image="\a3\3den\data\displays\display3den\toolbar\grid_rotation_off_ca.paa" align="center" size="1.0" />';
				_h = 2.3 * (0.85 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25));
				_text = format [
					'%1POLPOX Tools <br/><t align="left">Remastered :<t align="right" color="#edff24">%2</t></t>',
					_image,
					keyImage ((actionKeys "PLP_SMT_OpenTools") # 0)
				];
				_ctrl ctrlSetPositionH _h;
				_ctrl ctrlCommit 0;

				_ctrl ctrlEnable false;
				_ctrl ctrlSetBackgroundColor [0,0,0,0.3];
				_ctrl ctrlSetStructuredText parseText _text;
			};

	} forEach [1606,1607,1608,1609];
};

//-Set Variable
// - ACE map flashlight
	private _has_flashLight = _unit call cTab_fnc_CheckMapIllumination;
	private _toggle = [
		!(_vars # _index),
		(
			_has_flashLight &&
			!isNull ((_unit getVariable ["ace_map_flashlight", ["", objNull]]) # 1)
		)
	] select (_index == 2);

	//-Exit if there map illumination is disabled or no flashlight available
	if ((_index == 2) && !_has_flashLight) exitWith {
		systemChat localize "STR_BCE_Map_No_FlashLight";
	};

	if (_index == 2) then {
		[_unit, [([_unit] call ace_map_fnc_getUnitFlashlights) # 0, ""] select _toggle] call ace_map_fnc_switchFlashlight;
	};

_vars set [_index, _toggle];
uiNamespace setVariable ["BCE_MainMap_Widget",_vars];

//-Set Color
_displayOrControl ctrlSetBackgroundColor ([0,0,0,[0.5,1] select _toggle]);
_displayOrControl ctrlSetTextColor ([1,1,1,[0.5,1] select _toggle]);
