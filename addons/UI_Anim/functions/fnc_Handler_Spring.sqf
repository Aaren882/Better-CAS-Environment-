#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_UI_Anim_fnc_Handler_Spring
Description:
		Handles dynamic UI animation using a damped harmonic oscillator (spring physics model).
		This function runs asynchronously, calculating the target control's position over time.

Parameters:
		_ctrl           - The target UI control object to be animated. <CONTROL>
		_animType				- Identifier specifying the type or model of the animation to apply. <STRING>
		_anim_params		- Array containing physics and animation model parameters (e.g., "mass", "frequencyResponse", "damping", "duration", "frameRate"). <HASHMAP>
		_position_Param - Array containing positional and timing parameters. <ARRAY>
		_actions        - Array of callbacks/scripts to execute upon animation completion. <ARRAY>

Returns:
		<Script Handle> - A handle to the running asynchronous animation process.

Author:
		Aaren
---------------------------------------------------------------------------- */

params [
	["_ctrl", controlNull, [ controlNull ]],
	["_animType", nil, [ "" ]],
	["_anim_params", nil, [ createHashMap ]],
	["_position_Param", nil, [ [] ]],
	["_actions", nil, [ [] ]]
];
TRACE_1("fnc_Handler_Spring",_this);

private _get_data = {
	(_this apply {
		if (_x isEqualType []) then {
			_anim_params getOrDefault _x
		} else {
			_anim_params get _x
		};
	});
};

private _data = [
	"mass",
	"frequencyResponse",
	"damping",
	"duration",
	"frameRate",
	["initialPosition", -1],
	["initialVelocity", 0]
] call _get_data;

_data = [
	[_ctrl] + 
	_position_Param + 
	[_actions]
] + _data;

TRACE_1("fnc_Handler_Spring",_data);

private _handler = _data spawn {
	params ["_InitPackage","_mass","_frequencyResponse","_dampingRatio","_duration","_frameRate","_initialPosition","_initialVelocity"];
	_InitPackage params ["_ctrl","_Start_Point","_End_Point","",["_BG_IDC",0],"_actions"];
	
	//- Setup values
		private _arange = _duration * _frameRate;
		private _stiffness = (((2 * pi) / _frequencyResponse)^2) * _mass;
		private _undampedNaturalFrequency = sqrt(_stiffness / _mass);
		private _dampedNaturalFrequency = _undampedNaturalFrequency * sqrt(abs(1 - (_dampingRatio)^2));

		private _a = _undampedNaturalFrequency * _dampingRatio;
		private _b = _dampedNaturalFrequency;
		private _c = (_initialVelocity + _a * _initialPosition) / _b;
		private _d = _initialPosition;
		

		//- Flags
		private _Start = _Start_Point;
		private _End = _End_Point;
		_ctrl setVariable ["Animation_EndWithOffset_F", _End_Point];
		
	//- "_BG_IDC"
		private _backgroundPosition = [];
		private _BG_ctrl = if (_BG_IDC > 0) then {
			private _display = ctrlParent _ctrl;
			private _backgroundCtrl = _display displayCtrl _BG_IDC;
			_backgroundPosition = ctrlPosition _backgroundCtrl;
			_backgroundCtrl
		} else {
			controlNull
		};
	
	//- Walk through each point (on each frame)
	for "_t" from 0 to (1.5 * _arange) step 1 do {
		
		Sleep (1 / _frameRate);

		//- Result will approach >> 0 (solution: Y offset +1)
		// private _result = exp(-_a * t) * (_c * sin(_b * _t) + (_d * cos(_b * _t))) + 1;
		
		private _result = exp(-_a * _t) * (_c * sin deg(_b * _t) + (_d * cos deg(_b * _t))) - _initialPosition;
		private _Breakout = (_arange < _t) && (_d + _result < 0.00001); // -1 + 0.5 "(_initialPosition + _t)"

		//- Check if the value is too small
		if (_Breakout) then {
			_result = 1;
		};

		//- Static Position "[ X , Y ]"
			if !(isnull _BG_ctrl) then {
				private _offset = (ctrlPosition _BG_ctrl) vectorDiff _backgroundPosition;
				_Start = _Start_Point vectorAdd _offset;
				_End = _End_Point vectorAdd _offset;
			};

		// "_Start_Point" and "_End_Point" must be "[X, Y, W, H]"
			private _vecPos = [
				_Start,
				_End,
				_result
			] call BIS_fnc_lerpVector;
			{
				(_vecPos # (_x # 1)) call (_x # 0);
			} count _actions;
			_ctrl ctrlCommit 0;
		
		//- Finish all works and breakout
		if (_Breakout) then {break};
	};

	//- Completed
		//- Run CallBacks
		{
			_ctrl call _x;
		} count (_ctrl getVariable ["Animation_CallBack_onEnd", []]);

		//- Remove itself
			private _queue = _ctrl getVariable ["Animation_Queue",[]];
			_queue deleteAt 0;
			_ctrl setVariable ["Animation_Queue",_queue];
			//- Remove Offsets
			// _ctrl setVariable ["Animation_StartWithOffset_F", nil];
			_ctrl setVariable ["Animation_EndWithOffset_F", nil];
};

//- Return Handler
	_handler