params [["_ctrl",controlNull],"_animType",["_position_Param",[]],["_ignore",[]]];

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

//- Get data
  private _get_data = {
    //- If _Fade_Point is lower than 0 => Ignore _Fade_Point
      if (_Fade_Included) then {
        _actions pushBack [{_ctrl ctrlSetFade _this},4];
      };
    [
      [_ctrl] + 
      _position_Param + 
      [_actions]
    ] + (_this apply {
      if (_x isEqualType []) then {
        _anim_params getOrDefault _x
      } else {
        _anim_params get _x
      };
    });
  };

//- Run Animation
private _Spawn_handler = switch (_type) do {
  case "spring": {
    private _data = [
      "mass",
      "frequencyResponse",
      "damping",
      "duration",
      "frameRate",
      ["initialPosition", -1],
      ["initialVelocity", 0]
    ] call _get_data;

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
  };
  // default { };
};

//- Push Handler into Queue
_queue pushBack _Spawn_handler;
_ctrl setVariable ["Animation_Queue", _queue];

true
