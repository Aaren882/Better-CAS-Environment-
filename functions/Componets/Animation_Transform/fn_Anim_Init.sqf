params [["_animType",""]];

private _return = createHashMap;
private _config = configFile >> "Extended_Anim_transformation" >> _animType;
private _errorPop = false;

if (isclass _config) then {
  private _type = toLowerANSI getText (_config >> "type");
  private _props = configProperties [_config, "true"];

  private _data = createHashMapFromArray (_props apply {
    private _name = configname _x;
    private _value = call {
      if (isText _x) exitWith {getText _x};
      if (isNumber _x) exitWith {getNumber _x};
    };
    [_name,_value]
  });

  //- Check Type + Tweak values
  private _case = switch (_type) do {
    case "spring": {
      //- Components
        private _d = _data get "duration";
        private _f = _data get "frameRate";
        private _r = _data get "response";

      //- Error on "FrameRate <= 0"
        if (_f <= 0) exitwith {
          _errorPop = true;
          ["Invalid Animation frameRate ""frameRate = %1""",_f] call BIS_fnc_error;
        };

      _data set ["frequencyResponse", _r * (_f * _d)];
      0
    };
    default {
      -1
    };
  };

  //- If invalid type
  if (_case < 0) then {
    _errorPop = true;
    ["Invalid Animation Type ""type = %1""",_type] call BIS_fnc_error;
  } else {
    //- Valid Animation Type
    _return = createHashMapFromArray ([
      ["type",_type]
    ] + [
      ["params", _data]
    ]);
  };
};

[_return,nil] select _errorPop