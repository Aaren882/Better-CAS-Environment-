params ["_ctrl","_animType",["_position_Param",[]],["_ignore",[]]];

if (_position_Param findIf {true} > 0 || isnull _ctrl) exitWith {
  false
};

private _instant = _position_Param param [2, false];

//- Exit on Instant Tramsform
if (_instant) exitWith {
  _ctrl ctrlSetPosition (_position_Param # 1);
  _ctrl ctrlCommit 0;
};

//- Setup Position
  private _Start_Point = _position_Param param [0, []];
  private _End_Point = _position_Param param [1, []];

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
  _position_Param set [0, _Start_Point];
  _position_Param set [1, _End_Point];

//- Get Animation Configuration
  private _params = _animType call BCE_fnc_Anim_Init;

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
    [[_ctrl] + _position_Param + [_actions]] + (_this apply {
      if (_x isEqualType []) then {
        _anim_params getOrDefault _x
      } else {
        _anim_params get _x
      };
    });
  };

private _queue = (_ctrl getVariable ["Animation_Queue",[]]) select {!isnull _x};

//- Remove Current Process
  if (_queue findIf {true} > -1) then {
    terminate (_queue # 0);
    _queue deleteAt 0;
  };

//- Run Animation
private _Spawn_handler = switch (_type) do {
  case "spring": {
    private _data = [
      "mass",
      "frequencyResponse",
      "damping",
      "arange",
      ["initialPosition", -1],
      ["initialVelocity", 0]
    ] call _get_data;

    private _handler = _data spawn {
      params ["_InitPackage","_mass","_frequencyResponse","_dampingRatio","_arange","_initialPosition","_initialVelocity"];

      _InitPackage params ["_ctrl","_Start_Point","_End_Point","",["_BG_IDC",0],"_actions"];
      
      //- Setup values
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
        // _ctrl setVariable ["Animation_StartWithOffset_F", _Start_Point];
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
      for "_t" from 0 to _arange step 1 do {
        
        uiSleep diag_deltaTime;

        //- Result will approach >> 0 (solution: Y offset +1)
        // private _result = exp(-_a * t) * (_c * sin(_b * _t) + (_d * cos(_b * _t))) + 1;
        private _result = [
          exp(-_a * _t) * (_c * sin deg(_b * _t) + (_d * cos deg(_b * _t))) - _initialPosition,
          1
        ] select (_t == _arange);

        //- Custom POS
          // private _CustomStartPOS = _ctrl getVariable ["Animation_StartWithOffset", []];
          // private _CustomEndPOS = _ctrl getVariable ["Animation_EndWithOffset", []];

        //- Check Flags
          // private _StartFlag = _ctrl getVariable ["Animation_StartWithOffset_F", []];
          // private _EndFlag = _ctrl getVariable ["Animation_EndWithOffset_F", []];

        //- Get End POS on Each iteration (Default Value [in case it got deleted])
          // private _End = _ctrl getVariable ["Animation_EndWithOffset_F", _End_Point];

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
            false
          } count _actions;
          _ctrl ctrlCommit 0;
      };

      //- Completed
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