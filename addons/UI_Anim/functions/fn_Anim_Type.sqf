#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_UI_Anim_fnc_Anim_Type
Description:
		Description.

Parameters:
		_param  - Parameter description <OBJECT>

Returns:
		Return description <NONE>

Examples
		(begin example)
				[params] call BCE_UI_Anim_fnc_Anim_Type
		(end)

Author:
		Aaren
---------------------------------------------------------------------------- */

params [["_ctrl",controlNull],"_animType",["_position_Param",[]],["_ignore",[]]];
TRACE_1("fnc_Anim_Type",_this);

if (_position_Param findIf {true} > 0 || isnull _ctrl) exitWith {
  false
};

private _instant = _position_Param param [2, false];

//- Setup Position
  private _Start_Point = _position_Param param [0, []];
  private _End_Point = _position_Param param [1, []];
  private _Fade_Point = _End_Point param [4, -1];
  private _Fade_Included = _Fade_Point > -1;

//- Remove Current Process
  private _queue = (_ctrl getVariable ["Animation_Queue",[]]) select {!isnull _x};
  if (_queue findIf {true} > -1) then {
    terminate (_queue # 0);
    _queue deleteAt 0;
  };

//- Exit on Instant Tramsformation
if (_instant) exitWith {
  _ctrl ctrlSetPosition (_End_Point select [0,4]);
  //- Set Fade
    if (_Fade_Included) then {
      _ctrl ctrlSetFade _Fade_Point;
    };
  _ctrl ctrlCommit 0;
};

//- Custom Position
  private _CustomStartPOS = _ctrl getVariable ["Animation_StartWithOffset", []];
  private _CustomEndPOS = _ctrl getVariable ["Animation_EndWithOffset", []];

  //- if "_Start_Point" = EMPTY ARRAY => Current position
  if (_Start_Point findIf {true} < 0) then {
    _Start_Point = ctrlPosition _ctrl;
  };

  //- Custom Posistions
    //- "Custom Start" is Exist
    if (_CustomStartPOS findIf {true} > -1) then {
      {
        if !(isnil {_x}) then {
          _Start_Point set [_forEachIndex, _x];
        };
      } forEach _CustomStartPOS;
    };
    // - "Custom End" is Exist
    if (_CustomEndPOS findIf {true} > -1) then {
      {
        if !(isnil {_x}) then {
          _End_Point set [_forEachIndex, _x];
        };
      } forEach _CustomEndPOS;
    };
  //- If "_Start_Point" doesn't have FadePoint
    if (_Fade_Included && count _Start_Point < 5) then {
      _Start_Point set [4, 1 - _Fade_Point];
    };
  _position_Param set [0, _Start_Point];
  _position_Param set [1, _End_Point];

//- Get Animation Configuration
  private _params = _animType call BCE_fnc_Anim_Init;

  //- Pop if _params is empty 
    if (isnil{_params}) exitWith {};

  private _type = toLowerANSI (_params getOrDefault ["type", ""]);
  private _anim_params = _params getOrDefault ["params", createHashMap];

//- Exit on Invalid Anim type
if (_type == "") exitWith {};

//- Check action
  private _actions = [
    [{_ctrl ctrlSetPositionX _this},0],
    [{_ctrl ctrlSetPositionY _this},1],
    [{_ctrl ctrlSetPositionW _this},2],
    [{_ctrl ctrlSetPositionH _this},3]
  ] select {
    !((_x # 1) in _ignore)
  };

//- If _Fade_Point is lower than 0 => Ignore _Fade_Point
	if (_Fade_Included) then {
		_actions pushBack [{_ctrl ctrlSetFade _this},4];
	};
	
//- Run Animation
private _Spawn_handler = switch (_type) do {
  case "spring": {
		[
			_ctrl,
			_animType,
			_anim_params,
			_position_Param,
			_actions
		] call (localNamespace getVariable [QFUNC(Handler_Spring), {}]);
  };
  // default { };
};

//- Push Handler into Queue
_queue pushBack _Spawn_handler;
_ctrl setVariable ["Animation_Queue", _queue];

true
