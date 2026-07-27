#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_UI_Anim_fnc_Handler_SpringExtension
Description:
		Handles the execution of a spring-based UI animation,
		interpolating the position of a UI control over a specified duration using frame rates and initial parameters.

Parameters:
		_ctrl           - The UI control object to be animated. <CONTROL>
		_animType				- Identifier specifying the type or model of the animation to apply. <STRING>
		_anim_params		- Array containing physics and animation model parameters (e.g., duration, frameRate, initialPosition). <HASHMAP>
		_position_Param - Array containing animation parameters. <ARRAY>
		_actions        - Array of actions or callbacks to execute upon animation completion. <ARRAY>

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
TRACE_1("fnc_Handler_SpringExtension",_this);

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
	"duration",
	"frameRate",
	["initialPosition", -1]
] call _get_data;

_data = [
	[_animType] +
	[_ctrl] + 
	_position_Param + 
	[_actions]
] + _data;

TRACE_1("fnc_Handler_SpringExtension",_data);

private _handler = _data spawn {
	params ["_InitPackage","_duration","_frameRate","_initialPosition"];
	_InitPackage params ["_animType","_ctrl","_Start_Point","_End_Point","",["_BG_IDC",0],"_actions"];
	
	//- Setup values
		private _arange = _duration * _frameRate;
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
		private _result = parseNumber (("bce_anim_engine" callExtension ["calculate", [_animType, _t]]) # 0);
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